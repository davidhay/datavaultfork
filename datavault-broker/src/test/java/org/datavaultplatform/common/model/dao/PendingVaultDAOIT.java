package org.datavaultplatform.common.model.dao;

import static org.datavaultplatform.broker.test.TestUtils.NOW;
import static org.datavaultplatform.broker.test.TestUtils.ONE_WEEK_AGO;
import static org.datavaultplatform.broker.test.TestUtils.TWO_WEEKS_AGO;
import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertNull;
import static org.junit.jupiter.api.Assertions.assertTrue;

import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;
import lombok.extern.slf4j.Slf4j;
import org.datavaultplatform.broker.app.DataVaultBrokerApp;
import org.datavaultplatform.broker.test.AddTestProperties;
import org.datavaultplatform.broker.test.BaseDatabaseTest;
import org.datavaultplatform.common.model.PendingVault;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.test.context.TestPropertySource;

@SpringBootTest(classes = DataVaultBrokerApp.class)
@AddTestProperties
@Slf4j
@TestPropertySource(properties = {
    "broker.email.enabled=false",
    "broker.controllers.enabled=false",
    "broker.rabbit.enabled=false",
    "broker.initialise.enabled=false",
    "broker.scheduled.enabled=false"
})
public class PendingVaultDAOIT extends BaseDatabaseTest {

  @Autowired
  PendingVaultDAO dao;

  @Autowired
  JdbcTemplate template;

  @Test
  void testWriteThenRead() {
    PendingVault pendingVault1 = getPendingVault1();

    PendingVault pendingVault2 = getPendingVault2();

    dao.save(pendingVault1);
    assertNotNull(pendingVault1.getId());
    assertEquals(1, count());

    dao.save(pendingVault2);
    assertNotNull(pendingVault2.getId());
    assertEquals(2, count());

    PendingVault foundById1 = dao.findById(pendingVault1.getId()).get();
    assertEquals(pendingVault1.getId(), foundById1.getId());

    PendingVault foundById2 = dao.findById(pendingVault2.getId()).get();
    assertEquals(pendingVault2.getId(), foundById2.getId());
  }

  @Test
  void testListIsSortedByAscendingCreationTime() {
    PendingVault pendingVault1 = getPendingVault1();

    PendingVault pendingVault2 = getPendingVault2();

    PendingVault pendingVault3 = getPendingVault3();

    dao.save(pendingVault1);
    assertNotNull(pendingVault1.getId());
    assertEquals(1, count());

    dao.save(pendingVault2);
    assertNotNull(pendingVault2.getId());
    assertEquals(2, count());

    dao.save(pendingVault3);
    assertNotNull(pendingVault3.getId());
    assertEquals(3, count());

    List<PendingVault> items = dao.list();
    assertEquals(3, items.size());
    assertEquals(1, items.stream().filter(dr -> dr.getId().equals(pendingVault1.getId())).count());
    assertEquals(1, items.stream().filter(dr -> dr.getId().equals(pendingVault2.getId())).count());
    assertEquals(1, items.stream().filter(dr -> dr.getId().equals(pendingVault3.getId())).count());

    // The PendingVaults should be ordered by Ascending CreationTime
    assertEquals(
        Arrays.asList(
            pendingVault3.getId(),
            pendingVault1.getId(),
            pendingVault2.getId()),
        items.stream().map(PendingVault::getId).collect(Collectors.toList()));
  }

  @Test
  void testUpdate() {
    PendingVault pendingVault1 = getPendingVault1();
    assertNull(pendingVault1.getId());
    dao.save(pendingVault1);
    assertNotNull(pendingVault1.getId());

    List<String> ids = template.query("select id from `PendingVaults`", (rs, rowNum) -> rs.getString(1));
    assertEquals(pendingVault1.getId(), ids.get(0));

    assertTrue(dao.findById(pendingVault1.getId()).isPresent());
    assertEquals(1, dao.count());

    pendingVault1.setName("111-updated");

    dao.update(pendingVault1);

    PendingVault found = dao.findById(pendingVault1.getId()).get();
    assertEquals(pendingVault1.getName(), found.getName());
  }

  @BeforeEach
  void setup() {
    assertEquals(0, count());
  }

  @AfterEach
  void cleanup() {
    template.execute("delete from `PendingVaults`");
    assertEquals(0, count());
  }

  private PendingVault getPendingVault1() {
    PendingVault pendingVault = new PendingVault();
    pendingVault.setName("111");
    pendingVault.setContact("contact-1");
    pendingVault.setCreationTime(ONE_WEEK_AGO);
    return pendingVault;
  }

  private PendingVault getPendingVault2() {
    PendingVault pendingVault = new PendingVault();
    pendingVault.setName("222");
    pendingVault.setContact("contact-2");
    pendingVault.setCreationTime(NOW);
    return pendingVault;
  }

  private PendingVault getPendingVault3() {
    PendingVault pendingVault = new PendingVault();
    pendingVault.setName("333");
    pendingVault.setContact("contact-3");
    pendingVault.setCreationTime(TWO_WEEKS_AGO);
    return pendingVault;
  }

  long count() {
    return dao.count();
  }
}