CREATE DATABASE  IF NOT EXISTS `notas` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `notas`;
-- MySQL dump 10.13  Distrib 5.7.25, for Linux (x86_64)
--
-- Host: 127.0.0.1    Database: notas
-- ------------------------------------------------------
-- Server version	5.7.25-0ubuntu0.16.04.2-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `auth_assignment`
--

DROP TABLE IF EXISTS `auth_assignment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_assignment` (
  `item_name` varchar(64) COLLATE utf8_bin NOT NULL,
  `user_id` varchar(64) COLLATE utf8_bin NOT NULL,
  `created_at` int(11) DEFAULT NULL,
  PRIMARY KEY (`item_name`,`user_id`),
  KEY `auth_assignment_user_id_idx` (`user_id`),
  CONSTRAINT `auth_assignment_ibfk_1` FOREIGN KEY (`item_name`) REFERENCES `auth_item` (`name`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_assignment`
--

LOCK TABLES `auth_assignment` WRITE;
/*!40000 ALTER TABLE `auth_assignment` DISABLE KEYS */;
INSERT INTO `auth_assignment` VALUES ('Desenvolvimento','4122a802-5ac6-11e8-86e0-0022b0615904',1527103838),('Desenvolvimento','c2f24278-0dd7-4f59-82a8-7662daaeb6a5',1527256996),
('Desenvolvimento','efea01a2-f88a-11e8-8a0a-e840f23aaf67',1527256999);
/*!40000 ALTER TABLE `auth_assignment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_item`
--

DROP TABLE IF EXISTS `auth_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_item` (
  `name` varchar(64) COLLATE utf8_bin NOT NULL,
  `type` smallint(6) NOT NULL,
  `description` text COLLATE utf8_bin,
  `rule_name` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `data` blob,
  `created_at` int(11) DEFAULT NULL,
  `updated_at` int(11) DEFAULT NULL,
  PRIMARY KEY (`name`),
  KEY `rule_name` (`rule_name`),
  KEY `type` (`type`),
  CONSTRAINT `auth_item_ibfk_1` FOREIGN KEY (`rule_name`) REFERENCES `auth_rule` (`name`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_item`
--

LOCK TABLES `auth_item` WRITE;
/*!40000 ALTER TABLE `auth_item` DISABLE KEYS */;
INSERT INTO `auth_item` VALUES ('Comercial Intersea',1,'Funcionários Intersea do departamento Comercial',NULL,NULL,1527100681,1527100681),('Comercial JC',1,'Funcionários Intersea do departamento Comercial JC',NULL,NULL,1527100711,1527100711),('Desenvolvimento',1,'Funcionários Intersea do departamento Desenvolvimento',NULL,NULL,1527100694,1527100694),('PROJ.Assumir solicitacao',2,'Assumir solicitação de orçamento para uma proposta comercial',NULL,NULL,1527103350,1527103350),('PROJ.Responder solicitacao',2,'Responder solicitação de orçamento para uma proposta comercial',NULL,NULL,1527103466,1527103466),('Projeto',1,'Funcionários Intersea do departamento Projeto',NULL,NULL,1527100721,1527100721),('Todos',1,'Todos os funcionários da Intersea',NULL,NULL,1527102068,1527102068),('atualizaPropriaNota',2,'Atualiza propria nota','eAutor',NULL,1527254889,1527254889);
/*!40000 ALTER TABLE `auth_item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_item_child`
--

DROP TABLE IF EXISTS `auth_item_child`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_item_child` (
  `parent` varchar(64) COLLATE utf8_bin NOT NULL,
  `child` varchar(64) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`parent`,`child`),
  KEY `child` (`child`),
  CONSTRAINT `auth_item_child_ibfk_1` FOREIGN KEY (`parent`) REFERENCES `auth_item` (`name`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `auth_item_child_ibfk_2` FOREIGN KEY (`child`) REFERENCES `auth_item` (`name`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_item_child`
--

LOCK TABLES `auth_item_child` WRITE;
/*!40000 ALTER TABLE `auth_item_child` DISABLE KEYS */;
INSERT INTO `auth_item_child` VALUES ('Desenvolvimento','Comercial Intersea'),('Desenvolvimento','Comercial JC'),('Projeto','PROJ.Assumir solicitacao'),('Desenvolvimento','Projeto'),('Comercial Intersea','Todos'),('Comercial JC','Todos'),('Desenvolvimento','Todos'),('Projeto','Todos'),('Desenvolvimento','atualizaPropriaNota');
/*!40000 ALTER TABLE `auth_item_child` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_rule`
--

DROP TABLE IF EXISTS `auth_rule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_rule` (
  `name` varchar(64) COLLATE utf8_bin NOT NULL,
  `data` blob,
  `created_at` int(11) DEFAULT NULL,
  `updated_at` int(11) DEFAULT NULL,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_rule`
--

LOCK TABLES `auth_rule` WRITE;
/*!40000 ALTER TABLE `auth_rule` DISABLE KEYS */;
INSERT INTO `auth_rule` VALUES ('eAutor',_binary 'O:18:\"app\\rbac\\AutorRule\":3:{s:4:\"name\";s:6:\"eAutor\";s:9:\"createdAt\";i:1527252582;s:9:\"updatedAt\";i:1527252582;}',1527252582,1527252582);
/*!40000 ALTER TABLE `auth_rule` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `categorias`
--

DROP TABLE IF EXISTS `categorias`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `categorias` (
  `id` varchar(36) COLLATE utf8_bin NOT NULL,
  `nome` varchar(100) CHARACTER SET utf8 NOT NULL,
  `descricao` tinytext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categorias`
--

LOCK TABLES `categorias` WRITE;
/*!40000 ALTER TABLE `categorias` DISABLE KEYS */;
INSERT INTO `categorias` VALUES ('02ba9b16-2e0f-11e9-82d3-e840f23aaf67','Yii2 úteis','Conhecimento Yii'),('1dcbdb3c-e660-11e8-b826-0022b0615904','Configurações do servidor Intranet','Configurações implementados no servidor Intranet'),('7e6d2ff2-e04a-11e8-a369-9cb70dd5210b','Diversas','Conteúdos diversos, necessita atenção para uma adequada classificação.'),('e801377e-e04a-11e8-8ea5-9cb70dd5210b','Comandos Linux','Comandos úteis do dia a dia.');
/*!40000 ALTER TABLE `categorias` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `files`
--

DROP TABLE IF EXISTS `files`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `files` (
  `id` varchar(36) COLLATE utf8_bin NOT NULL,
  `nome_arquivo` varchar(255) COLLATE utf8_bin NOT NULL,
  `path` tinytext COLLATE utf8_bin NOT NULL,
  `type` varchar(255) COLLATE utf8_bin NOT NULL,
  `size` int(11) unsigned DEFAULT NULL,
  `data_criacao` datetime DEFAULT CURRENT_TIMESTAMP,
  `fk_notas` varchar(36) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_files_1_idx` (`fk_notas`),
  CONSTRAINT `fk_files_to_notas` FOREIGN KEY (`fk_notas`) REFERENCES `notas` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `files`
--

LOCK TABLES `files` WRITE;
/*!40000 ALTER TABLE `files` DISABLE KEYS */;
INSERT INTO `files` VALUES ('16e1777e-fdf7-11e8-81f9-e840f23aaf67','SSH-sem-senha-root.pdf','files/16e1777e-fdf7-11e8-81f9-e840f23aaf67/SSH-sem-senha-root.pdf','application/pdf',226941,'2018-12-12 08:17:11','dff14d5c-fdf6-11e8-a30d-e840f23aaf67'),('340d46b4-fe44-11e8-b81c-e840f23aaf67','lsyncd-master.zip','files/340d46b4-fe44-11e8-b81c-e840f23aaf67/lsyncd-master.zip','application/zip',104753,'2018-12-12 17:29:12','98ffdbba-f6e0-11e8-901e-e840f23aaf67'),('3428e946-fe44-11e8-a4e0-e840f23aaf67','lua-5.3.5.tar.gz','files/3428e946-fe44-11e8-a4e0-e840f23aaf67/lua-5.3.5.tar.gz','application/gzip',303543,'2018-12-12 17:29:12','98ffdbba-f6e0-11e8-901e-e840f23aaf67'),('34424a12-fe44-11e8-a625-e840f23aaf67','psg-pro-001-controle-de-projetos.doc','files/34424a12-fe44-11e8-a625-e840f23aaf67/psg-pro-001-controle-de-projetos.doc','application/msword',178176,'2018-12-12 17:29:12','98ffdbba-f6e0-11e8-901e-e840f23aaf67'),('34594ae6-fe44-11e8-af0f-e840f23aaf67','ManagerSaaS-NFe-master.zip','files/34594ae6-fe44-11e8-af0f-e840f23aaf67/ManagerSaaS-NFe-master.zip','application/zip',204665,'2018-12-12 17:29:12','98ffdbba-f6e0-11e8-901e-e840f23aaf67'),('3471c0d0-fe44-11e8-b697-e840f23aaf67','InterSistema_20181101110117.zip','files/3471c0d0-fe44-11e8-b697-e840f23aaf67/InterSistema_20181101110117.zip','application/zip',241737,'2018-12-12 17:29:12','98ffdbba-f6e0-11e8-901e-e840f23aaf67'),('4b0c39d8-f7e1-11e8-b083-0022b0615904','Master Slave Replication.pdf','files/4b0c39d8-f7e1-11e8-b083-0022b0615904/Master Slave Replication.pdf','application/pdf',1339131,'2018-12-04 14:26:03','4ae93528-f7e1-11e8-a6b5-0022b0615904'),('4b58d4b4-f7e1-11e8-bd87-0022b0615904','MySQL Master-Master Replication.pdf','files/4b58d4b4-f7e1-11e8-bd87-0022b0615904/MySQL Master-Master Replication.pdf','application/pdf',777267,'2018-12-04 14:26:03','4ae93528-f7e1-11e8-a6b5-0022b0615904');
/*!40000 ALTER TABLE `files` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `migration`
--

DROP TABLE IF EXISTS `migration`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `migration` (
  `version` varchar(180) COLLATE utf8_bin NOT NULL,
  `apply_time` int(11) DEFAULT NULL,
  PRIMARY KEY (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `migration`
--

LOCK TABLES `migration` WRITE;
/*!40000 ALTER TABLE `migration` DISABLE KEYS */;
INSERT INTO `migration` VALUES ('m000000_000000_base',1527183344),('m160313_153426_session_init',1528120996),('m180524_172536_adicionar_coluna_criado_por',1527506311);
/*!40000 ALTER TABLE `migration` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `migration_base_conhecimento`
--

DROP TABLE IF EXISTS `migration_base_conhecimento`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `migration_base_conhecimento` (
  `version` varchar(180) COLLATE utf8_bin NOT NULL,
  `apply_time` int(11) DEFAULT NULL,
  PRIMARY KEY (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `migration_base_conhecimento`
--

LOCK TABLES `migration_base_conhecimento` WRITE;
/*!40000 ALTER TABLE `migration_base_conhecimento` DISABLE KEYS */;
/*!40000 ALTER TABLE `migration_base_conhecimento` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notas`
--

DROP TABLE IF EXISTS `notas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `notas` (
  `id` varchar(36) COLLATE utf8_bin NOT NULL,
  `titulo` varchar(100) CHARACTER SET utf8 NOT NULL,
  `conteudo` longtext CHARACTER SET utf8 NOT NULL,
  `criado_por` varchar(36) COLLATE utf8_bin DEFAULT NULL,
  `datahora_criado` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `atualizado_por` varchar(36) COLLATE utf8_bin DEFAULT NULL,
  `datahora_atualizado` datetime DEFAULT NULL,
  `fk_categoria` varchar(36) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk-nota-autor_id` (`criado_por`),
  KEY `fk_notas_categoria` (`fk_categoria`),
  CONSTRAINT `fk-nota-autor_id` FOREIGN KEY (`criado_por`) REFERENCES `users` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_notas_categoria` FOREIGN KEY (`fk_categoria`) REFERENCES `categorias` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notas`
--

LOCK TABLES `notas` WRITE;
/*!40000 ALTER TABLE `notas` DISABLE KEYS */;
INSERT INTO `notas` VALUES ('4ae93528-f7e1-11e8-a6b5-0022b0615904','Mysql replicação de banco de daods Master x Master e Master x Slave','<p>Instala&ccedil;&atilde;o MySQL para a replica&ccedil;&atilde;o, atrav&eacute; do apt-get, os softwares \"mysql-server-5.7\" e \"mysql-client-5.7\":</p>\r\n<p>Esses softwares dever&atilde;o ser instalados tanto no servidor MASTER quanto no servidor SLAVE:</p>\r\n<p><code>$ sudo apt-get install mysql-server-5.7 mysql-client-5.7</code></p>\r\n<p>Ap&oacute;s instala&ccedil;&atilde;o, editar o arquivo de configura&ccedil;&atilde;o do mysql \"/etc/mysql/my.cnf\", e adicionar as configura&ccedil;&otilde;es conforme abaixo, cada servidor da replica&ccedil;&atilde;o deve ter um \"server-id\" diferente:</p>\r\n<p><code>$ sudo nano /etc/mysql/my.cnf</code></p>\r\n<p><code>[mysqld]</code><br /><code>bind_address = *</code><br /><code>server-id = 1</code><br /><code>relay-log = /var/log/mysql/mysql-relay-bin.log</code><br /><code>log_bin = /var/log/mysql/mysql-bin.log</code><br /><code>binlog_do_db = intersea_bd</code><br /><code>binlog_do_db = desenvolvimento_bd</code><br /><code>binlog_do_db = jc_bd</code><br /><code>binlog_do_db = usuarios_bd</code></p>\r\n<p>Nota: O arquivo de configura&ccedil;&atilde;o do mysql \"/etc/mysql/my.cnf\" sobreescreve todas as configura&ccedil;&otilde;es dos demais arquivos, com exten&ccedil;&atilde;o \".cnf\",<br />armazenados nos diret&oacute;rios \"/etc/mysql/conf.d/\" e \"/etc/mysql/mysql.conf.d/\", nessa exata ordem. <br />Por tanto, &eacute; recomendavel centralizar as configura&ccedil;&otilde;es customizadas de banco somente no arquivo \"/etc/mysql/my.cnf\".</p>\r\n<p>A vari&aacute;vel \"bind_address\" especifica qual interface o servidor mysql responder&aacute; por conex&otilde;es, os aceit&aacute;veis valores s&atilde;o: \"*\" ou \"::\" todas interfaces IPv4 e IPv6; \"0.0.0.0\" somente interface IPv4; \"127.0.0.1\" aceita conex&atilde;o apenas local.</p>\r\n<p>- \"server-id\", especifica o identificador &uacute;nido do servidor.<br />- \"relay-log\" consiste nos eventos lidos no log bin&aacute;rio do mestre.<br />- \"log_bin\" especifica o caminho do arquivo de modifica&ccedil;&otilde;es realizada pelo servidor.<br />- \"binlog_do_db\" especifica qual banco de dados deve ser replicado, caso n&atilde;o especificado ser&aacute; replicado todos os schemas, se for especificado mais de um schema, deve copiar a vari&aacute;vel para uma nova linha.</p>\r\n<p>Para cada servidor master, ser&aacute; necess&aacute;rio criar usu&aacute;rio com permiss&atilde;o de replica&ccedil;&atilde;o, atrav&eacute;s dos seguintes comandos do mysql:</p>\r\n<p><code>mysql&gt; create user \'replicator\'@\'%\' identified by \'password\';</code><br /><code>mysql&gt; grant replication slave on *.* to \'replicator\'@\'%\';</code></p>\r\n<p>O comando abaixo apresenta o nome do arquivo bin&aacute;rio de log do servidor e sua posi&ccedil;&atilde;o, assim como os schemas que est&atilde;o sendo \"logados\". A informa&ccedil;&atilde;o \"File\" e \"Position\" ser&atilde;o utilizadas nas configura&ccedil;&otilde;es do servidor slave.<br /><code>mysql&gt;show master status;</code><br /><code>+------------------+----------+--------------+------------------+</code><br /><code>| File | Position | Binlog_Do_DB | Binlog_Ignore_DB |</code><br /><code>+------------------+----------+--------------+------------------+</code><br /><code>| mysql-bin.000001 | 107 | example | |</code><br /><code>+------------------+----------+--------------+------------------+</code><br /><code>1 row in set (0.00 sec)</code></p>\r\n<p>Ap&oacute;s as configura&ccedil;&otilde;es acima e restartar os servidores executar o comando abaixo, no prompt do mysql, para come&ccedil;ar a replica&ccedil;&atilde;o do escravo:</p>\r\n<p><code>mysql&gt;slave stop; </code><br /><code>mysql&gt;CHANGE MASTER TO MASTER_HOST = \'4.4.4.4\', MASTER_USER = \'replicator\', MASTER_PASSWORD = \'password\', MASTER_LOG_FILE = \'mysql-bin.000001\', MASTER_LOG_POS = 107; </code><br /><code>mysql&gt;slave start;</code></p>\r\n<p>O comando, especificado abaixo, apresenta informa&ccedil;&otilde;es sobre a replica do SLAVE:</p>\r\n<p><code>mysql&gt;show slave status;</code></p>\r\n<p>A coluna \"Slave_SQL_Running_State\" apresenta informa&ccedil;&otilde;es sobre o status atual da replica&ccedil;&atilde;o, como um erro que quebrou a replica&ccedil;&atilde;o.</p>\r\n<p>fontes:<br />- <a href=\"https://www.digitalocean.com/community/tutorials/how-to-set-up-mysql-master-master-replication\">https://www.digitalocean.com/community/tutorials/how-to-set-up-mysql-master-master-replication</a><br />- <a href=\"https://www.digitalocean.com/community/tutorials/how-to-set-up-master-slave-replication-in-mysql\">https://www.digitalocean.com/community/tutorials/how-to-set-up-master-slave-replication-in-mysql</a></p>\r\n<p>ⵖⵄⵖⵄⵖⵄⵖⵄⵖⵄⵖⵄⵖⵄⵖⵄⵖⵄⵖⵄⵖⵄⵖⵄⵖⵄⵖⵄⵖⵄⵖⵄⵖⵄⵖⵄⵖⵄⵖⵄⵖⵄⵖⵄⵖⵄⵖⵄⵖⵄⵖⵄⵖⵄⵖⵄⵖⵄⵖⵄⵖⵄⵖⵄⵖⵄⵖⵄ</p>','4122a802-5ac6-11e8-86e0-0022b0615904','2018-12-04 14:26:03','4122a802-5ac6-11e8-86e0-0022b0615904','2019-02-13 07:33:59','1dcbdb3c-e660-11e8-b826-0022b0615904'),('669f40de-2e0d-11e9-ac9e-e840f23aaf67','Yii2 cache schema','<p>Schema cache<br />db.config</p>\r\n<p>\'enableSchemaCache\'=&gt; true,<br />\'schemaCacheDuration\' =&gt;3600*24</p>','4122a802-5ac6-11e8-86e0-0022b0615904','2019-02-11 12:57:50','4122a802-5ac6-11e8-86e0-0022b0615904','2019-02-11 13:10:08','02ba9b16-2e0f-11e9-82d3-e840f23aaf67'),('69550362-14eb-11e9-834f-0022b0615904','inotify-tools monitorar ações em arquivos de um determinado diretório','<p>Instalando o Inotify-tools:</p>\r\n<p><code>sudo apt-get install inotify-tools</code></p>\r\n<p>executar o comando:</p>\r\n<p><code>inotifywait -m -r --format \"dir:%w %Xe file:%f %T\" --timefmt \'%d/%m/%Y %H:%M:%S\' /home/access_backend/</code></p>\r\n<p>op&ccedil;&atilde;o:</p>\r\n<p>\"<code>-m</code>\" executa em modo de monitoramento</p>\r\n<p>\"<code>-r</code>\" monitora o diret&oacute;rio recursivamente</p>\r\n<p><code>--format \"dir:%w %Xe file:%f %T\"</code>&nbsp;</p>\r\n<p style=\"padding-left: 30px;\">\"<code>%w</code>\" o diret&oacute;rio onde o evento ocorreu</p>\r\n<p style=\"padding-left: 30px;\">\"<code>%Xe</code>\" o evento ocorrido</p>\r\n<p style=\"padding-left: 30px;\">\"<code>%f</code>\" nome do arquivo onde o evento ocorreu</p>\r\n<p style=\"padding-left: 30px;\">\"<code>%T</code>\" tempo que ocorreu o evento, formatado atrav&eacute;s do parametro&nbsp;<code>--timefmt \'%d/%m/%Y %H:%M:%S\'</code></p>\r\n<p>Fonte:</p>\r\n<p><code>$ man inotifywait</code></p>\r\n<p><code></code></p>','4122a802-5ac6-11e8-86e0-0022b0615904','2019-01-10 13:21:32','4122a802-5ac6-11e8-86e0-0022b0615904','2019-01-10 13:26:14','e801377e-e04a-11e8-8ea5-9cb70dd5210b'),('90b13180-f888-11e8-9bf9-0022b0615904','Erro na Mysql replicação de banco de dados Master x Slave','<h2>Em caso de erro na replica&ccedil;ao mysql master x slave.</h2>\r\n<p>Ao iniciar a replica&ccedil;&atilde;o do Master, <strong>sem os schemas de banco de dados carregados</strong>, guardar as informa&ccedil;&otilde;es \"<strong>File</strong>\" e \"<strong>Position</strong>\" para <br />iniciar o servidor Slave, toda vez que houver necessidade de iniciar ou reiniciar a replica&ccedil;&atilde;o, usar essas informa&ccedil;&otilde;es \"<strong>File</strong>\" e \"<strong>Position</strong>\" que foram guardadas.<br />Ent&atilde;o carregar os schemas de banco de dados necess&aacute;rios (intersea_bd, usuarios_bd, ...) no servidor Master. Assim toda vez em que o servidor Slave for <br />inicializado, ir&aacute; criar todas as estruturas dos schemas e ir&aacute; carregar os dados at&eacute; o ponto atual do servidor Master. As informa&ccedil;&otilde;es, \"<strong>File</strong>\" e \"<strong>Position</strong>\", <br />s&atilde;o obtidas, pelo Workbanch ou no prompt do Mysql, com o comando abaixo:</p>\r\n<p><code>mysql&gt;show master status\\G</code></p>\r\n<p>Para checar status da replica&ccedil;&atilde;o no servidor slave, pelo Workbanch ou no prompt de comando do mysql:</p>\r\n<p><code>mysql&gt;SHOW SLAVE STATUS\\G</code></p>\r\n<p>Checar as vari&aacute;veis, do resultado do comando anterior, conforme o exemplo a seguir:</p>\r\n<p><code>Slave_IO_State: Waiting for master to send event</code><br /><code>Slave_IO_Running: Yes</code><br /><code>Slave_SQL_Running: Yes</code><br /><code>Last_IO_Error: </code><br /><code>Last_SQL_Error: </code><br /><code>Slave_SQL_Running_State: Slave has read all relay log; waiting for more updates</code></p>\r\n<p>Em caso de algum erro as vari&aacute;veis \"<strong>Last_IO_Error</strong>\" ou \"<strong>Last_SQL_Error</strong>\" estar&atilde;o preenchidas com a mensagem do erro. Em caso que o Slave estiver parado, sem erro, <br />as vari&aacute;veis \"<strong>Slave_IO_Running</strong>\" e \"<strong>Slave_SQL_Running</strong>\' estar&atilde;o com o valor \"<strong>No</strong>\".</p>\r\n<p>Para reinicializar o Slave, primeiro devemos parar o replica&ccedil;&atilde;o no Slave com o comando:</p>\r\n<p><code>mysql&gt;stop slave;</code></p>\r\n<p>Em seguida dropar todos os schemas, exceto os eschemas padr&otilde;es do mysql. Ent&atilde;o, posicionar a replica&ccedil;&atilde;o para o ponto inicial do Master, descrito no primeiro <br />par&aacute;grafo, usando o comando abaixo:</p>\r\n<p><code>mysql&gt;CHANGE MASTER TO MASTER_LOG_FILE = \'mysql-bin.000001\', MASTER_LOG_POS = 107;</code></p>\r\n<p>E inicializar a replica&ccedil;&atilde;o no Slave, usando o comando:</p>\r\n<p><code>mysql&gt;start slave;</code></p>\r\n<p>Dependendo do tamanha e quantidade de schemas no server Master, a replica&ccedil;&atilde;o para o Slave pode demorar alguns minutos.</p>','4122a802-5ac6-11e8-86e0-0022b0615904','2018-12-05 10:23:26',NULL,NULL,'1dcbdb3c-e660-11e8-b826-0022b0615904'),('98ffdbba-f6e0-11e8-901e-e840f23aaf67','Replicando e distribuindo armazenamento de arquivos Cluster (GlusterFs)','<p><span style=\"color: #333333; font-family: \'Helvetica Neue\', Helvetica, Arial, sans-serif; font-size: 16.8px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: #ffffff; text-decoration-style: initial; text-decoration-color: initial; display: inline !important; float: none;\"><a href=\"https://www.vivaolinux.com.br/artigo/Replicando-e-distribuindo-armazenamento-de-arquivos-atraves-de-quatro-servidores-usando-Cluster-(GlusterFs)-no-Debian-Lenny?pagina=1\">Replicando e distribuindo armazenamento de arquivos atrav&eacute;s de quatro servidores usando Cluster (GlusterFs) no Debian Lenny</a></span></p>\r\n<p><span style=\"color: #333333; font-family: \'Helvetica Neue\', Helvetica, Arial, sans-serif; font-size: 16.8px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: #ffffff; text-decoration-style: initial; text-decoration-color: initial; display: inline !important; float: none;\">Este artigo foi traduzido do site&nbsp;</span><a style=\"box-sizing: border-box; border-radius: 0px !important; background: 0px 0px #ffffff; color: #008318; text-decoration: none; outline: 0px !important; font-family: \'Helvetica Neue\', Helvetica, Arial, sans-serif; font-size: 16.8px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px;\" href=\"http://www.howtoforge.com/\" target=\"_blank\" rel=\"nofollow noopener\">www.howtoforge.com</a><span style=\"color: #333333; font-family: \'Helvetica Neue\', Helvetica, Arial, sans-serif; font-size: 16.8px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: #ffffff; text-decoration-style: initial; text-decoration-color: initial; display: inline !important; float: none;\">, o t&iacute;tulo original &eacute;:<a style=\"box-sizing: border-box; border-radius: 0px !important; background: 0px 0px #ffffff; color: #008318; text-decoration: none; outline: 0px !important; font-family: \'Helvetica Neue\', Helvetica, Arial, sans-serif; font-size: 16.8px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px;\" href=\"http://www.howtoforge.com/distributed-storage-across-four-storage-nodes-with-glusterfs-on-debian-lenny\" target=\"_blank\" rel=\"nofollow noopener\">Distributed Replicad Storage Across Four Storage Nodes With GlustersFS on Debian Lenny</a>&nbsp;<br /></span></p>','4122a802-5ac6-11e8-86e0-0022b0615904','2018-12-03 07:48:33','4122a802-5ac6-11e8-86e0-0022b0615904','2018-12-12 17:29:11','7e6d2ff2-e04a-11e8-a369-9cb70dd5210b'),('a8b488f4-e843-11e8-b61b-0022b0615904','Exemplo de ajax, consulta cnpj no www.receitaws.com.br','<p>C&oacute;digo javascript:</p>\r\n<p><code>$( \"document\" ).ready( function() { </code><br /><code>&nbsp; &nbsp; $(\'#id_sc_field_a2_cnpj\').off(\"blur\");</code><br /><code>&nbsp; &nbsp; $(\'#id_sc_field_a2_cnpj\').change( function() {</code><br /><code>&nbsp; &nbsp; &nbsp; &nbsp; if(!$(\'#id_sc_field_a2_cnpj\').val()) return null;</code><br /><code>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; $.ajax({</code><br /><code>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; url: \"https://www.receitaws.com.br/v1/cnpj/\"+Cnpj(),</code><br /><br /><code>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; // The name of the callback parameter, as specified by the YQL service</code><br /><code>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; jsonp: \"callback\",</code><br /><br /><code>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; // Tell jQuery we\'re expecting JSONP</code><br /><code>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; dataType: \"jsonp\",</code><br /><br /><code>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; // Work with the response</code><br /><code>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; success: function( response ) {</code><br /><code>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; if(response.status == \"ERROR\") {</code><br /><code>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; alert(response.message);</code><br /><code>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; } else {</code><br /><code>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; $(\'#id_sc_field_a2_cliente\').val(response.nome);</code><br /><code>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; $(\'#id_sc_field_a2_num\').val(response.numero);</code><br /><code>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; $(\'#id_sc_field_a2_end\').val(response.logradouro);</code><br /><code>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; $(\'#id_sc_field_a2_bairro\').val(response.bairro);</code><br /><code>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; $(\'#id_sc_field_a2_cidade\').val(response.municipio);</code><br /><code>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; $(\'#id_sc_field_a2_uf\').val(response.uf);</code><br /><code>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; }</code><br /><code>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; },</code><br /><code>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; statusCode: {</code><br /><code>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 429: function () {alert(\'n&uacute;mero m&aacute;ximo de consulta excedido.\');},</code><br /><code>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 404: function () {alert(\'Sem conex&atilde;o com internet ou n&uacute;mero m&aacute;ximo de consulta excedido.\');}</code><br /><code>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; }</code><br /><code>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; });</code><br /><code>&nbsp; &nbsp; &nbsp; &nbsp; });</code><br /><code>&nbsp; &nbsp; });</code><br /><br /><code>&nbsp; &nbsp; function Cnpj() {</code><br /><code>&nbsp; &nbsp; &nbsp; &nbsp; var cnpj_val = $(\'#id_sc_field_a2_cnpj\').val();</code><br /><code>&nbsp; &nbsp; &nbsp; &nbsp; cnpj_val = cnpj_val.replace(/[\\/\\.-]/g, \"\");</code><br /><code>&nbsp; &nbsp; &nbsp; &nbsp; console.log(cnpj_val);</code><br /><code>&nbsp; &nbsp; &nbsp; &nbsp; return cnpj_val;</code><br /><code>&nbsp; &nbsp; }</code><br /><code></code></p>','4122a802-5ac6-11e8-86e0-0022b0615904','2018-11-14 17:29:52','4122a802-5ac6-11e8-86e0-0022b0615904','2019-01-10 13:17:22','7e6d2ff2-e04a-11e8-a369-9cb70dd5210b'),('cedf86da-f227-11e8-bad5-e840f23aaf67','bit SetUID','<p>Para executar um script bash como root sem prompt de senha.<br />&Eacute; necess&aacute;rio ter as permiss&otilde;es bloqueadas neste arquivo por seguran&ccedil;a.</p>\r\n<p>Torne o arquivo de propriedade root e do grupo root:</p>\r\n<p><code>sudo chown root:root &lt;myscript&gt;</code></p>\r\n<p>Agora defina o bit SetUID, torne o arquivo execut&aacute;vel para todos usu&aacute;rios e apenas grav&aacute;vel pelo root:</p>\r\n<p><code>sudo chmod 4755 &lt;myscript&gt;</code></p>\r\n<p>O bit SetUID faz com que um script ou bin&aacute;rio seja sempre executado como o propriet&aacute;rio do script.</p>\r\n<p>&nbsp;</p>\r\n<p>fonte:<code><span style=\"color: #242729; font-family: Arial, \'Helvetica Neue\', Helvetica, sans-serif; font-size: 15px; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: #ffffff; text-decoration-style: initial; text-decoration-color: initial; display: inline !important; float: none;\"><br /><a href=\"https://askubuntu.com/questions/167847/how-to-run-bash-script-as-root-with-no-password\">how-to-run-bash-script-as-root-with-no-password</a></span></code></p>','4122a802-5ac6-11e8-86e0-0022b0615904','2018-11-27 07:35:42','4122a802-5ac6-11e8-86e0-0022b0615904','2019-01-10 13:29:40','e801377e-e04a-11e8-8ea5-9cb70dd5210b'),('dff14d5c-fdf6-11e8-a30d-e840f23aaf67','Como configurar o acesso SSH sem senha para o usuário root','<p>link:</p>\r\n<p><a href=\"https://askubuntu.com/questions/115151/how-to-set-up-passwordless-ssh-access-for-root-user#comment136374_115151\">https://askubuntu.com/questions/115151/how-to-set-up-passwordless-ssh-access-for-root-user#comment136374_115151</a></p>','4122a802-5ac6-11e8-86e0-0022b0615904','2018-12-12 08:15:39','4122a802-5ac6-11e8-86e0-0022b0615904','2018-12-12 08:17:11','1dcbdb3c-e660-11e8-b826-0022b0615904');
/*!40000 ALTER TABLE `notas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `session`
--

DROP TABLE IF EXISTS `session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `session` (
  `id` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `expire` int(11) DEFAULT NULL,
  `data` blob,
  PRIMARY KEY (`id`),
  KEY `expire` (`expire`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `session`
--

LOCK TABLES `session` WRITE;
/*!40000 ALTER TABLE `session` DISABLE KEYS */;
INSERT INTO `session` VALUES ('0656m4k7vr62vgbrf4khre5nh2',1541352498,_binary '__flash|a:0:{}__id|s:36:\"4122a802-5ac6-11e8-86e0-0022b0615904\";'),('1h905e1kpp8adhr97lg7l5r504',1543948578,_binary '__flash|a:0:{}'),('1vi6rg7i3secd34b2crteio8jt',1542230993,_binary '__flash|a:0:{}__id|s:36:\"4122a802-5ac6-11e8-86e0-0022b0615904\";'),('29262ghmge667p5v6usje3crso',1543318186,_binary '__flash|a:0:{}'),('3r3560ttofihcaq1gg377adnm6',1541455416,_binary '__flash|a:0:{}__id|s:36:\"4122a802-5ac6-11e8-86e0-0022b0615904\";'),('3s52ldn0a23h8ac2f44kfr3tj5',1541897431,_binary '__flash|a:0:{}__id|s:36:\"4122a802-5ac6-11e8-86e0-0022b0615904\";'),('4gs08sa15qqkhd4d903elkdeb3',1541536723,_binary '__flash|a:0:{}__id|s:36:\"4122a802-5ac6-11e8-86e0-0022b0615904\";'),('4mb047bln8g4ducpp7qo131fja',1547725095,_binary '__flash|a:0:{}__id|s:36:\"4122a802-5ac6-11e8-86e0-0022b0615904\";'),('5v3i8njeo3uf91glog6ls7dmul',1545220373,_binary '__flash|a:0:{}__returnUrl|s:31:\"/baseconhecimento/config/db.php\";'),('6lusobqv5bbd4mgejmro4vrjue',1542023762,_binary '__flash|a:0:{}__returnUrl|s:22:\"/baseconhecimento/web/\";__id|s:36:\"4122a802-5ac6-11e8-86e0-0022b0615904\";'),('7sppo6uq4h6pqokhej80tj0nt2',1541257191,_binary '__flash|a:0:{}__id|s:36:\"4122a802-5ac6-11e8-86e0-0022b0615904\";'),('8v85se2gdbdrisanns5p4brua5',1541448494,_binary '__flash|a:0:{}__id|s:36:\"4122a802-5ac6-11e8-86e0-0022b0615904\";'),('96bokc23j5memo95l7c5l1ugbg',1528229115,_binary '__flash|a:0:{}__returnUrl|s:9:\"/yii/web/\";__id|s:36:\"4122a802-5ac6-11e8-86e0-0022b0615904\";'),('9kju665po4ge50cosmht7n3hr3',1540776663,_binary '__flash|a:0:{}__id|s:36:\"4122a802-5ac6-11e8-86e0-0022b0615904\";'),('ai4cr9qs0ji89ah9vieu08jpda',1536063838,_binary '__flash|a:0:{}'),('c2tmme9f5vjf2g8s2ps17olgtg',1543838592,_binary '__flash|a:0:{}__id|s:36:\"4122a802-5ac6-11e8-86e0-0022b0615904\";'),('eblis09fq54kdlor95dub5on5v',1543948578,_binary '__flash|a:0:{}__returnUrl|s:22:\"/baseconhecimento/web/\";'),('f4rhbj04dvu0il2l46iqs3ri4r',1528744572,_binary '__flash|a:0:{}__id|s:36:\"4122a802-5ac6-11e8-86e0-0022b0615904\";'),('fn3hgd13r458jcgjlnm6npdvu5',1534166947,_binary '__flash|a:0:{}__returnUrl|s:5:\"/yii/\";__id|s:36:\"4122a802-5ac6-11e8-86e0-0022b0615904\";__captcha/site/captcha|s:7:\"eioyvpf\";__captcha/site/captchacount|i:1;'),('fna98qnj9udhs1f7n9vkajpfh2',1531137112,_binary '__flash|a:0:{}__returnUrl|s:9:\"/yii/web/\";__id|s:36:\"4122a802-5ac6-11e8-86e0-0022b0615904\";'),('gsbats9tqmgvhrnhmlr84la7b6',1541628968,_binary '__flash|a:0:{}__id|s:36:\"4122a802-5ac6-11e8-86e0-0022b0615904\";'),('h4s1lbgn7fjkti89jol5rc8ak5',1528123352,_binary '__flash|a:0:{}__returnUrl|s:9:\"/yii/web/\";__id|s:36:\"4122a802-5ac6-11e8-86e0-0022b0615904\";__captcha/site/captcha|s:7:\"kxjuzee\";__captcha/site/captchacount|i:1;'),('hkvsphj8oesi66g9t2qc028imj',1544702944,_binary '__flash|a:0:{}__id|s:36:\"4122a802-5ac6-11e8-86e0-0022b0615904\";'),('i9n32vu0vp4fpl5a6sn22rird3',1541448246,_binary '__flash|a:0:{}__id|s:36:\"4122a802-5ac6-11e8-86e0-0022b0615904\";'),('ibf54o78esjntlj5cfdbd3vf4h',1543319583,_binary '__flash|a:0:{}__returnUrl|s:18:\"/baseconhecimento/\";__id|s:36:\"4122a802-5ac6-11e8-86e0-0022b0615904\";'),('ihtha35f7bh9e3i7aucs52a0p1',1544022774,_binary '__flash|a:0:{}__id|s:36:\"4122a802-5ac6-11e8-86e0-0022b0615904\";'),('iprolund7cvjdpbv0khshl7vp2',1550069918,_binary '__flash|a:0:{}__id|s:36:\"4122a802-5ac6-11e8-86e0-0022b0615904\";'),('j9jmogn455vmu45ba9oelm6354',1539908428,_binary '__flash|a:0:{}__returnUrl|s:22:\"/baseconhecimento/web/\";'),('jj2vb059i98hhvpfatbpliphgs',1544013508,_binary '__flash|a:0:{}'),('jo10v0v4urruh068fccnti40sf',1543948778,_binary '__flash|a:0:{}__returnUrl|s:109:\"/baseconhecimento/web/index.php?r=baseConhecimento%2Fdefault%2Feditar&id=4ae93528-f7e1-11e8-a6b5-0022b0615904\";__captcha/site/captcha|s:7:\"zocoknw\";__captcha/site/captchacount|i:1;__id|s:36:\"4122a802-5ac6-11e8-86e0-0022b0615904\";'),('k2vfd93rjlc3ap89oteqv9diq5',1541536398,_binary '__flash|a:0:{}__id|s:36:\"4122a802-5ac6-11e8-86e0-0022b0615904\";'),('k4uj0nsj36lf9202nk1lemn2n7',1540744757,_binary '__flash|a:0:{}__returnUrl|s:22:\"/baseconhecimento/web/\";'),('kgqdqbepku6tcag294a5oe1e4j',1545220240,_binary '__flash|a:0:{}__returnUrl|s:22:\"/baseconhecimento/web/\";'),('klu3o9ug928a5kd1jlavnk5bnq',1536063837,_binary '__flash|a:0:{}__returnUrl|s:18:\"/yii/web/index.php\";'),('lt5ob8jc9ov621jdggv8fap5i1',1539909216,_binary '__flash|a:0:{}__returnUrl|s:31:\"/baseconhecimento/web/index.php\";__id|s:36:\"4122a802-5ac6-11e8-86e0-0022b0615904\";'),('m8kpv8v1d5b1qndjtdo2nn18s5',1547144220,_binary '__flash|a:0:{}__id|s:36:\"4122a802-5ac6-11e8-86e0-0022b0615904\";'),('mtslhasj019j6uh7dviqtvdqr1',1541967010,_binary '__flash|a:0:{}__returnUrl|s:22:\"/baseconhecimento/web/\";__id|s:36:\"4122a802-5ac6-11e8-86e0-0022b0615904\";'),('mvq9c3g1i4iu053ksjuna9ah63',1548440032,_binary '__flash|a:0:{}__id|s:36:\"4122a802-5ac6-11e8-86e0-0022b0615904\";'),('n0gp8ja7a66r2uv8030k0p5ja3',1543318185,_binary '__flash|a:0:{}__returnUrl|s:18:\"/baseconhecimento/\";'),('o8d5gihq216c970apd6b1eb1l3',1541544126,_binary '__flash|a:0:{}__id|s:36:\"4122a802-5ac6-11e8-86e0-0022b0615904\";'),('p6i5iot5mhct3b6gu65iouqfco',1537828051,_binary '__flash|a:0:{}__id|s:36:\"4122a802-5ac6-11e8-86e0-0022b0615904\";'),('pdcggl5viaojsl58hngv571832',1541368982,_binary '__flash|a:0:{}__id|s:36:\"4122a802-5ac6-11e8-86e0-0022b0615904\";'),('pdieuu7aa6d1abvbuvg60ajovr',1542886370,_binary '__flash|a:0:{}__id|s:36:\"4122a802-5ac6-11e8-86e0-0022b0615904\";'),('pocqpvj28a67enbu7en95gs73c',1535665172,_binary '__flash|a:0:{}__id|s:36:\"4122a802-5ac6-11e8-86e0-0022b0615904\";'),('pvr2ns5rjstfncdiujbq4uvin0',1540744757,_binary '__flash|a:0:{}'),('qf07olusok9gmjsemdu28grjf7',1539908428,_binary '__flash|a:0:{}'),('sbh6j83vc9h3f2i67k6b6et4a7',1541195863,_binary '__flash|a:0:{}__id|s:36:\"4122a802-5ac6-11e8-86e0-0022b0615904\";');
/*!40000 ALTER TABLE `session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id` varchar(36) COLLATE utf8_bin NOT NULL,
  `username` varchar(255) CHARACTER SET utf8 NOT NULL,
  `password` varchar(45) COLLATE utf8_bin NOT NULL,
  `auth_key` varchar(32) COLLATE utf8_bin NOT NULL,
  `password_reset_token` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES ('4122a802-5ac6-11e8-86e0-0022b0615904','VOLNEI','68781d2f6fee5092d2b06ef534529e3e6d8fc48f','123456',NULL),('78b9e38f-f88b-11e8-8a0a-e840f23aaf67','ADRIANO','7c4a8d09ca3762af61e59520943dc26494f8941b','123456',NULL),('c2f24278-0dd7-4f59-82a8-7662daaeb6a5','teste','68781d2f6fee5092d2b06ef534529e3e6d8fc48f','123456',NULL),('efea01a2-f88a-11e8-8a0a-e840f23aaf67','FELIPE','7c4a8d09ca3762af61e59520943dc26494f8941b','123456',NULL);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'notas'
--

--
-- Dumping routines for database 'notas'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2019-02-13 14:59:05
