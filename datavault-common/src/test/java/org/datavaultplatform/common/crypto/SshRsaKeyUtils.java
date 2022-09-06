package org.datavaultplatform.common.crypto;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileReader;
import java.io.InputStream;
import java.io.Reader;
import java.io.StringReader;
import java.math.BigInteger;
import java.nio.ByteBuffer;
import java.nio.charset.Charset;
import java.nio.file.Files;
import java.security.KeyFactory;
import java.security.KeyPair;
import java.security.Security;
import java.security.interfaces.RSAPrivateKey;
import java.security.interfaces.RSAPublicKey;
import java.security.spec.RSAPublicKeySpec;
import lombok.SneakyThrows;
import lombok.extern.slf4j.Slf4j;
import org.bouncycastle.jce.provider.BouncyCastleProvider;
import org.bouncycastle.openssl.PEMDecryptorProvider;
import org.bouncycastle.openssl.PEMEncryptedKeyPair;
import org.bouncycastle.openssl.PEMKeyPair;
import org.bouncycastle.openssl.PEMParser;
import org.bouncycastle.openssl.jcajce.JcaPEMKeyConverter;
import org.bouncycastle.openssl.jcajce.JcePEMDecryptorProviderBuilder;
import org.springframework.util.Base64Utils;
import org.springframework.util.StreamUtils;

/**
 * Utility class that reads Public/Private RSA Keys for SSH/SFTP from formatted Strings and Files
 */
@Slf4j
public class SshRsaKeyUtils {

  static {
    Security.addProvider(new BouncyCastleProvider());
  }

  @SneakyThrows
  public static RSAPrivateKey readPrivateKey(File privateKeyFile, String keyPassword) {
    return readPrivateKey(new FileReader(privateKeyFile), keyPassword);
  }

  @SneakyThrows
  public static RSAPrivateKey readPrivateKey(String privateKey, String keyPassword) {
    return readPrivateKey(new StringReader(privateKey), keyPassword);
  }

  @SneakyThrows
  public static RSAPrivateKey readPrivateKey(Reader privateKeyReader, String keyPassword) {
    PEMParser pemParser = new PEMParser(privateKeyReader);
    Object object = pemParser.readObject();
    final PEMKeyPair pemKeyPair;
    if (object instanceof PEMEncryptedKeyPair) {
      PEMDecryptorProvider decProv = new JcePEMDecryptorProviderBuilder().build(keyPassword.toCharArray());
      log.info("Encrypted key - will use provided password");
      pemKeyPair = ((PEMEncryptedKeyPair) object).decryptKeyPair(decProv);
    } else {
      log.info("Unencrypted key - no password needed");
      pemKeyPair = (PEMKeyPair) object;
    }
    JcaPEMKeyConverter converter = new JcaPEMKeyConverter().setProvider("BC");
    KeyPair kp = converter.getKeyPair(pemKeyPair);
    return (RSAPrivateKey) kp.getPrivate();
  }

  @SneakyThrows
  public static RSAPublicKey readPublicKey(File sshRsaFile) {
    // input stream of .pub file
    InputStream inputStream = Files.newInputStream(sshRsaFile.toPath());
    String sshRsaPublicKeySingleLine = StreamUtils.copyToString(inputStream, Charset.defaultCharset());
    return readPublicKey(sshRsaPublicKeySingleLine);
  }

  // TODO - There's probably a better way to do this.
  @SneakyThrows
  public static RSAPublicKey readPublicKey(String sshRsaPublicKeySingleLine) {
    String[] parts = sshRsaPublicKeySingleLine.split(" ");
    for (String part : parts) {
      if (part.startsWith("AAAA")) {
        byte[] decodeBuffer = Base64Utils.decode(part.getBytes());
        ByteBuffer bb = ByteBuffer.wrap(decodeBuffer);
        // using 4 bytes from bb to generate integer which gives us length of key -
        // format type, in this case len=7 as "ssh-rsa" has 7 chars
        int len = bb.getInt();
        byte[] type = new byte[len];
        bb.get(type);
        if ("ssh-rsa".equals(new String(type))) {
          // extracting exponent and modulus from remaining byte-buffer
          BigInteger exponent = decodeBigInt(bb);
          BigInteger modulus = decodeBigInt(bb);
          RSAPublicKeySpec spec = new RSAPublicKeySpec(modulus, exponent);
          return (RSAPublicKey)KeyFactory.getInstance("RSA").generatePublic(spec);
        } else {
          throw new IllegalArgumentException("Only supports RSA");
        }
      }
    }
    return null;
  }

  private static BigInteger decodeBigInt(ByteBuffer bb) {
    // use first 4 bytes to generate an Integer that gives the length of bytes to create BigInteger
    int len = bb.getInt();
    byte[] bytes = new byte[len];
    bb.get(bytes);
    return new BigInteger(bytes);
  }
}

