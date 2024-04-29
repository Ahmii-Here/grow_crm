-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Feb 24, 2024 at 06:33 PM
-- Server version: 10.11.7-MariaDB-cll-lve
-- PHP Version: 7.2.34

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `u817359048_maincrm`
--

-- --------------------------------------------------------

--
-- Table structure for table `attachments`
--

CREATE TABLE `attachments` (
  `attachment_id` int(11) NOT NULL,
  `attachment_uniqiueid` varchar(100) NOT NULL,
  `attachment_created` datetime DEFAULT NULL,
  `attachment_updated` datetime DEFAULT NULL,
  `attachment_creatorid` int(11) NOT NULL,
  `attachment_clientid` int(11) DEFAULT NULL COMMENT 'optional',
  `attachment_directory` varchar(100) NOT NULL,
  `attachment_filename` varchar(250) NOT NULL,
  `attachment_extension` varchar(20) DEFAULT NULL,
  `attachment_type` varchar(20) DEFAULT NULL COMMENT 'image | file',
  `attachment_size` varchar(30) DEFAULT NULL COMMENT 'Human readable file size',
  `attachment_thumbname` varchar(250) DEFAULT NULL COMMENT 'optional for images',
  `attachmentresource_type` varchar(50) NOT NULL COMMENT '[polymorph] task | expense | ticket | ticketreply',
  `attachmentresource_id` int(11) NOT NULL COMMENT '[polymorph] e.g ticket_id'
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='[truncate]' ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `automation_assigned`
--

CREATE TABLE `automation_assigned` (
  `automationassigned_id` int(11) NOT NULL,
  `automationassigned_created` datetime DEFAULT NULL,
  `automationassigned_updated` int(11) DEFAULT NULL,
  `automationassigned_userid` int(11) DEFAULT NULL,
  `automationassigned_resource_type` varchar(150) DEFAULT NULL COMMENT 'estimate|product_task',
  `automationassigned_resource_id` int(11) DEFAULT NULL COMMENT 'use ID 0, for system default users'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `category_id` int(11) NOT NULL COMMENT '[do not truncate] - only delete where category_system_default = no',
  `category_created` datetime DEFAULT NULL,
  `category_updated` datetime DEFAULT NULL,
  `category_creatorid` int(11) DEFAULT NULL,
  `category_name` varchar(150) DEFAULT NULL,
  `category_description` varchar(150) DEFAULT NULL COMMENT 'optional (mainly used by knowledge base)',
  `category_system_default` varchar(20) DEFAULT 'no' COMMENT 'yes | no (system default cannot be deleted)',
  `category_visibility` varchar(20) DEFAULT 'everyone' COMMENT 'everyone | team | client (mainly used by knowledge base)',
  `category_icon` varchar(100) DEFAULT 'sl-icon-docs' COMMENT 'optional (mainly used by knowledge base)',
  `category_type` varchar(50) NOT NULL COMMENT 'project | client | contract | expense | invoice | lead | ticket | item| estimate | knowledgebase',
  `category_slug` varchar(250) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='[do not truncate][system defaults] - 1=project,2=client,3lead,4=invoice,5=estimate,6=contract,7=expense,8=item,9=ticket, 10=knowledgebase, 11=proposal' ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`category_id`, `category_created`, `category_updated`, `category_creatorid`, `category_name`, `category_description`, `category_system_default`, `category_visibility`, `category_icon`, `category_type`, `category_slug`) VALUES
(1, '2024-02-15 21:57:55', '2024-02-15 21:57:55', 0, 'Default', NULL, 'yes', 'everyone', 'sl-icon-folder', 'project', '1-seo'),
(2, '2024-02-15 21:57:55', '2024-02-15 21:57:55', 0, 'Default', NULL, 'yes', 'everyone', 'sl-icon-folder', 'client', '2-default'),
(3, '2024-02-15 21:57:55', '2024-02-15 21:57:55', 0, 'Default', NULL, 'yes', 'everyone', 'sl-icon-folder', 'lead', '3-default'),
(4, '2024-02-15 21:57:55', '2024-02-15 21:57:55', 0, 'Default', NULL, 'yes', 'everyone', 'sl-icon-folder', 'invoice', '4-default'),
(5, '2024-02-15 21:57:55', '2024-02-15 21:57:55', 0, 'Default', NULL, 'yes', 'everyone', 'sl-icon-folder', 'estimate', '5-default'),
(6, '2024-02-15 21:57:55', '2024-02-15 21:57:55', 0, 'Default', NULL, 'yes', 'everyone', 'sl-icon-folder', 'contract', '6-default'),
(7, '2024-02-15 21:57:55', '2024-02-15 21:57:55', 0, 'Default', NULL, 'yes', 'everyone', 'sl-icon-folder', 'expense', '7-default'),
(8, '2024-02-15 21:57:55', '2024-02-15 21:57:55', 0, 'Default', NULL, 'yes', 'everyone', 'sl-icon-folder', 'item', '8-default'),
(9, '2024-02-15 21:57:55', '2024-02-15 21:57:55', 0, 'Support', NULL, 'yes', 'everyone', 'sl-icon-folder', 'ticket', '9-support'),
(10, '2024-02-15 21:57:55', '2024-02-15 21:57:55', 0, 'Frequently Asked Questions', 'Answers to some of the most frequently asked questions', 'yes', 'everyone', 'sl-icon-call-out', 'knowledgebase', '10-frequently-asked-questions'),
(11, '2024-02-15 21:57:55', '2024-02-15 21:57:55', 0, 'Default', NULL, 'yes', 'everyone', 'sl-icon-folder', 'proposal', '11-proposal'),
(60, '2024-02-15 21:57:55', '2024-02-15 21:57:55', 0, 'Default', NULL, 'yes', 'everyone', 'sl-icon-docs', 'subscription', 'subscription'),
(21, '2024-02-15 21:57:55', '2024-02-15 21:57:55', 0, 'Uncategorised', NULL, 'yes', 'everyone', 'sl-icon-folder', 'milestones', '1-uncategorised');

-- --------------------------------------------------------

--
-- Table structure for table `category_users`
--

CREATE TABLE `category_users` (
  `categoryuser_id` int(11) NOT NULL,
  `categoryuser_categoryid` int(11) NOT NULL,
  `categoryuser_userid` int(11) NOT NULL,
  `categoryuser_created` datetime NOT NULL,
  `categoryuser_updated` datetime NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci ROW_FORMAT=FIXED;

-- --------------------------------------------------------

--
-- Table structure for table `checklists`
--

CREATE TABLE `checklists` (
  `checklist_id` int(11) NOT NULL,
  `checklist_position` int(11) NOT NULL,
  `checklist_created` datetime NOT NULL,
  `checklist_updated` datetime NOT NULL,
  `checklist_creatorid` int(11) NOT NULL,
  `checklist_clientid` int(11) DEFAULT NULL,
  `checklist_text` text NOT NULL,
  `checklist_status` varchar(250) NOT NULL DEFAULT 'pending' COMMENT 'pending | completed',
  `checklistresource_type` varchar(50) NOT NULL,
  `checklistresource_id` int(11) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='[truncate]' ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `checklists`
--

INSERT INTO `checklists` (`checklist_id`, `checklist_position`, `checklist_created`, `checklist_updated`, `checklist_creatorid`, `checklist_clientid`, `checklist_text`, `checklist_status`, `checklistresource_type`, `checklistresource_id`) VALUES
(2, 1, '2024-02-19 23:04:32', '2024-02-19 23:04:36', 1, NULL, 'test', 'pending', 'lead', 1),
(3, 0, '2024-02-24 17:49:45', '2024-02-24 17:49:45', 0, NULL, '', 'pending', 'lead', 7),
(4, 0, '2024-02-24 17:49:45', '2024-02-24 17:49:45', 0, NULL, '', 'pending', 'lead', 7),
(5, 0, '2024-02-24 17:49:45', '2024-02-24 17:49:45', 0, NULL, '', 'pending', 'lead', 7),
(6, 0, '2024-02-24 17:49:45', '2024-02-24 17:49:45', 0, NULL, '', 'pending', 'lead', 7),
(7, 0, '2024-02-24 17:49:45', '2024-02-24 17:49:45', 0, NULL, '', 'pending', 'lead', 7),
(8, 0, '2024-02-24 17:49:45', '2024-02-24 17:49:45', 0, NULL, '', 'pending', 'lead', 7),
(9, 0, '2024-02-24 17:49:45', '2024-02-24 17:49:45', 0, NULL, '', 'pending', 'lead', 7),
(10, 0, '2024-02-24 17:49:45', '2024-02-24 17:49:45', 0, NULL, '', 'pending', 'lead', 7),
(11, 0, '2024-02-24 17:49:45', '2024-02-24 17:49:45', 0, NULL, '', 'pending', 'lead', 7),
(12, 0, '2024-02-24 17:49:45', '2024-02-24 17:49:45', 0, NULL, '', 'pending', 'lead', 7),
(13, 0, '2024-02-24 17:49:45', '2024-02-24 17:49:45', 0, NULL, '', 'pending', 'lead', 7),
(14, 0, '2024-02-24 17:49:45', '2024-02-24 17:49:45', 0, NULL, '', 'pending', 'lead', 7),
(15, 0, '2024-02-24 17:52:19', '2024-02-24 17:52:19', 0, NULL, 'Survey Conducted.', 'pending', 'lead', 8),
(16, 0, '2024-02-24 17:52:19', '2024-02-24 17:52:19', 0, NULL, 'DWP sent.', 'pending', 'lead', 8),
(17, 0, '2024-02-24 17:52:19', '2024-02-24 17:52:19', 0, NULL, 'Survey Photos Validated.', 'pending', 'lead', 8),
(18, 0, '2024-02-24 17:52:19', '2024-02-24 17:52:19', 0, NULL, 'Documents Checked.', 'pending', 'lead', 8),
(19, 0, '2024-02-24 17:52:19', '2024-02-24 17:52:19', 0, NULL, 'Floor Plan Prepared.', 'pending', 'lead', 8),
(20, 0, '2024-02-24 17:52:19', '2024-02-24 17:52:19', 0, NULL, 'Ofgem Required.', 'pending', 'lead', 8),
(21, 0, '2024-02-24 17:52:19', '2024-02-24 17:52:19', 0, NULL, 'DWP Received.', 'pending', 'lead', 8),
(22, 0, '2024-02-24 17:52:19', '2024-02-24 17:52:19', 0, NULL, 'EPR Prepared', 'pending', 'lead', 8),
(23, 0, '2024-02-24 17:52:19', '2024-02-24 17:52:19', 0, NULL, 'Under Install', 'pending', 'lead', 8),
(24, 0, '2024-02-24 17:52:19', '2024-02-24 17:52:19', 0, NULL, 'Installation Completed', 'pending', 'lead', 8),
(25, 0, '2024-02-24 17:52:19', '2024-02-24 17:52:19', 0, NULL, 'Under Submission', 'pending', 'lead', 8),
(26, 0, '2024-02-24 17:52:19', '2024-02-24 17:52:19', 0, NULL, 'Project Completed', 'pending', 'lead', 8);

-- --------------------------------------------------------

--
-- Table structure for table `clients`
--

CREATE TABLE `clients` (
  `client_id` int(11) NOT NULL,
  `client_importid` varchar(100) DEFAULT NULL,
  `client_created` datetime DEFAULT NULL,
  `client_updated` datetime DEFAULT NULL,
  `client_creatorid` int(11) NOT NULL,
  `client_created_from_leadid` int(11) NOT NULL COMMENT 'the lead that the customer was created from',
  `client_categoryid` int(11) DEFAULT 2 COMMENT 'default category',
  `client_company_name` varchar(150) NOT NULL,
  `client_description` text DEFAULT NULL,
  `client_phone` varchar(50) DEFAULT NULL,
  `client_logo_folder` varchar(50) DEFAULT NULL,
  `client_logo_filename` varchar(50) DEFAULT NULL,
  `client_website` varchar(250) DEFAULT NULL,
  `client_vat` varchar(50) DEFAULT NULL,
  `client_billing_street` varchar(200) DEFAULT NULL,
  `client_billing_city` varchar(100) DEFAULT NULL,
  `client_billing_state` varchar(100) DEFAULT NULL,
  `client_billing_zip` varchar(50) DEFAULT NULL,
  `client_billing_country` varchar(100) DEFAULT NULL,
  `client_shipping_street` varchar(250) DEFAULT NULL,
  `client_shipping_city` varchar(100) DEFAULT NULL,
  `client_shipping_state` varchar(100) DEFAULT NULL,
  `client_shipping_zip` varchar(50) DEFAULT NULL,
  `client_shipping_country` varchar(100) DEFAULT NULL,
  `client_status` varchar(50) NOT NULL DEFAULT 'active' COMMENT 'active|suspended',
  `client_app_modules` varchar(50) DEFAULT 'system' COMMENT 'system|custom',
  `client_settings_modules_projects` varchar(50) DEFAULT 'enabled' COMMENT 'enabled|disabled',
  `client_settings_modules_invoices` varchar(50) DEFAULT 'enabled' COMMENT 'enabled|disabled',
  `client_settings_modules_payments` varchar(50) DEFAULT 'enabled' COMMENT 'enabled|disabled',
  `client_settings_modules_knowledgebase` varchar(50) DEFAULT 'enabled' COMMENT 'enabled|disabled',
  `client_settings_modules_estimates` varchar(50) DEFAULT 'enabled' COMMENT 'enabled|disabled',
  `client_settings_modules_subscriptions` varchar(50) DEFAULT 'enabled' COMMENT 'enabled|disabled',
  `client_settings_modules_tickets` varchar(50) DEFAULT 'enabled' COMMENT 'enabled|disabled',
  `client_import_first_name` varchar(100) DEFAULT NULL COMMENT 'used during import',
  `client_import_last_name` varchar(100) DEFAULT NULL COMMENT 'used during import',
  `client_import_email` varchar(100) DEFAULT NULL COMMENT 'used during import',
  `client_import_job_title` varchar(100) DEFAULT NULL COMMENT 'used during import',
  `client_custom_field_1` tinytext DEFAULT NULL,
  `client_custom_field_2` tinytext DEFAULT NULL,
  `client_custom_field_3` tinytext DEFAULT NULL,
  `client_custom_field_4` tinytext DEFAULT NULL,
  `client_custom_field_5` tinytext DEFAULT NULL,
  `client_custom_field_6` tinytext DEFAULT NULL,
  `client_custom_field_7` tinytext DEFAULT NULL,
  `client_custom_field_8` tinytext DEFAULT NULL,
  `client_custom_field_9` tinytext DEFAULT NULL,
  `client_custom_field_10` tinytext DEFAULT NULL,
  `client_custom_field_11` datetime DEFAULT NULL,
  `client_custom_field_12` datetime DEFAULT NULL,
  `client_custom_field_13` datetime DEFAULT NULL,
  `client_custom_field_14` datetime DEFAULT NULL,
  `client_custom_field_15` datetime DEFAULT NULL,
  `client_custom_field_16` datetime DEFAULT NULL,
  `client_custom_field_17` datetime DEFAULT NULL,
  `client_custom_field_18` datetime DEFAULT NULL,
  `client_custom_field_19` datetime DEFAULT NULL,
  `client_custom_field_20` datetime DEFAULT NULL,
  `client_custom_field_21` text DEFAULT NULL,
  `client_custom_field_22` text DEFAULT NULL,
  `client_custom_field_23` text DEFAULT NULL,
  `client_custom_field_24` text DEFAULT NULL,
  `client_custom_field_25` text DEFAULT NULL,
  `client_custom_field_26` text DEFAULT NULL,
  `client_custom_field_27` text DEFAULT NULL,
  `client_custom_field_28` text DEFAULT NULL,
  `client_custom_field_29` text DEFAULT NULL,
  `client_custom_field_30` text DEFAULT NULL,
  `client_custom_field_31` varchar(20) DEFAULT NULL,
  `client_custom_field_32` varchar(20) DEFAULT NULL,
  `client_custom_field_33` varchar(20) DEFAULT NULL,
  `client_custom_field_34` varchar(20) DEFAULT NULL,
  `client_custom_field_35` varchar(20) DEFAULT NULL,
  `client_custom_field_36` varchar(20) DEFAULT NULL,
  `client_custom_field_37` varchar(20) DEFAULT NULL,
  `client_custom_field_38` varchar(20) DEFAULT NULL,
  `client_custom_field_39` varchar(20) DEFAULT NULL,
  `client_custom_field_40` varchar(20) DEFAULT NULL,
  `client_custom_field_41` varchar(150) DEFAULT NULL,
  `client_custom_field_42` varchar(150) DEFAULT NULL,
  `client_custom_field_43` varchar(150) DEFAULT NULL,
  `client_custom_field_44` varchar(150) DEFAULT NULL,
  `client_custom_field_45` varchar(150) DEFAULT NULL,
  `client_custom_field_46` varchar(150) DEFAULT NULL,
  `client_custom_field_47` varchar(150) DEFAULT NULL,
  `client_custom_field_48` varchar(150) DEFAULT NULL,
  `client_custom_field_49` varchar(150) DEFAULT NULL,
  `client_custom_field_50` varchar(150) DEFAULT NULL,
  `client_custom_field_51` int(11) DEFAULT NULL,
  `client_custom_field_52` int(11) DEFAULT NULL,
  `client_custom_field_53` int(11) DEFAULT NULL,
  `client_custom_field_54` int(11) DEFAULT NULL,
  `client_custom_field_55` int(11) DEFAULT NULL,
  `client_custom_field_56` int(11) DEFAULT NULL,
  `client_custom_field_57` int(11) DEFAULT NULL,
  `client_custom_field_58` int(11) DEFAULT NULL,
  `client_custom_field_59` int(11) DEFAULT NULL,
  `client_custom_field_60` int(11) DEFAULT NULL,
  `client_custom_field_61` decimal(10,2) DEFAULT NULL,
  `client_custom_field_62` decimal(10,2) DEFAULT NULL,
  `client_custom_field_63` decimal(10,2) DEFAULT NULL,
  `client_custom_field_64` decimal(10,2) DEFAULT NULL,
  `client_custom_field_65` decimal(10,2) DEFAULT NULL,
  `client_custom_field_66` decimal(10,2) DEFAULT NULL,
  `client_custom_field_67` decimal(10,2) DEFAULT NULL,
  `client_custom_field_68` decimal(10,2) DEFAULT NULL,
  `client_custom_field_69` decimal(10,2) DEFAULT NULL,
  `client_custom_field_70` decimal(10,2) DEFAULT NULL,
  `client_billing_invoice_terms` text DEFAULT NULL,
  `client_billing_invoice_due_days` smallint(6) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='[truncate]' ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `clients`
--

INSERT INTO `clients` (`client_id`, `client_importid`, `client_created`, `client_updated`, `client_creatorid`, `client_created_from_leadid`, `client_categoryid`, `client_company_name`, `client_description`, `client_phone`, `client_logo_folder`, `client_logo_filename`, `client_website`, `client_vat`, `client_billing_street`, `client_billing_city`, `client_billing_state`, `client_billing_zip`, `client_billing_country`, `client_shipping_street`, `client_shipping_city`, `client_shipping_state`, `client_shipping_zip`, `client_shipping_country`, `client_status`, `client_app_modules`, `client_settings_modules_projects`, `client_settings_modules_invoices`, `client_settings_modules_payments`, `client_settings_modules_knowledgebase`, `client_settings_modules_estimates`, `client_settings_modules_subscriptions`, `client_settings_modules_tickets`, `client_import_first_name`, `client_import_last_name`, `client_import_email`, `client_import_job_title`, `client_custom_field_1`, `client_custom_field_2`, `client_custom_field_3`, `client_custom_field_4`, `client_custom_field_5`, `client_custom_field_6`, `client_custom_field_7`, `client_custom_field_8`, `client_custom_field_9`, `client_custom_field_10`, `client_custom_field_11`, `client_custom_field_12`, `client_custom_field_13`, `client_custom_field_14`, `client_custom_field_15`, `client_custom_field_16`, `client_custom_field_17`, `client_custom_field_18`, `client_custom_field_19`, `client_custom_field_20`, `client_custom_field_21`, `client_custom_field_22`, `client_custom_field_23`, `client_custom_field_24`, `client_custom_field_25`, `client_custom_field_26`, `client_custom_field_27`, `client_custom_field_28`, `client_custom_field_29`, `client_custom_field_30`, `client_custom_field_31`, `client_custom_field_32`, `client_custom_field_33`, `client_custom_field_34`, `client_custom_field_35`, `client_custom_field_36`, `client_custom_field_37`, `client_custom_field_38`, `client_custom_field_39`, `client_custom_field_40`, `client_custom_field_41`, `client_custom_field_42`, `client_custom_field_43`, `client_custom_field_44`, `client_custom_field_45`, `client_custom_field_46`, `client_custom_field_47`, `client_custom_field_48`, `client_custom_field_49`, `client_custom_field_50`, `client_custom_field_51`, `client_custom_field_52`, `client_custom_field_53`, `client_custom_field_54`, `client_custom_field_55`, `client_custom_field_56`, `client_custom_field_57`, `client_custom_field_58`, `client_custom_field_59`, `client_custom_field_60`, `client_custom_field_61`, `client_custom_field_62`, `client_custom_field_63`, `client_custom_field_64`, `client_custom_field_65`, `client_custom_field_66`, `client_custom_field_67`, `client_custom_field_68`, `client_custom_field_69`, `client_custom_field_70`, `client_billing_invoice_terms`, `client_billing_invoice_due_days`) VALUES
(1, NULL, '2024-02-15 23:00:32', '2024-02-15 23:00:32', 1, 0, 2, 'Websvission', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Pakistan', NULL, NULL, NULL, NULL, NULL, 'active', 'system', 'enabled', 'enabled', 'enabled', 'enabled', 'enabled', 'enabled', 'enabled', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(2, NULL, '2024-02-16 23:49:49', '2024-02-16 23:49:49', 1, 3, 2, 'test', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'active', NULL, 'enabled', 'enabled', 'enabled', 'enabled', 'enabled', 'enabled', 'enabled', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `comments`
--

CREATE TABLE `comments` (
  `comment_id` int(11) NOT NULL,
  `comment_created` datetime DEFAULT NULL,
  `comment_updated` datetime DEFAULT NULL,
  `comment_creatorid` int(11) NOT NULL,
  `comment_clientid` int(11) DEFAULT NULL COMMENT 'required for client type resources',
  `comment_text` text NOT NULL,
  `commentresource_type` varchar(50) NOT NULL COMMENT '[polymorph] project | ticket | task | lead',
  `commentresource_id` int(11) NOT NULL COMMENT '[polymorph] e.g project_id'
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='[truncate]' ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `contracts`
--

CREATE TABLE `contracts` (
  `doc_id` int(11) NOT NULL,
  `doc_unique_id` varchar(150) DEFAULT NULL,
  `doc_template` varchar(150) DEFAULT NULL COMMENT 'default',
  `doc_created` datetime NOT NULL,
  `doc_updated` datetime NOT NULL,
  `doc_date_status_change` datetime NOT NULL,
  `doc_creatorid` int(11) NOT NULL COMMENT 'use ( -1 ) for logged out user.',
  `doc_categoryid` int(11) DEFAULT 11 COMMENT '11 is the default category',
  `doc_heading` varchar(250) DEFAULT '#7493a9' COMMENT 'e.g. contract',
  `doc_heading_color` varchar(30) DEFAULT '#7493a9',
  `doc_title` varchar(250) DEFAULT NULL,
  `doc_title_color` varchar(30) DEFAULT NULL,
  `doc_hero_direcory` varchar(250) DEFAULT NULL,
  `doc_hero_filename` varchar(250) DEFAULT NULL,
  `doc_hero_updated` varchar(250) DEFAULT 'no' COMMENT 'ys|no (when no, we use default image path)',
  `doc_body` text DEFAULT NULL,
  `doc_date_start` date DEFAULT NULL COMMENT 'Proposal Issue Date | Contract Start Date',
  `doc_date_end` date DEFAULT NULL COMMENT 'Proposal Expiry Date | Contract End Date',
  `doc_date_published` date DEFAULT NULL,
  `doc_date_last_emailed` datetime DEFAULT NULL,
  `doc_value` decimal(10,2) DEFAULT NULL,
  `doc_client_id` int(11) DEFAULT NULL,
  `doc_project_id` int(11) DEFAULT NULL,
  `doc_lead_id` int(11) DEFAULT NULL,
  `doc_notes` text DEFAULT NULL,
  `doc_viewed` varchar(20) DEFAULT 'no' COMMENT 'yes|no',
  `doc_type` varchar(150) DEFAULT 'contract',
  `doc_system_type` varchar(150) DEFAULT 'document' COMMENT 'document|template',
  `doc_provider_signed_userid` int(11) DEFAULT NULL,
  `doc_provider_signed_date` datetime DEFAULT NULL,
  `doc_provider_signed_first_name` varchar(150) DEFAULT NULL,
  `doc_provider_signed_last_name` varchar(150) DEFAULT NULL,
  `doc_provider_signed_signature_directory` varchar(150) DEFAULT NULL,
  `doc_provider_signed_signature_filename` varchar(150) DEFAULT NULL,
  `doc_provider_signed_ip_address` varchar(150) DEFAULT NULL,
  `doc_provider_signed_status` varchar(50) DEFAULT 'unsigned' COMMENT 'signed|unsigned',
  `doc_signed_userid` int(11) DEFAULT NULL,
  `doc_signed_date` datetime DEFAULT NULL,
  `doc_signed_first_name` varchar(150) DEFAULT '',
  `doc_signed_last_name` varchar(150) DEFAULT '',
  `doc_signed_signature_directory` varchar(150) DEFAULT '',
  `doc_signed_signature_filename` varchar(150) DEFAULT '',
  `doc_signed_status` varchar(50) DEFAULT 'unsigned' COMMENT 'signed|unsigned',
  `doc_signed_ip_address` varchar(150) DEFAULT NULL,
  `doc_fallback_client_first_name` varchar(150) DEFAULT '' COMMENT 'used for creating events when users are not logged in',
  `doc_fallback_client_last_name` varchar(150) DEFAULT '' COMMENT 'used for creating events when users are not logged in',
  `doc_fallback_client_email` varchar(150) DEFAULT '' COMMENT 'used for creating events when users are not logged in',
  `doc_status` varchar(100) DEFAULT 'draft' COMMENT 'draft|awaiting_signatures|active|expired',
  `docresource_type` varchar(100) DEFAULT NULL COMMENT 'client|lead',
  `docresource_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `contract_templates`
--

CREATE TABLE `contract_templates` (
  `contract_template_id` int(11) NOT NULL,
  `contract_template_created` datetime NOT NULL,
  `contract_template_updated` datetime NOT NULL,
  `contract_template_creatorid` int(11) DEFAULT NULL,
  `contract_template_title` varchar(250) DEFAULT NULL,
  `contract_template_heading_color` varchar(30) DEFAULT '#7493a9',
  `contract_template_title_color` varchar(30) DEFAULT '#7493a9',
  `contract_template_body` text DEFAULT NULL,
  `contract_template_system` varchar(20) DEFAULT 'no' COMMENT 'yes|no'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `contract_templates`
--

INSERT INTO `contract_templates` (`contract_template_id`, `contract_template_created`, `contract_template_updated`, `contract_template_creatorid`, `contract_template_title`, `contract_template_heading_color`, `contract_template_title_color`, `contract_template_body`, `contract_template_system`) VALUES
(1, '2024-02-15 21:58:22', '2022-05-22 09:15:49', 0, 'Default Template', '#FFFFFF', '#FFFFFF', 'This agreement (the &ldquo;Agreement&rdquo;) is between <strong>{client_company_name}</strong> (the &ldquo;Client&rdquo;) and <strong>{company_name}</strong> (the &ldquo;Service Provider&rdquo;). This Agreement is dated <strong>{contract_date}</strong>.<br /><br />\r\n<h6><span style=\"text-decoration: underline;\"><br />DELIVERABLES</span></h6>\r\n<br />The Client is hiring the Service Provider to do the following: <br /><br />\r\n<ul>\r\n<li>Design a website template.</li>\r\n<li>Convert the template into a WordPress theme.</li>\r\n<li>Install the WordPress theme on the Client\'s website.</li>\r\n</ul>\r\n<h6><span style=\"text-decoration: underline;\"><br /><br />DURATION</span></h6>\r\n<br />The Service Provider will begin work on&nbsp;<strong>{contract_date}</strong> and must complete the work by <strong>{contract_end_date}</strong>.<br />\r\n<h6><span style=\"text-decoration: underline;\"><br /><br /><br />PAYMENT</span></h6>\r\n<br />The Client will pay the Service Provider a sum of <strong>{pricing_table_total}</strong>. Of this, the Client will pay the Service Provider a 3<strong>0% deposit</strong>, before work begins.<br /><br /><strong>{pricing_table}</strong><br /><br />The Service Provider will invoice the Client on or after <strong>{contract_end_date}</strong>. <br /><br />The Client agrees to pay the Service Provider in full within <strong>7 days</strong> of receiving the invoice. Payment after that date will incur a late fee of <strong>$500 per month</strong>.<br /><br />\r\n<h6><span style=\"text-decoration: underline;\"><br /><br />EXPENSES</span></h6>\r\n<br />The Client will reimburse the Service Provider&rsquo;s expenses. Expenses do not need to be pre-approved by the Client.<br />\r\n<h6><span style=\"text-decoration: underline;\"><br /><br /><br />REVISIONS</span></h6>\r\n<br />The Client will incur additional fees for revisions requested which are outside the scope of the Deliverables at the Service Provider&rsquo;s standard hourly rate of <strong>$50/Hour</strong>.<br />\r\n<h6><span style=\"text-decoration: underline;\"><br /><br /><br />OWNERSHIP AND AUTHORSHIP</span></h6>\r\n<strong><br />Ownership:</strong> The Client owns all Deliverables (including intellectual property rights) once the Client has paid the Service Provider in full.<br /><br /><strong>Authorship:</strong> The Client agrees the Service Provider may showcase the Deliverables in the Service Provider&rsquo;s portfolio and in websites, printed literature and other media for the purpose of recognition.<br />\r\n<h6><span style=\"text-decoration: underline;\"><br /><br /><br />CONFIDENTIALITY AND NON-DISCLOSURE<br /></span></h6>\r\nEach party promises to the other party that it will not share information that is marked confidential and nonpublic with a third party, unless the disclosing party gives written permission first. Each party must continue to follow these obligations, even after the Agreement ends.<br />\r\n<h6><span style=\"text-decoration: underline;\"><br /><br /><br />NON-SOLICITATION</span></h6>\r\n<br />Until this Agreement ends, the Service Provider won&rsquo;t encourage Client employees or service providers to stop working for the Client for any reason.<br />\r\n<h6><span style=\"text-decoration: underline;\"><br /><br /><br />REPRESENTATIONS</span></h6>\r\n<br />Each party promises to the other party that it has the authority to enter into and perform all of its obligations under this Agreement.<br />\r\n<h6><span style=\"text-decoration: underline;\"><br /><br /><br />TERM AND TERMINATION</span></h6>\r\n<br />Either party may end this Agreement at any time and for any reason, by providing <strong>7 days\'</strong> written notice. <br /><br />The Client will pay the Service Provider for all work that has been completed when the Agreement ends and will reimburse the Service Provider for any prior expenses.<br />\r\n<h6><span style=\"text-decoration: underline;\"><br /><br /><br />LIMITATION OF LIABILITY</span></h6>\r\n<br />The Service Provider&rsquo;s Deliverables are sold &ldquo;as is&rdquo; and the Service Provider&rsquo;s maximum liability is the total sum paid by the Client to the Service Provider under this Agreement.<br /><span style=\"text-decoration-line: underline; color: #455a64;\"><br /><br />INDEMNITY</span><br /><br />The Client agrees to indemnify, save and hold harmless the Service Provider from any and all damages, liabilities, costs, losses or expenses arising out of any claim, demand, or action by a third party as a result of the work the Service Provider has done under this Agreement.<br />\r\n<h6><span style=\"text-decoration: underline;\"><br /><br /><br />GENERAL</span></h6>\r\n<br />Governing Law and Dispute Resolution. The laws of <strong>France</strong> govern the rights and obligations of the Client and the Service Provider under this Agreement, without regard to conflict of law provisions of that state.<br />\r\n<h6><span style=\"text-decoration: underline;\"><br /><br /><br />NOTICES</span></h6>\r\n<br />All notices to either party shall be in writing and delivered by email or registered mail. Notices must be delivered to the party&rsquo;s address(es) listed at the end of this Agreement.<br />Severability.&nbsp; If any portion of this Agreement is changed or disregarded because it is unenforceable, the rest of the Agreement is still enforceable.<br />\r\n<h6><span style=\"text-decoration: underline;\"><br /><br /><br />ENTIRE AGREEMENT</span></h6>\r\n<br />This Agreement supersedes all other prior Agreements (both written and oral) between the parties.<br /><br /><strong>The undersigned agree to and accept the terms of this Agreement.</strong>', 'no');

-- --------------------------------------------------------

--
-- Table structure for table `cs_affiliate_earnings`
--

CREATE TABLE `cs_affiliate_earnings` (
  `cs_affiliate_earning_id` int(11) NOT NULL,
  `cs_affiliate_earning_created` datetime NOT NULL,
  `cs_affiliate_earning_updated` datetime NOT NULL,
  `cs_affiliate_earning_projectid` int(11) NOT NULL COMMENT '[cs_affiliate_projects] table id',
  `cs_affiliate_earning_invoiceid` int(11) NOT NULL,
  `cs_affiliate_earning_invoice_payment_date` datetime DEFAULT NULL,
  `cs_affiliate_earning_commission_approval_date` datetime DEFAULT NULL,
  `cs_affiliate_earning_affiliateid` int(11) NOT NULL,
  `cs_affiliate_earning_amount` decimal(10,2) NOT NULL,
  `cs_affiliate_earning_commission_rate` decimal(10,2) NOT NULL DEFAULT 0.00 COMMENT 'set at the time of invoice payment',
  `cs_affiliate_earning_status` varchar(30) NOT NULL DEFAULT 'pending' COMMENT 'paid|pending'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `cs_affiliate_earnings`
--

INSERT INTO `cs_affiliate_earnings` (`cs_affiliate_earning_id`, `cs_affiliate_earning_created`, `cs_affiliate_earning_updated`, `cs_affiliate_earning_projectid`, `cs_affiliate_earning_invoiceid`, `cs_affiliate_earning_invoice_payment_date`, `cs_affiliate_earning_commission_approval_date`, `cs_affiliate_earning_affiliateid`, `cs_affiliate_earning_amount`, `cs_affiliate_earning_commission_rate`, `cs_affiliate_earning_status`) VALUES
(3, '2022-08-16 18:25:17', '2022-08-16 18:25:50', 5, 137, '2022-08-16 18:25:17', '2022-08-16 18:25:50', 167, 100.00, 10.00, 'paid');

-- --------------------------------------------------------

--
-- Table structure for table `cs_affiliate_projects`
--

CREATE TABLE `cs_affiliate_projects` (
  `cs_affiliate_project_id` int(11) NOT NULL,
  `cs_affiliate_project_created` int(11) NOT NULL,
  `cs_affiliate_project_updated` int(11) NOT NULL,
  `cs_affiliate_project_creatorid` int(11) NOT NULL,
  `cs_affiliate_project_affiliateid` int(11) NOT NULL,
  `cs_affiliate_project_projectid` int(11) NOT NULL,
  `cs_affiliate_project_commission_rate` decimal(10,2) DEFAULT NULL,
  `cs_affiliate_project_status` varchar(100) DEFAULT 'active' COMMENT 'active|suspended'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `cs_affiliate_projects`
--

INSERT INTO `cs_affiliate_projects` (`cs_affiliate_project_id`, `cs_affiliate_project_created`, `cs_affiliate_project_updated`, `cs_affiliate_project_creatorid`, `cs_affiliate_project_affiliateid`, `cs_affiliate_project_projectid`, `cs_affiliate_project_commission_rate`, `cs_affiliate_project_status`) VALUES
(7, 2022, 2022, 1, 167, 5, 10.00, 'active');

-- --------------------------------------------------------

--
-- Table structure for table `cs_events`
--

CREATE TABLE `cs_events` (
  `cs_event_id` int(11) NOT NULL,
  `cs_event_created` date NOT NULL,
  `cs_event_updated` date NOT NULL,
  `cs_event_affliateid` int(11) NOT NULL,
  `cs_event_invoiceid` int(11) NOT NULL,
  `cs_event_project_title` varchar(250) DEFAULT NULL,
  `cs_event_amount` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `cs_events`
--

INSERT INTO `cs_events` (`cs_event_id`, `cs_event_created`, `cs_event_updated`, `cs_event_affliateid`, `cs_event_invoiceid`, `cs_event_project_title`, `cs_event_amount`) VALUES
(3, '2022-08-16', '2022-08-16', 167, 137, 'Redesign the layout of our helpdesk', 100.00);

-- --------------------------------------------------------

--
-- Table structure for table `customfields`
--

CREATE TABLE `customfields` (
  `customfields_id` int(11) NOT NULL,
  `customfields_created` datetime NOT NULL,
  `customfields_updated` datetime NOT NULL,
  `customfields_position` int(11) NOT NULL DEFAULT 1,
  `customfields_datatype` varchar(50) DEFAULT 'text' COMMENT 'text|paragraph|number|decima|date|checkbox|dropdown',
  `customfields_datapayload` text DEFAULT NULL COMMENT 'use this to store dropdown lists etc',
  `customfields_type` varchar(50) DEFAULT NULL COMMENT 'clients|projects|leads|tasks|tickets',
  `customfields_name` varchar(250) DEFAULT NULL COMMENT 'e.g. project_custom_field_1',
  `customfields_title` varchar(250) DEFAULT NULL,
  `customfields_required` varchar(5) DEFAULT 'no' COMMENT 'yes|no - standard form',
  `customfields_show_client_page` varchar(100) DEFAULT NULL,
  `customfields_show_project_page` varchar(100) DEFAULT NULL,
  `customfields_show_task_summary` varchar(100) DEFAULT NULL,
  `customfields_show_lead_summary` varchar(100) DEFAULT NULL,
  `customfields_show_invoice` varchar(100) DEFAULT NULL,
  `customfields_show_ticket_page` varchar(100) DEFAULT 'no',
  `customfields_show_filter_panel` varchar(100) DEFAULT 'no' COMMENT 'yes|no',
  `customfields_standard_form_status` varchar(100) DEFAULT 'disabled' COMMENT 'disabled | enabled',
  `customfields_status` varchar(50) DEFAULT 'disabled' COMMENT 'disabled | enabled',
  `customfields_sorting_a_z` varchar(5) DEFAULT 'z' COMMENT 'hack to get sorting right, excluding null title items'
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='checkbox fields are stored as ''on'' or null' ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `customfields`
--

INSERT INTO `customfields` (`customfields_id`, `customfields_created`, `customfields_updated`, `customfields_position`, `customfields_datatype`, `customfields_datapayload`, `customfields_type`, `customfields_name`, `customfields_title`, `customfields_required`, `customfields_show_client_page`, `customfields_show_project_page`, `customfields_show_task_summary`, `customfields_show_lead_summary`, `customfields_show_invoice`, `customfields_show_ticket_page`, `customfields_show_filter_panel`, `customfields_standard_form_status`, `customfields_status`, `customfields_sorting_a_z`) VALUES
(1, '2021-01-09 17:02:59', '2022-10-02 15:07:33', 1, 'text', '', 'projects', 'project_custom_field_1', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(2, '2021-01-09 17:03:12', '2021-07-13 15:56:23', 1, 'text', '', 'projects', 'project_custom_field_2', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(3, '2021-01-09 17:03:17', '2021-07-09 17:25:11', 1, 'text', '', 'projects', 'project_custom_field_3', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(4, '2021-01-09 17:03:23', '2021-07-09 17:25:11', 1, 'text', '', 'projects', 'project_custom_field_4', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(5, '2021-01-09 17:03:29', '2021-07-09 17:25:11', 1, 'text', '', 'projects', 'project_custom_field_5', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(6, '2021-01-09 17:03:34', '2021-07-09 17:25:11', 1, 'text', '', 'projects', 'project_custom_field_6', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(7, '2021-01-09 17:03:39', '2021-07-09 17:25:11', 1, 'text', '', 'projects', 'project_custom_field_7', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(8, '2021-01-09 17:03:45', '2021-07-09 17:25:11', 1, 'text', '', 'projects', 'project_custom_field_8', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(9, '2021-01-09 17:03:50', '2021-07-09 17:25:11', 1, 'text', '', 'projects', 'project_custom_field_9', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(10, '2021-01-09 17:03:55', '2021-07-09 17:25:11', 1, 'text', '', 'projects', 'project_custom_field_10', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(11, '2021-01-09 17:04:09', '2024-01-30 08:03:48', 1, 'text', '', 'clients', 'client_custom_field_1', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(12, '2021-01-09 17:04:15', '2022-04-13 12:14:12', 5, 'text', '', 'clients', 'client_custom_field_2', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(13, '2021-01-09 17:04:19', '2021-07-09 16:49:46', 1, 'text', '', 'clients', 'client_custom_field_3', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(14, '2021-01-09 17:04:25', '2021-07-09 16:49:47', 1, 'text', '', 'clients', 'client_custom_field_4', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(15, '2021-01-09 17:04:30', '2021-07-09 16:49:47', 1, 'text', '', 'clients', 'client_custom_field_5', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(16, '2021-01-09 17:04:35', '2021-07-09 16:49:47', 1, 'text', '', 'clients', 'client_custom_field_6', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(17, '2021-01-09 17:04:41', '2021-07-09 16:49:47', 1, 'text', '', 'clients', 'client_custom_field_7', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(18, '2021-01-09 17:04:46', '2021-07-09 16:49:47', 1, 'text', '', 'clients', 'client_custom_field_8', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(19, '2021-01-09 17:04:51', '2021-07-09 16:49:47', 1, 'text', '', 'clients', 'client_custom_field_9', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(20, '2021-01-09 17:04:57', '2021-07-09 16:49:47', 1, 'text', '', 'clients', 'client_custom_field_10', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(21, '2021-01-09 17:05:07', '2023-05-23 16:41:08', 2, 'text', '', 'leads', 'lead_custom_field_1', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(22, '2021-01-09 17:05:12', '2021-08-04 16:38:49', 1, 'text', '', 'leads', 'lead_custom_field_2', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(23, '2021-01-09 17:05:17', '2021-07-10 18:54:38', 1, 'text', '', 'leads', 'lead_custom_field_3', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(24, '2021-01-09 17:05:22', '2021-07-10 18:54:38', 1, 'text', '', 'leads', 'lead_custom_field_4', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(25, '2021-01-09 17:05:27', '2021-07-10 18:54:38', 1, 'text', '', 'leads', 'lead_custom_field_5', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(26, '2021-01-09 17:05:32', '2021-07-08 17:24:57', 1, 'text', '', 'leads', 'lead_custom_field_6', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(27, '2021-01-09 17:05:37', '2021-07-08 17:24:57', 1, 'text', '', 'leads', 'lead_custom_field_7', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(28, '2021-01-09 17:05:42', '2021-07-08 17:24:57', 1, 'text', '', 'leads', 'lead_custom_field_8', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(29, '2021-01-09 17:05:48', '2021-07-08 17:24:57', 1, 'text', '', 'leads', 'lead_custom_field_9', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(30, '2021-01-09 17:05:53', '2021-07-08 17:24:57', 1, 'text', '', 'leads', 'lead_custom_field_10', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(31, '2021-01-09 17:06:06', '2023-05-21 14:21:52', 1, 'text', '', 'tasks', 'task_custom_field_1', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(32, '2021-01-09 17:06:12', '2021-07-10 19:01:51', 1, 'text', '', 'tasks', 'task_custom_field_2', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(33, '2021-01-09 17:06:16', '2021-07-10 19:01:51', 1, 'text', '', 'tasks', 'task_custom_field_3', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(34, '2021-01-09 17:06:21', '2021-07-10 19:01:51', 1, 'text', '', 'tasks', 'task_custom_field_4', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(35, '2021-01-09 17:06:26', '2021-07-10 19:01:51', 1, 'text', '', 'tasks', 'task_custom_field_5', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(36, '2021-01-09 17:06:31', '2021-05-08 20:15:21', 1, 'text', '', 'tasks', 'task_custom_field_6', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(37, '2021-01-09 17:06:36', '2021-05-08 20:15:21', 1, 'text', '', 'tasks', 'task_custom_field_7', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(38, '2021-01-09 17:06:42', '2021-05-08 20:15:21', 1, 'text', '', 'tasks', 'task_custom_field_8', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(39, '2021-01-09 17:06:47', '2021-05-08 20:15:21', 1, 'text', '', 'tasks', 'task_custom_field_9', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(40, '2021-01-09 17:06:52', '2021-05-08 20:15:21', 1, 'text', '', 'tasks', 'task_custom_field_10', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(127, '2021-07-04 18:06:09', '2024-01-27 14:28:40', 6, 'paragraph', '', 'leads', 'lead_custom_field_47', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(126, '2021-07-04 18:06:09', '2021-07-10 18:56:29', 1, 'paragraph', '', 'leads', 'lead_custom_field_46', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(125, '2021-07-04 18:06:09', '2021-07-10 18:55:43', 1, 'paragraph', '', 'leads', 'lead_custom_field_45', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(124, '2021-07-04 18:06:09', '2021-07-10 18:55:43', 1, 'paragraph', '', 'leads', 'lead_custom_field_44', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(123, '2021-07-04 18:06:09', '2021-07-10 18:55:43', 1, 'paragraph', '', 'leads', 'lead_custom_field_43', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(122, '2021-07-04 18:06:09', '2021-07-08 17:20:58', 1, 'paragraph', '', 'leads', 'lead_custom_field_42', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(121, '2021-07-04 18:06:09', '2021-07-08 17:20:58', 1, 'paragraph', '', 'leads', 'lead_custom_field_41', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(120, '2021-07-04 17:57:57', '2023-10-06 21:18:21', 3, 'date', '', 'leads', 'lead_custom_field_40', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(119, '2021-07-04 17:57:57', '2021-07-10 18:56:44', 1, 'date', '', 'leads', 'lead_custom_field_39', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(118, '2021-07-04 17:57:57', '2021-07-10 18:56:44', 1, 'date', '', 'leads', 'lead_custom_field_38', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(117, '2021-07-04 17:57:57', '2021-07-10 18:56:44', 1, 'date', '', 'leads', 'lead_custom_field_37', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(116, '2021-07-04 17:57:57', '2021-07-10 18:56:44', 1, 'date', '', 'leads', 'lead_custom_field_36', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(115, '2021-07-04 17:57:57', '2021-07-08 17:24:17', 1, 'date', '', 'leads', 'lead_custom_field_35', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(114, '2021-07-04 17:57:57', '2021-07-08 17:24:17', 1, 'date', '', 'leads', 'lead_custom_field_34', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(113, '2021-07-04 17:57:57', '2021-07-08 17:24:17', 1, 'date', '', 'leads', 'lead_custom_field_33', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(112, '2021-07-04 17:57:57', '2021-07-08 17:24:17', 1, 'date', '', 'leads', 'lead_custom_field_32', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(111, '2021-07-04 17:57:57', '2021-07-08 17:24:17', 1, 'date', '', 'leads', 'lead_custom_field_31', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(110, '2021-07-04 17:53:27', '2021-07-08 17:24:57', 1, 'text', '', 'leads', 'lead_custom_field_30', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(109, '2021-07-04 17:53:27', '2021-07-08 17:24:57', 1, 'text', '', 'leads', 'lead_custom_field_29', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(108, '2021-07-04 17:53:27', '2021-07-08 17:24:57', 1, 'text', '', 'leads', 'lead_custom_field_28', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(107, '2021-07-04 17:53:27', '2021-07-08 17:24:57', 1, 'text', '', 'leads', 'lead_custom_field_27', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(106, '2021-07-04 17:53:27', '2021-07-08 17:24:57', 1, 'text', '', 'leads', 'lead_custom_field_26', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(105, '2021-07-04 17:53:27', '2021-07-08 17:24:57', 1, 'text', '', 'leads', 'lead_custom_field_25', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(104, '2021-07-04 17:53:27', '2021-07-08 17:24:57', 1, 'text', '', 'leads', 'lead_custom_field_24', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(103, '2021-07-04 17:53:27', '2021-07-08 17:24:57', 1, 'text', '', 'leads', 'lead_custom_field_23', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(102, '2021-07-04 17:53:27', '2021-07-08 17:24:57', 1, 'text', '', 'leads', 'lead_custom_field_22', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(101, '2021-07-04 17:53:27', '2021-07-08 17:24:57', 1, 'text', '', 'leads', 'lead_custom_field_21', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(100, '2021-07-04 17:53:27', '2021-07-08 17:24:57', 1, 'text', '', 'leads', 'lead_custom_field_20', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(99, '2021-07-04 17:53:27', '2021-07-08 17:24:57', 1, 'text', '', 'leads', 'lead_custom_field_19', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(98, '2021-07-04 17:53:27', '2021-07-08 17:24:57', 1, 'text', '', 'leads', 'lead_custom_field_18', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(97, '2021-07-04 17:53:27', '2021-07-08 17:24:57', 1, 'text', '', 'leads', 'lead_custom_field_17', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(96, '2021-07-04 17:53:27', '2021-07-08 17:24:57', 1, 'text', '', 'leads', 'lead_custom_field_16', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(95, '2021-07-04 17:53:27', '2021-07-08 17:24:57', 1, 'text', '', 'leads', 'lead_custom_field_15', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(94, '2021-07-04 17:53:27', '2021-07-08 17:24:57', 1, 'text', '', 'leads', 'lead_custom_field_14', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(93, '2021-07-04 17:53:27', '2021-07-08 17:24:57', 1, 'text', '', 'leads', 'lead_custom_field_13', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(92, '2021-07-04 17:53:27', '2021-07-08 17:24:57', 1, 'text', '', 'leads', 'lead_custom_field_12', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(91, '2021-07-04 17:53:27', '2021-07-08 17:24:57', 1, 'text', '', 'leads', 'lead_custom_field_11', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(128, '2021-07-04 18:06:09', '2021-07-08 17:20:58', 1, 'paragraph', '', 'leads', 'lead_custom_field_48', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(129, '2021-07-04 18:06:09', '2021-07-08 17:20:58', 1, 'paragraph', '', 'leads', 'lead_custom_field_49', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(130, '2021-07-04 18:06:09', '2021-07-08 17:20:58', 1, 'paragraph', '', 'leads', 'lead_custom_field_50', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(131, '2021-07-04 18:06:09', '2021-07-08 17:20:58', 1, 'paragraph', '', 'leads', 'lead_custom_field_51', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(132, '2021-07-04 18:06:09', '2021-07-08 17:20:58', 1, 'paragraph', '', 'leads', 'lead_custom_field_52', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(133, '2021-07-04 18:06:09', '2021-07-08 17:20:58', 1, 'paragraph', '', 'leads', 'lead_custom_field_53', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(134, '2021-07-04 18:06:09', '2021-07-08 17:20:58', 1, 'paragraph', '', 'leads', 'lead_custom_field_54', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(135, '2021-07-04 18:06:09', '2021-07-08 17:20:58', 1, 'paragraph', '', 'leads', 'lead_custom_field_55', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(136, '2021-07-04 18:06:09', '2021-07-08 17:20:58', 1, 'paragraph', '', 'leads', 'lead_custom_field_56', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(137, '2021-07-04 18:06:09', '2021-07-08 17:20:58', 1, 'paragraph', '', 'leads', 'lead_custom_field_57', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(138, '2021-07-04 18:06:09', '2021-07-08 17:20:58', 1, 'paragraph', '', 'leads', 'lead_custom_field_58', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(139, '2021-07-04 18:06:09', '2021-07-08 17:20:58', 1, 'paragraph', '', 'leads', 'lead_custom_field_59', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(140, '2021-07-04 18:06:09', '2021-07-08 17:20:58', 1, 'paragraph', '', 'leads', 'lead_custom_field_60', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(141, '2021-07-04 18:27:12', '2023-05-23 16:41:43', 4, 'checkbox', '', 'leads', 'lead_custom_field_61', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(142, '2021-07-04 18:27:12', '2021-07-10 18:56:58', 1, 'checkbox', '', 'leads', 'lead_custom_field_62', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(143, '2021-07-04 18:27:12', '2021-07-10 18:56:58', 1, 'checkbox', '', 'leads', 'lead_custom_field_63', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(144, '2021-07-04 18:27:12', '2021-07-10 18:56:58', 1, 'checkbox', '', 'leads', 'lead_custom_field_64', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(145, '2021-07-04 18:27:12', '2021-07-10 18:56:58', 1, 'checkbox', '', 'leads', 'lead_custom_field_65', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(146, '2021-07-04 18:27:12', '2021-07-08 17:26:05', 1, 'checkbox', '', 'leads', 'lead_custom_field_66', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(147, '2021-07-04 18:27:12', '2021-07-08 17:26:05', 1, 'checkbox', '', 'leads', 'lead_custom_field_67', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(148, '2021-07-04 18:27:13', '2021-07-08 17:26:05', 1, 'checkbox', '', 'leads', 'lead_custom_field_68', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(149, '2021-07-04 18:27:13', '2021-07-08 17:26:05', 1, 'checkbox', '', 'leads', 'lead_custom_field_69', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(150, '2021-07-04 18:27:13', '2021-07-08 17:26:05', 1, 'checkbox', '', 'leads', 'lead_custom_field_70', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(151, '2021-07-04 18:27:13', '2021-07-08 17:26:05', 1, 'checkbox', '', 'leads', 'lead_custom_field_71', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(152, '2021-07-04 18:27:13', '2021-07-08 17:26:05', 1, 'checkbox', '', 'leads', 'lead_custom_field_72', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(153, '2021-07-04 18:27:13', '2021-07-08 17:26:05', 1, 'checkbox', '', 'leads', 'lead_custom_field_73', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(154, '2021-07-04 18:27:13', '2021-07-08 17:26:05', 1, 'checkbox', '', 'leads', 'lead_custom_field_74', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(155, '2021-07-04 18:27:13', '2021-07-08 17:26:05', 1, 'checkbox', '', 'leads', 'lead_custom_field_75', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(156, '2021-07-04 18:27:13', '2021-07-08 17:26:05', 1, 'checkbox', '', 'leads', 'lead_custom_field_76', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(157, '2021-07-04 18:27:13', '2021-07-08 17:26:05', 1, 'checkbox', '', 'leads', 'lead_custom_field_77', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(158, '2021-07-04 18:27:13', '2021-07-08 17:26:05', 1, 'checkbox', '', 'leads', 'lead_custom_field_78', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(159, '2021-07-04 18:27:13', '2021-07-08 17:26:05', 1, 'checkbox', '', 'leads', 'lead_custom_field_79', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(160, '2021-07-04 18:27:13', '2021-07-08 17:26:05', 1, 'checkbox', '', 'leads', 'lead_custom_field_80', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(161, '2021-07-04 18:29:23', '2022-10-02 15:16:29', 5, 'dropdown', '', 'leads', 'lead_custom_field_81', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(162, '2021-07-04 18:29:23', '2021-07-10 18:57:12', 1, 'dropdown', '', 'leads', 'lead_custom_field_82', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(163, '2021-07-04 18:29:23', '2021-07-10 18:57:12', 1, 'dropdown', '', 'leads', 'lead_custom_field_83', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(164, '2021-07-04 18:29:23', '2021-07-10 18:57:12', 1, 'dropdown', '', 'leads', 'lead_custom_field_84', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(165, '2021-07-04 18:29:23', '2021-07-10 18:57:12', 1, 'dropdown', '', 'leads', 'lead_custom_field_85', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(166, '2021-07-04 18:29:23', '2021-07-08 18:24:38', 1, 'dropdown', '', 'leads', 'lead_custom_field_86', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(167, '2021-07-04 18:29:23', '2021-07-08 18:24:38', 1, 'dropdown', '', 'leads', 'lead_custom_field_87', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(168, '2021-07-04 18:29:23', '2021-07-08 18:24:38', 1, 'dropdown', '', 'leads', 'lead_custom_field_88', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(169, '2021-07-04 18:29:23', '2021-07-08 18:24:38', 1, 'dropdown', '', 'leads', 'lead_custom_field_89', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(170, '2021-07-04 18:29:23', '2021-07-08 18:24:38', 1, 'dropdown', '', 'leads', 'lead_custom_field_90', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(171, '2021-07-04 18:29:23', '2021-07-08 18:24:38', 1, 'dropdown', '', 'leads', 'lead_custom_field_91', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(172, '2021-07-04 18:29:23', '2021-07-08 18:24:38', 1, 'dropdown', '', 'leads', 'lead_custom_field_92', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(173, '2021-07-04 18:29:23', '2021-07-08 18:24:38', 1, 'dropdown', '', 'leads', 'lead_custom_field_93', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(174, '2021-07-04 18:29:23', '2021-07-08 18:24:38', 1, 'dropdown', '', 'leads', 'lead_custom_field_94', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(175, '2021-07-04 18:29:23', '2021-07-08 18:24:38', 1, 'dropdown', '', 'leads', 'lead_custom_field_95', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(176, '2021-07-04 18:29:23', '2021-07-08 18:24:38', 1, 'dropdown', '', 'leads', 'lead_custom_field_96', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(177, '2021-07-04 18:29:23', '2021-07-08 18:24:38', 1, 'dropdown', '', 'leads', 'lead_custom_field_97', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(178, '2021-07-04 18:29:23', '2021-07-08 18:24:38', 1, 'dropdown', '', 'leads', 'lead_custom_field_98', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(179, '2021-07-04 18:29:23', '2021-07-08 18:24:38', 1, 'dropdown', '', 'leads', 'lead_custom_field_99', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(180, '2021-07-04 18:29:23', '2021-07-08 18:24:38', 1, 'dropdown', '', 'leads', 'lead_custom_field_100', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(181, '2021-07-04 18:29:23', '2021-07-08 18:24:38', 1, 'dropdown', '', 'leads', 'lead_custom_field_101', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(182, '2021-07-04 18:29:23', '2021-07-08 18:24:38', 1, 'dropdown', '', 'leads', 'lead_custom_field_102', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(183, '2021-07-04 18:29:23', '2021-07-08 18:24:38', 1, 'dropdown', '', 'leads', 'lead_custom_field_103', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(184, '2021-07-04 18:29:24', '2021-07-08 18:24:38', 1, 'dropdown', '', 'leads', 'lead_custom_field_104', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(185, '2021-07-04 18:29:24', '2021-07-08 18:24:38', 1, 'dropdown', '', 'leads', 'lead_custom_field_105', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(186, '2021-07-04 18:29:24', '2021-07-08 18:24:38', 1, 'dropdown', '', 'leads', 'lead_custom_field_106', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(187, '2021-07-04 18:29:24', '2021-07-08 18:24:38', 1, 'dropdown', '', 'leads', 'lead_custom_field_107', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(188, '2021-07-04 18:29:24', '2021-07-08 18:24:38', 1, 'dropdown', '', 'leads', 'lead_custom_field_108', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(189, '2021-07-04 18:29:24', '2021-07-08 18:24:38', 1, 'dropdown', '', 'leads', 'lead_custom_field_109', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(190, '2021-07-04 18:29:24', '2021-07-08 18:24:38', 1, 'dropdown', '', 'leads', 'lead_custom_field_110', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(191, '2021-07-04 18:30:33', '2022-10-02 15:16:43', 7, 'number', '', 'leads', 'lead_custom_field_111', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(192, '2021-07-04 18:30:33', '2021-07-10 18:57:25', 1, 'number', '', 'leads', 'lead_custom_field_112', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(193, '2021-07-04 18:30:33', '2021-07-10 18:57:25', 1, 'number', '', 'leads', 'lead_custom_field_113', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(194, '2021-07-04 18:30:33', '2021-07-10 18:57:25', 1, 'number', '', 'leads', 'lead_custom_field_114', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(195, '2021-07-04 18:30:34', '2021-07-10 18:57:25', 1, 'number', '', 'leads', 'lead_custom_field_115', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(196, '2021-07-04 18:30:34', '2021-07-08 18:25:39', 1, 'number', '', 'leads', 'lead_custom_field_116', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(197, '2021-07-04 18:30:34', '2021-07-08 18:25:39', 1, 'number', '', 'leads', 'lead_custom_field_117', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(198, '2021-07-04 18:30:34', '2021-07-08 18:25:39', 1, 'number', '', 'leads', 'lead_custom_field_118', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(199, '2021-07-04 18:30:34', '2021-07-08 18:25:39', 1, 'number', '', 'leads', 'lead_custom_field_119', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(200, '2021-07-04 18:30:34', '2021-07-08 18:25:39', 1, 'number', '', 'leads', 'lead_custom_field_120', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(201, '2021-07-04 18:30:34', '2021-07-08 18:25:39', 1, 'number', '', 'leads', 'lead_custom_field_121', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(202, '2021-07-04 18:30:34', '2021-07-08 18:25:39', 1, 'number', '', 'leads', 'lead_custom_field_122', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(203, '2021-07-04 18:30:34', '2021-07-08 18:25:39', 1, 'number', '', 'leads', 'lead_custom_field_123', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(204, '2021-07-04 18:30:34', '2021-07-08 18:25:39', 1, 'number', '', 'leads', 'lead_custom_field_124', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(205, '2021-07-04 18:30:34', '2021-07-08 18:25:39', 1, 'number', '', 'leads', 'lead_custom_field_125', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(206, '2021-07-04 18:30:34', '2021-07-08 18:25:39', 1, 'number', '', 'leads', 'lead_custom_field_126', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(207, '2021-07-04 18:30:34', '2021-07-08 18:25:39', 1, 'number', '', 'leads', 'lead_custom_field_127', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(208, '2021-07-04 18:30:34', '2021-07-08 18:25:39', 1, 'number', '', 'leads', 'lead_custom_field_128', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(209, '2021-07-04 18:30:34', '2021-07-08 18:25:39', 1, 'number', '', 'leads', 'lead_custom_field_129', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(210, '2021-07-04 18:30:34', '2021-07-08 18:25:39', 1, 'number', '', 'leads', 'lead_custom_field_130', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(211, '2021-07-04 18:32:26', '2022-10-02 15:17:00', 8, 'decimal', '', 'leads', 'lead_custom_field_131', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(212, '2021-07-04 18:32:26', '2021-07-10 18:57:38', 1, 'decimal', '', 'leads', 'lead_custom_field_132', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(213, '2021-07-04 18:32:26', '2021-07-10 18:57:38', 1, 'decimal', '', 'leads', 'lead_custom_field_133', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(214, '2021-07-04 18:32:26', '2021-07-10 18:57:38', 1, 'decimal', '', 'leads', 'lead_custom_field_134', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(215, '2021-07-04 18:32:26', '2021-07-10 18:57:38', 1, 'decimal', '', 'leads', 'lead_custom_field_135', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(216, '2021-07-04 18:32:26', '2021-07-08 18:26:37', 1, 'decimal', '', 'leads', 'lead_custom_field_136', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(217, '2021-07-04 18:32:26', '2021-07-08 18:26:37', 1, 'decimal', '', 'leads', 'lead_custom_field_137', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(218, '2021-07-04 18:32:26', '2021-07-08 18:26:37', 1, 'decimal', '', 'leads', 'lead_custom_field_138', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(219, '2021-07-04 18:32:26', '2021-07-08 18:26:37', 1, 'decimal', '', 'leads', 'lead_custom_field_139', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(220, '2021-07-04 18:32:26', '2021-07-08 18:26:37', 1, 'decimal', '', 'leads', 'lead_custom_field_140', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(221, '2021-07-04 18:32:26', '2021-07-08 18:26:37', 1, 'decimal', '', 'leads', 'lead_custom_field_141', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(222, '2021-07-04 18:32:26', '2021-07-08 18:26:37', 1, 'decimal', '', 'leads', 'lead_custom_field_142', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(223, '2021-07-04 18:32:26', '2021-07-08 18:26:37', 1, 'decimal', '', 'leads', 'lead_custom_field_143', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(224, '2021-07-04 18:32:26', '2021-07-08 18:26:37', 1, 'decimal', '', 'leads', 'lead_custom_field_144', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(225, '2021-07-04 18:32:26', '2021-07-08 18:26:37', 1, 'decimal', '', 'leads', 'lead_custom_field_145', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(226, '2021-07-04 18:32:26', '2021-07-08 18:26:37', 1, 'decimal', '', 'leads', 'lead_custom_field_146', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(227, '2021-07-04 18:32:26', '2021-07-08 18:26:37', 1, 'decimal', '', 'leads', 'lead_custom_field_147', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(228, '2021-07-04 18:32:27', '2021-07-08 18:26:37', 1, 'decimal', '', 'leads', 'lead_custom_field_148', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(229, '2021-07-04 18:32:27', '2021-07-08 18:26:37', 1, 'decimal', '', 'leads', 'lead_custom_field_149', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(230, '2021-07-04 18:32:27', '2021-07-08 18:26:37', 1, 'decimal', '', 'leads', 'lead_custom_field_150', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(231, '2021-07-04 18:35:30', '2022-10-02 15:13:34', 1, 'date', '', 'tasks', 'task_custom_field_11', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(232, '2021-07-04 18:35:30', '2021-07-10 19:02:34', 1, 'date', '', 'tasks', 'task_custom_field_12', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(233, '2021-07-04 18:35:30', '2021-07-10 19:02:34', 1, 'date', '', 'tasks', 'task_custom_field_13', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(234, '2021-07-04 18:35:30', '2021-07-10 19:02:34', 1, 'date', '', 'tasks', 'task_custom_field_14', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(235, '2021-07-04 18:35:30', '2021-07-10 19:02:34', 1, 'date', '', 'tasks', 'task_custom_field_15', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(236, '2021-07-04 18:35:30', '2021-07-04 18:35:30', 1, 'date', '', 'tasks', 'task_custom_field_16', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(237, '2021-07-04 18:35:30', '2021-07-04 18:35:30', 1, 'date', '', 'tasks', 'task_custom_field_17', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(238, '2021-07-04 18:35:30', '2021-07-04 18:35:30', 1, 'date', '', 'tasks', 'task_custom_field_18', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(239, '2021-07-04 18:35:30', '2021-07-04 18:35:30', 1, 'date', '', 'tasks', 'task_custom_field_19', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(240, '2021-07-04 18:35:30', '2021-07-04 18:35:30', 1, 'date', '', 'tasks', 'task_custom_field_20', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(241, '2021-07-04 18:36:41', '2022-11-24 15:05:02', 1, 'date', '', 'clients', 'client_custom_field_11', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(242, '2021-07-04 18:36:41', '2021-08-04 14:14:10', 1, 'date', '', 'clients', 'client_custom_field_12', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(243, '2021-07-04 18:36:41', '2021-07-09 17:19:20', 1, 'date', '', 'clients', 'client_custom_field_13', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(244, '2021-07-04 18:36:41', '2021-07-09 17:19:20', 1, 'date', '', 'clients', 'client_custom_field_14', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(245, '2021-07-04 18:36:41', '2021-07-09 17:19:20', 1, 'date', '', 'clients', 'client_custom_field_15', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(246, '2021-07-04 18:36:41', '2021-07-09 17:19:20', 1, 'date', '', 'clients', 'client_custom_field_16', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(247, '2021-07-04 18:36:41', '2021-07-09 17:19:20', 1, 'date', '', 'clients', 'client_custom_field_17', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(248, '2021-07-04 18:36:41', '2021-07-09 17:19:20', 1, 'date', '', 'clients', 'client_custom_field_18', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(249, '2021-07-04 18:36:41', '2021-07-09 17:19:20', 1, 'date', '', 'clients', 'client_custom_field_19', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(250, '2021-07-04 18:36:41', '2021-07-09 17:19:20', 1, 'date', '', 'clients', 'client_custom_field_20', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(251, '2021-07-04 18:37:11', '2021-08-04 15:27:48', 1, 'date', '', 'projects', 'project_custom_field_11', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(252, '2021-07-04 18:37:11', '2022-10-02 15:08:10', 1, 'date', '', 'projects', 'project_custom_field_12', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(253, '2021-07-04 18:37:11', '2021-07-09 17:27:49', 1, 'date', '', 'projects', 'project_custom_field_13', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(254, '2021-07-04 18:37:11', '2021-07-09 17:27:49', 1, 'date', '', 'projects', 'project_custom_field_14', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(255, '2021-07-04 18:37:11', '2021-07-09 17:27:49', 1, 'date', '', 'projects', 'project_custom_field_15', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(256, '2021-07-04 18:37:11', '2021-07-09 17:27:49', 1, 'date', '', 'projects', 'project_custom_field_16', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(257, '2021-07-04 18:37:11', '2021-07-09 17:27:49', 1, 'date', '', 'projects', 'project_custom_field_17', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(258, '2021-07-04 18:37:11', '2021-07-09 17:27:49', 1, 'date', '', 'projects', 'project_custom_field_18', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(259, '2021-07-04 18:37:11', '2021-07-09 17:27:49', 1, 'date', '', 'projects', 'project_custom_field_19', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(260, '2021-07-04 18:37:11', '2021-07-09 17:27:49', 1, 'date', '', 'projects', 'project_custom_field_20', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(261, '2021-07-04 18:37:35', '2022-10-02 15:13:17', 1, 'paragraph', '', 'tasks', 'task_custom_field_21', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(262, '2021-07-04 18:37:35', '2021-07-10 19:02:17', 1, 'paragraph', '', 'tasks', 'task_custom_field_22', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(263, '2021-07-04 18:37:35', '2021-07-10 19:02:17', 1, 'paragraph', '', 'tasks', 'task_custom_field_23', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(264, '2021-07-04 18:37:35', '2021-07-10 19:02:17', 1, 'paragraph', '', 'tasks', 'task_custom_field_24', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(265, '2021-07-04 18:37:35', '2021-07-10 19:02:17', 1, 'paragraph', '', 'tasks', 'task_custom_field_25', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(266, '2021-07-04 18:37:35', '2021-07-04 18:37:35', 1, 'paragraph', '', 'tasks', 'task_custom_field_26', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(267, '2021-07-04 18:37:35', '2021-07-04 18:37:35', 1, 'paragraph', '', 'tasks', 'task_custom_field_27', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(268, '2021-07-04 18:37:35', '2021-07-04 18:37:35', 1, 'paragraph', '', 'tasks', 'task_custom_field_28', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(269, '2021-07-04 18:37:35', '2021-07-04 18:37:35', 1, 'paragraph', '', 'tasks', 'task_custom_field_29', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(270, '2021-07-04 18:37:35', '2021-07-04 18:37:35', 1, 'paragraph', '', 'tasks', 'task_custom_field_30', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(271, '2021-07-04 18:37:44', '2022-11-24 15:05:02', 1, 'paragraph', '', 'clients', 'client_custom_field_21', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(272, '2021-07-04 18:37:44', '2021-08-04 14:13:00', 1, 'paragraph', '', 'clients', 'client_custom_field_22', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(273, '2021-07-04 18:37:44', '2021-07-09 17:19:09', 1, 'paragraph', '', 'clients', 'client_custom_field_23', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(274, '2021-07-04 18:37:44', '2021-07-09 17:19:09', 1, 'paragraph', '', 'clients', 'client_custom_field_24', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(275, '2021-07-04 18:37:44', '2021-07-09 17:19:09', 1, 'paragraph', '', 'clients', 'client_custom_field_25', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(276, '2021-07-04 18:37:44', '2021-07-09 17:19:09', 1, 'paragraph', '', 'clients', 'client_custom_field_26', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(277, '2021-07-04 18:37:44', '2021-07-09 17:19:09', 1, 'paragraph', '', 'clients', 'client_custom_field_27', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(278, '2021-07-04 18:37:44', '2021-07-09 17:19:09', 1, 'paragraph', '', 'clients', 'client_custom_field_28', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(279, '2021-07-04 18:37:44', '2021-07-09 17:19:09', 1, 'paragraph', '', 'clients', 'client_custom_field_29', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(280, '2021-07-04 18:37:44', '2021-07-09 17:19:09', 1, 'paragraph', '', 'clients', 'client_custom_field_30', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(281, '2021-07-04 18:37:54', '2021-08-04 15:27:30', 1, 'paragraph', '', 'projects', 'project_custom_field_21', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(282, '2021-07-04 18:37:54', '2022-10-02 15:07:53', 1, 'paragraph', '', 'projects', 'project_custom_field_22', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(283, '2021-07-04 18:37:54', '2021-07-09 17:27:39', 1, 'paragraph', '', 'projects', 'project_custom_field_23', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(284, '2021-07-04 18:37:54', '2021-07-09 17:27:39', 1, 'paragraph', '', 'projects', 'project_custom_field_24', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(285, '2021-07-04 18:37:54', '2021-07-09 17:27:39', 1, 'paragraph', '', 'projects', 'project_custom_field_25', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(286, '2021-07-04 18:37:54', '2021-07-09 17:27:39', 1, 'paragraph', '', 'projects', 'project_custom_field_26', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(287, '2021-07-04 18:37:54', '2021-07-09 17:27:39', 1, 'paragraph', '', 'projects', 'project_custom_field_27', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(288, '2021-07-04 18:37:54', '2021-07-09 17:27:39', 1, 'paragraph', '', 'projects', 'project_custom_field_28', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(289, '2021-07-04 18:37:54', '2021-07-09 17:27:39', 1, 'paragraph', '', 'projects', 'project_custom_field_29', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(290, '2021-07-04 18:37:54', '2021-07-09 17:27:39', 1, 'paragraph', '', 'projects', 'project_custom_field_30', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(291, '2021-07-04 18:38:13', '2022-10-02 15:13:52', 1, 'checkbox', '', 'tasks', 'task_custom_field_31', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(292, '2021-07-04 18:38:13', '2021-07-10 19:02:55', 1, 'checkbox', '', 'tasks', 'task_custom_field_32', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(293, '2021-07-04 18:38:13', '2021-07-10 19:02:55', 1, 'checkbox', '', 'tasks', 'task_custom_field_33', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(294, '2021-07-04 18:38:13', '2021-07-10 19:02:55', 1, 'checkbox', '', 'tasks', 'task_custom_field_34', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(295, '2021-07-04 18:38:13', '2021-07-10 19:02:55', 1, 'checkbox', '', 'tasks', 'task_custom_field_35', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(296, '2021-07-04 18:38:13', '2021-07-04 18:38:13', 1, 'checkbox', '', 'tasks', 'task_custom_field_36', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(297, '2021-07-04 18:38:13', '2021-07-04 18:38:13', 1, 'checkbox', '', 'tasks', 'task_custom_field_37', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(298, '2021-07-04 18:38:13', '2021-07-04 18:38:13', 1, 'checkbox', '', 'tasks', 'task_custom_field_38', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(299, '2021-07-04 18:38:13', '2021-07-04 18:38:13', 1, 'checkbox', '', 'tasks', 'task_custom_field_39', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(300, '2021-07-04 18:38:13', '2021-07-04 18:38:13', 1, 'checkbox', '', 'tasks', 'task_custom_field_40', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(301, '2021-07-04 18:38:22', '2022-11-24 15:04:51', 6, 'checkbox', '', 'clients', 'client_custom_field_31', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(302, '2021-07-04 18:38:22', '2022-04-13 12:24:37', 1, 'checkbox', '', 'clients', 'client_custom_field_32', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(303, '2021-07-04 18:38:22', '2021-07-09 17:19:32', 1, 'checkbox', '', 'clients', 'client_custom_field_33', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(304, '2021-07-04 18:38:22', '2021-07-09 17:19:32', 1, 'checkbox', '', 'clients', 'client_custom_field_34', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(305, '2021-07-04 18:38:22', '2021-07-09 17:19:32', 1, 'checkbox', '', 'clients', 'client_custom_field_35', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(306, '2021-07-04 18:38:22', '2021-07-09 17:19:32', 1, 'checkbox', '', 'clients', 'client_custom_field_36', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(307, '2021-07-04 18:38:22', '2021-07-09 17:19:32', 1, 'checkbox', '', 'clients', 'client_custom_field_37', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(308, '2021-07-04 18:38:22', '2021-07-09 17:19:32', 1, 'checkbox', '', 'clients', 'client_custom_field_38', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(309, '2021-07-04 18:38:22', '2021-07-09 17:19:32', 1, 'checkbox', '', 'clients', 'client_custom_field_39', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(310, '2021-07-04 18:38:22', '2021-07-09 17:19:32', 1, 'checkbox', '', 'clients', 'client_custom_field_40', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(311, '2021-07-04 18:38:32', '2021-08-04 15:28:44', 1, 'checkbox', '', 'projects', 'project_custom_field_31', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(312, '2021-07-04 18:38:32', '2022-10-02 15:08:26', 1, 'checkbox', '', 'projects', 'project_custom_field_32', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(313, '2021-07-04 18:38:32', '2021-07-09 17:27:58', 1, 'checkbox', '', 'projects', 'project_custom_field_33', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(314, '2021-07-04 18:38:32', '2021-07-09 17:27:58', 1, 'checkbox', '', 'projects', 'project_custom_field_34', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(315, '2021-07-04 18:38:32', '2021-07-09 17:27:58', 1, 'checkbox', '', 'projects', 'project_custom_field_35', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(316, '2021-07-04 18:38:32', '2021-07-09 17:27:58', 1, 'checkbox', '', 'projects', 'project_custom_field_36', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(317, '2021-07-04 18:38:32', '2021-07-09 17:27:58', 1, 'checkbox', '', 'projects', 'project_custom_field_37', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(318, '2021-07-04 18:38:32', '2021-07-09 17:27:58', 1, 'checkbox', '', 'projects', 'project_custom_field_38', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z');
INSERT INTO `customfields` (`customfields_id`, `customfields_created`, `customfields_updated`, `customfields_position`, `customfields_datatype`, `customfields_datapayload`, `customfields_type`, `customfields_name`, `customfields_title`, `customfields_required`, `customfields_show_client_page`, `customfields_show_project_page`, `customfields_show_task_summary`, `customfields_show_lead_summary`, `customfields_show_invoice`, `customfields_show_ticket_page`, `customfields_show_filter_panel`, `customfields_standard_form_status`, `customfields_status`, `customfields_sorting_a_z`) VALUES
(319, '2021-07-04 18:38:32', '2021-07-09 17:27:58', 1, 'checkbox', '', 'projects', 'project_custom_field_39', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(320, '2021-07-04 18:38:32', '2021-07-09 17:27:58', 1, 'checkbox', '', 'projects', 'project_custom_field_40', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(321, '2021-07-04 18:38:50', '2022-10-02 15:14:14', 1, 'dropdown', '', 'tasks', 'task_custom_field_41', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(322, '2021-07-04 18:38:50', '2021-07-10 19:03:11', 1, 'dropdown', '', 'tasks', 'task_custom_field_42', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(323, '2021-07-04 18:38:50', '2021-07-10 19:03:11', 1, 'dropdown', '', 'tasks', 'task_custom_field_43', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(324, '2021-07-04 18:38:50', '2021-07-10 19:03:11', 1, 'dropdown', '', 'tasks', 'task_custom_field_44', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(325, '2021-07-04 18:38:50', '2021-07-10 19:03:11', 1, 'dropdown', '', 'tasks', 'task_custom_field_45', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(326, '2021-07-04 18:38:50', '2021-07-04 18:38:50', 1, 'dropdown', '', 'tasks', 'task_custom_field_46', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(327, '2021-07-04 18:38:50', '2021-07-04 18:38:50', 1, 'dropdown', '', 'tasks', 'task_custom_field_47', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(328, '2021-07-04 18:38:50', '2021-07-04 18:38:50', 1, 'dropdown', '', 'tasks', 'task_custom_field_48', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(329, '2021-07-04 18:38:50', '2021-07-04 18:38:50', 1, 'dropdown', '', 'tasks', 'task_custom_field_49', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(330, '2021-07-04 18:38:50', '2021-07-04 18:38:50', 1, 'dropdown', '', 'tasks', 'task_custom_field_50', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(331, '2021-07-04 18:38:59', '2024-01-10 07:16:49', 3, 'dropdown', '', 'clients', 'client_custom_field_41', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(332, '2021-07-04 18:38:59', '2021-08-04 14:17:27', 4, 'dropdown', '', 'clients', 'client_custom_field_42', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(333, '2021-07-04 18:38:59', '2021-07-09 17:19:44', 1, 'dropdown', '', 'clients', 'client_custom_field_43', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(334, '2021-07-04 18:38:59', '2021-07-09 17:19:44', 1, 'dropdown', '', 'clients', 'client_custom_field_44', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(335, '2021-07-04 18:38:59', '2021-07-09 17:19:44', 1, 'dropdown', '', 'clients', 'client_custom_field_45', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(336, '2021-07-04 18:38:59', '2021-07-09 17:19:44', 1, 'dropdown', '', 'clients', 'client_custom_field_46', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(337, '2021-07-04 18:38:59', '2021-07-09 17:19:44', 1, 'dropdown', '', 'clients', 'client_custom_field_47', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(338, '2021-07-04 18:38:59', '2021-07-09 17:19:44', 1, 'dropdown', '', 'clients', 'client_custom_field_48', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(339, '2021-07-04 18:38:59', '2021-07-09 17:19:44', 1, 'dropdown', '', 'clients', 'client_custom_field_49', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(340, '2021-07-04 18:38:59', '2021-07-09 17:19:44', 1, 'dropdown', '', 'clients', 'client_custom_field_50', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(341, '2021-07-04 18:39:09', '2023-02-07 09:39:31', 1, 'dropdown', '', 'projects', 'project_custom_field_41', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(342, '2021-07-04 18:39:09', '2021-08-04 15:29:16', 1, 'dropdown', '', 'projects', 'project_custom_field_42', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(343, '2021-07-04 18:39:09', '2021-07-09 17:28:08', 1, 'dropdown', '', 'projects', 'project_custom_field_43', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(344, '2021-07-04 18:39:09', '2021-07-09 17:28:08', 1, 'dropdown', '', 'projects', 'project_custom_field_44', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(345, '2021-07-04 18:39:09', '2021-07-09 17:28:08', 1, 'dropdown', '', 'projects', 'project_custom_field_45', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(346, '2021-07-04 18:39:09', '2021-07-09 17:28:08', 1, 'dropdown', '', 'projects', 'project_custom_field_46', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(347, '2021-07-04 18:39:09', '2021-07-09 17:28:08', 1, 'dropdown', '', 'projects', 'project_custom_field_47', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(348, '2021-07-04 18:39:09', '2021-07-09 17:28:08', 1, 'dropdown', '', 'projects', 'project_custom_field_48', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(349, '2021-07-04 18:39:09', '2021-07-09 17:28:08', 1, 'dropdown', '', 'projects', 'project_custom_field_49', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(350, '2021-07-04 18:39:09', '2021-07-09 17:28:08', 1, 'dropdown', '', 'projects', 'project_custom_field_50', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(351, '2021-07-04 18:39:27', '2022-10-02 15:14:31', 1, 'number', '', 'tasks', 'task_custom_field_51', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(352, '2021-07-04 18:39:27', '2021-07-10 19:03:28', 1, 'number', '', 'tasks', 'task_custom_field_52', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(353, '2021-07-04 18:39:27', '2021-07-10 19:03:28', 1, 'number', '', 'tasks', 'task_custom_field_53', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(354, '2021-07-04 18:39:28', '2021-07-10 19:03:28', 1, 'number', '', 'tasks', 'task_custom_field_54', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(355, '2021-07-04 18:39:28', '2021-07-10 19:03:28', 1, 'number', '', 'tasks', 'task_custom_field_55', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(356, '2021-07-04 18:39:28', '2021-07-04 18:39:28', 1, 'number', '', 'tasks', 'task_custom_field_56', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(357, '2021-07-04 18:39:28', '2021-07-04 18:39:28', 1, 'number', '', 'tasks', 'task_custom_field_57', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(358, '2021-07-04 18:39:28', '2021-07-04 18:39:28', 1, 'number', '', 'tasks', 'task_custom_field_58', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(359, '2021-07-04 18:39:28', '2021-07-04 18:39:28', 1, 'number', '', 'tasks', 'task_custom_field_59', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(360, '2021-07-04 18:39:28', '2021-07-04 18:39:28', 1, 'number', '', 'tasks', 'task_custom_field_60', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(361, '2021-07-04 18:39:37', '2022-11-24 15:04:41', 1, 'number', '', 'clients', 'client_custom_field_51', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(362, '2021-07-04 18:39:37', '2022-04-13 12:24:54', 1, 'number', '', 'clients', 'client_custom_field_52', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(363, '2021-07-04 18:39:37', '2021-07-09 17:19:53', 1, 'number', '', 'clients', 'client_custom_field_53', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(364, '2021-07-04 18:39:37', '2021-07-09 17:19:53', 1, 'number', '', 'clients', 'client_custom_field_54', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(365, '2021-07-04 18:39:37', '2021-07-09 17:19:53', 1, 'number', '', 'clients', 'client_custom_field_55', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(366, '2021-07-04 18:39:37', '2021-07-09 17:19:53', 1, 'number', '', 'clients', 'client_custom_field_56', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(367, '2021-07-04 18:39:37', '2021-07-09 17:19:53', 1, 'number', '', 'clients', 'client_custom_field_57', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(368, '2021-07-04 18:39:37', '2021-07-09 17:19:53', 1, 'number', '', 'clients', 'client_custom_field_58', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(369, '2021-07-04 18:39:37', '2021-07-09 17:19:53', 1, 'number', '', 'clients', 'client_custom_field_59', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(370, '2021-07-04 18:39:37', '2021-07-09 17:19:53', 1, 'number', '', 'clients', 'client_custom_field_60', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(371, '2021-07-04 18:39:46', '2021-08-04 15:29:25', 1, 'number', '', 'projects', 'project_custom_field_51', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(372, '2021-07-04 18:39:46', '2022-10-02 15:09:07', 1, 'number', '', 'projects', 'project_custom_field_52', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(373, '2021-07-04 18:39:46', '2021-07-09 17:28:20', 1, 'number', '', 'projects', 'project_custom_field_53', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(374, '2021-07-04 18:39:46', '2021-07-09 17:28:20', 1, 'number', '', 'projects', 'project_custom_field_54', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(375, '2021-07-04 18:39:47', '2021-07-09 17:28:20', 1, 'number', '', 'projects', 'project_custom_field_55', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(376, '2021-07-04 18:39:47', '2021-07-09 17:28:20', 1, 'number', '', 'projects', 'project_custom_field_56', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(377, '2021-07-04 18:39:47', '2021-07-09 17:28:20', 1, 'number', '', 'projects', 'project_custom_field_57', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(378, '2021-07-04 18:39:47', '2021-07-09 17:28:20', 1, 'number', '', 'projects', 'project_custom_field_58', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(379, '2021-07-04 18:39:47', '2021-07-09 17:28:20', 1, 'number', '', 'projects', 'project_custom_field_59', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(380, '2021-07-04 18:39:47', '2021-07-09 17:28:20', 1, 'number', '', 'projects', 'project_custom_field_60', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(381, '2021-07-04 19:18:10', '2022-10-02 15:14:47', 1, 'decimal', '', 'tasks', 'task_custom_field_61', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(382, '2021-07-04 19:18:10', '2021-07-10 19:03:47', 1, 'decimal', '', 'tasks', 'task_custom_field_62', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(383, '2021-07-04 19:18:10', '2021-07-10 19:03:47', 1, 'decimal', '', 'tasks', 'task_custom_field_63', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(384, '2021-07-04 19:18:10', '2021-07-10 19:03:47', 1, 'decimal', '', 'tasks', 'task_custom_field_64', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(385, '2021-07-04 19:18:10', '2021-07-10 19:03:47', 1, 'decimal', '', 'tasks', 'task_custom_field_65', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(386, '2021-07-04 19:18:10', '2021-07-04 19:18:10', 1, 'decimal', '', 'tasks', 'task_custom_field_66', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(387, '2021-07-04 19:18:10', '2021-07-04 19:18:10', 1, 'decimal', '', 'tasks', 'task_custom_field_67', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(388, '2021-07-04 19:18:10', '2021-07-04 19:18:10', 1, 'decimal', '', 'tasks', 'task_custom_field_68', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(389, '2021-07-04 19:18:10', '2021-07-04 19:18:10', 1, 'decimal', '', 'tasks', 'task_custom_field_69', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(390, '2021-07-04 19:18:10', '2021-07-04 19:18:10', 1, 'decimal', '', 'tasks', 'task_custom_field_70', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(391, '2021-07-04 19:18:19', '2022-11-24 15:04:45', 1, 'decimal', '', 'clients', 'client_custom_field_61', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(392, '2021-07-04 19:18:19', '2021-08-04 14:20:41', 1, 'decimal', '', 'clients', 'client_custom_field_62', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(393, '2021-07-04 19:18:19', '2022-04-13 12:25:02', 2, 'decimal', '', 'clients', 'client_custom_field_63', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(394, '2021-07-04 19:18:19', '2021-07-09 17:20:01', 1, 'decimal', '', 'clients', 'client_custom_field_64', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(395, '2021-07-04 19:18:19', '2021-07-09 17:20:01', 1, 'decimal', '', 'clients', 'client_custom_field_65', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(396, '2021-07-04 19:18:19', '2021-07-09 17:20:01', 1, 'decimal', '', 'clients', 'client_custom_field_66', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(397, '2021-07-04 19:18:20', '2021-07-09 17:20:01', 1, 'decimal', '', 'clients', 'client_custom_field_67', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(398, '2021-07-04 19:18:20', '2021-07-09 17:20:01', 1, 'decimal', '', 'clients', 'client_custom_field_68', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(399, '2021-07-04 19:18:20', '2021-07-09 17:20:01', 1, 'decimal', '', 'clients', 'client_custom_field_69', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(400, '2021-07-04 19:18:20', '2021-07-09 17:20:01', 1, 'decimal', '', 'clients', 'client_custom_field_70', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(401, '2021-07-04 19:18:29', '2021-07-13 19:32:34', 1, 'decimal', '', 'projects', 'project_custom_field_61', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(402, '2021-07-04 19:18:29', '2022-10-02 15:09:22', 1, 'decimal', '', 'projects', 'project_custom_field_62', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(403, '2021-07-04 19:18:29', '2021-07-09 17:28:30', 1, 'decimal', '', 'projects', 'project_custom_field_63', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(404, '2021-07-04 19:18:29', '2021-07-09 17:28:30', 1, 'decimal', '', 'projects', 'project_custom_field_64', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(405, '2021-07-04 19:18:29', '2021-07-09 17:28:30', 1, 'decimal', '', 'projects', 'project_custom_field_65', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(406, '2021-07-04 19:18:29', '2021-07-09 17:28:30', 1, 'decimal', '', 'projects', 'project_custom_field_66', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(407, '2021-07-04 19:18:29', '2021-07-09 17:28:30', 1, 'decimal', '', 'projects', 'project_custom_field_67', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(408, '2021-07-04 19:18:29', '2021-07-09 17:28:30', 1, 'decimal', '', 'projects', 'project_custom_field_68', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(409, '2021-07-04 19:18:30', '2021-07-09 17:28:30', 1, 'decimal', '', 'projects', 'project_custom_field_69', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(410, '2021-07-04 19:18:30', '2021-07-09 17:28:30', 1, 'decimal', '', 'projects', 'project_custom_field_70', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(411, '2021-01-09 17:04:09', '2022-09-30 13:45:36', 1, 'text', '', 'tickets', 'ticket_custom_field_1', '', 'no', 'no', 'no', 'no', 'no', 'no', 'yes', 'no', 'disabled', 'disabled', 'z'),
(412, '2021-01-09 17:04:15', '2022-08-28 16:46:11', 5, 'text', '', 'tickets', 'ticket_custom_field_2', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(413, '2021-01-09 17:04:19', '2022-08-28 16:46:11', 1, 'text', '', 'tickets', 'ticket_custom_field_3', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(414, '2021-01-09 17:04:25', '2022-08-28 16:46:11', 1, 'text', '', 'tickets', 'ticket_custom_field_4', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(415, '2021-01-09 17:04:30', '2022-08-28 16:46:11', 1, 'text', '', 'tickets', 'ticket_custom_field_5', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(416, '2021-01-09 17:04:35', '2021-07-09 16:49:47', 1, 'text', '', 'tickets', 'ticket_custom_field_6', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(417, '2021-01-09 17:04:41', '2021-07-09 16:49:47', 1, 'text', '', 'tickets', 'ticket_custom_field_7', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(418, '2021-01-09 17:04:46', '2021-07-09 16:49:47', 1, 'text', '', 'tickets', 'ticket_custom_field_8', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(419, '2021-01-09 17:04:51', '2021-07-09 16:49:47', 1, 'text', '', 'tickets', 'ticket_custom_field_9', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(420, '2021-01-09 17:04:57', '2021-07-09 16:49:47', 1, 'text', '', 'tickets', 'ticket_custom_field_10', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(421, '2021-07-04 18:36:41', '2022-09-30 16:05:31', 1, 'date', '', 'tickets', 'ticket_custom_field_11', '', 'no', 'no', 'no', 'no', 'no', 'no', 'yes', 'no', 'disabled', 'disabled', 'z'),
(422, '2021-07-04 18:36:41', '2022-09-30 16:04:25', 1, 'date', '', 'tickets', 'ticket_custom_field_12', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(423, '2021-07-04 18:36:41', '2022-09-30 16:04:25', 1, 'date', '', 'tickets', 'ticket_custom_field_13', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(424, '2021-07-04 18:36:41', '2022-09-30 16:04:25', 1, 'date', '', 'tickets', 'ticket_custom_field_14', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(425, '2021-07-04 18:36:41', '2022-09-30 16:04:25', 1, 'date', '', 'tickets', 'ticket_custom_field_15', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(426, '2021-07-04 18:36:41', '2021-07-09 17:19:20', 1, 'date', '', 'tickets', 'ticket_custom_field_16', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(427, '2021-07-04 18:36:41', '2021-07-09 17:19:20', 1, 'date', '', 'tickets', 'ticket_custom_field_17', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(428, '2021-07-04 18:36:41', '2021-07-09 17:19:20', 1, 'date', '', 'tickets', 'ticket_custom_field_18', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(429, '2021-07-04 18:36:41', '2021-07-09 17:19:20', 1, 'date', '', 'tickets', 'ticket_custom_field_19', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(430, '2021-07-04 18:36:41', '2021-07-09 17:19:20', 1, 'date', '', 'tickets', 'ticket_custom_field_20', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(431, '2021-07-04 18:37:44', '2022-09-30 16:05:39', 1, 'paragraph', '', 'tickets', 'ticket_custom_field_21', '', 'no', 'no', 'no', 'no', 'no', 'no', 'yes', 'no', 'disabled', 'disabled', 'z'),
(432, '2021-07-04 18:37:44', '2022-09-30 16:03:53', 1, 'paragraph', '', 'tickets', 'ticket_custom_field_22', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(433, '2021-07-04 18:37:44', '2022-09-30 16:03:53', 1, 'paragraph', '', 'tickets', 'ticket_custom_field_23', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(434, '2021-07-04 18:37:44', '2022-09-30 16:03:53', 1, 'paragraph', '', 'tickets', 'ticket_custom_field_24', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(435, '2021-07-04 18:37:44', '2022-09-30 16:03:53', 1, 'paragraph', '', 'tickets', 'ticket_custom_field_25', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(436, '2021-07-04 18:37:44', '2021-07-09 17:19:09', 1, 'paragraph', '', 'tickets', 'ticket_custom_field_26', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(437, '2021-07-04 18:37:44', '2021-07-09 17:19:09', 1, 'paragraph', '', 'tickets', 'ticket_custom_field_27', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(438, '2021-07-04 18:37:44', '2021-07-09 17:19:09', 1, 'paragraph', '', 'tickets', 'ticket_custom_field_28', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(439, '2021-07-04 18:37:44', '2021-07-09 17:19:09', 1, 'paragraph', '', 'tickets', 'ticket_custom_field_29', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(440, '2021-07-04 18:37:44', '2021-07-09 17:19:09', 1, 'paragraph', '', 'tickets', 'ticket_custom_field_30', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(441, '2021-07-04 18:38:22', '2022-09-30 16:05:23', 6, 'checkbox', '', 'tickets', 'ticket_custom_field_31', '', 'no', 'no', 'no', 'no', 'no', 'no', 'yes', 'no', 'disabled', 'disabled', 'z'),
(442, '2021-07-04 18:38:22', '2022-09-30 16:04:51', 1, 'checkbox', '', 'tickets', 'ticket_custom_field_32', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(443, '2021-07-04 18:38:22', '2022-09-30 16:04:51', 1, 'checkbox', '', 'tickets', 'ticket_custom_field_33', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(444, '2021-07-04 18:38:22', '2022-09-30 16:04:51', 1, 'checkbox', '', 'tickets', 'ticket_custom_field_34', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(445, '2021-07-04 18:38:22', '2022-09-30 16:04:51', 1, 'checkbox', '', 'tickets', 'ticket_custom_field_35', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(446, '2021-07-04 18:38:22', '2021-07-09 17:19:32', 1, 'checkbox', '', 'tickets', 'ticket_custom_field_36', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(447, '2021-07-04 18:38:22', '2021-07-09 17:19:32', 1, 'checkbox', '', 'tickets', 'ticket_custom_field_37', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(448, '2021-07-04 18:38:22', '2021-07-09 17:19:32', 1, 'checkbox', '', 'tickets', 'ticket_custom_field_38', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(449, '2021-07-04 18:38:22', '2021-07-09 17:19:32', 1, 'checkbox', '', 'tickets', 'ticket_custom_field_39', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(450, '2021-07-04 18:38:22', '2021-07-09 17:19:32', 1, 'checkbox', '', 'tickets', 'ticket_custom_field_40', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(451, '2021-07-04 18:38:59', '2022-09-30 16:05:13', 3, 'dropdown', '', 'tickets', 'ticket_custom_field_41', '', 'no', 'no', 'no', 'no', 'no', 'no', 'yes', 'no', 'disabled', 'disabled', 'z'),
(452, '2021-07-04 18:38:59', '2022-09-30 16:05:13', 4, 'dropdown', '', 'tickets', 'ticket_custom_field_42', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(453, '2021-07-04 18:38:59', '2022-09-30 16:05:13', 1, 'dropdown', '', 'tickets', 'ticket_custom_field_43', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(454, '2021-07-04 18:38:59', '2022-09-30 16:05:13', 1, 'dropdown', '', 'tickets', 'ticket_custom_field_44', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(455, '2021-07-04 18:38:59', '2022-09-30 16:05:13', 1, 'dropdown', '', 'tickets', 'ticket_custom_field_45', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(456, '2021-07-04 18:38:59', '2021-07-09 17:19:44', 1, 'dropdown', '', 'tickets', 'ticket_custom_field_46', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(457, '2021-07-04 18:38:59', '2021-07-09 17:19:44', 1, 'dropdown', '', 'tickets', 'ticket_custom_field_47', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(458, '2021-07-04 18:38:59', '2021-07-09 17:19:44', 1, 'dropdown', '', 'tickets', 'ticket_custom_field_48', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(459, '2021-07-04 18:38:59', '2021-07-09 17:19:44', 1, 'dropdown', '', 'tickets', 'ticket_custom_field_49', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(460, '2021-07-04 18:38:59', '2021-07-09 17:19:44', 1, 'dropdown', '', 'tickets', 'ticket_custom_field_50', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(461, '2021-07-04 18:39:37', '2022-09-30 16:05:58', 1, 'number', '', 'tickets', 'ticket_custom_field_51', '', 'no', 'no', 'no', 'no', 'no', 'no', 'yes', 'no', 'disabled', 'disabled', 'z'),
(462, '2021-07-04 18:39:37', '2022-09-30 16:05:58', 1, 'number', '', 'tickets', 'ticket_custom_field_52', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(463, '2021-07-04 18:39:37', '2022-09-30 16:05:58', 1, 'number', '', 'tickets', 'ticket_custom_field_53', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(464, '2021-07-04 18:39:37', '2022-09-30 16:05:58', 1, 'number', '', 'tickets', 'ticket_custom_field_54', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(465, '2021-07-04 18:39:37', '2022-09-30 16:05:58', 1, 'number', '', 'tickets', 'ticket_custom_field_55', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(466, '2021-07-04 18:39:37', '2021-07-09 17:19:53', 1, 'number', '', 'tickets', 'ticket_custom_field_56', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(467, '2021-07-04 18:39:37', '2021-07-09 17:19:53', 1, 'number', '', 'tickets', 'ticket_custom_field_57', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(468, '2021-07-04 18:39:37', '2021-07-09 17:19:53', 1, 'number', '', 'tickets', 'ticket_custom_field_58', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(469, '2021-07-04 18:39:37', '2021-07-09 17:19:53', 1, 'number', '', 'tickets', 'ticket_custom_field_59', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(470, '2021-07-04 18:39:37', '2021-07-09 17:19:53', 1, 'number', '', 'tickets', 'ticket_custom_field_60', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(471, '2021-07-04 19:18:19', '2022-09-30 16:06:19', 1, 'decimal', '', 'tickets', 'ticket_custom_field_61', '', 'no', 'no', 'no', 'no', 'no', 'no', 'yes', 'no', 'disabled', 'disabled', 'z'),
(472, '2021-07-04 19:18:19', '2022-09-30 16:06:19', 1, 'decimal', '', 'tickets', 'ticket_custom_field_62', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(473, '2021-07-04 19:18:19', '2022-09-30 16:06:19', 2, 'decimal', '', 'tickets', 'ticket_custom_field_63', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(474, '2021-07-04 19:18:19', '2022-09-30 16:06:19', 1, 'decimal', '', 'tickets', 'ticket_custom_field_64', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(475, '2021-07-04 19:18:19', '2022-09-30 16:06:19', 1, 'decimal', '', 'tickets', 'ticket_custom_field_65', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(476, '2021-07-04 19:18:19', '2021-07-09 17:20:01', 1, 'decimal', '', 'tickets', 'ticket_custom_field_66', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(477, '2021-07-04 19:18:20', '2021-07-09 17:20:01', 1, 'decimal', '', 'tickets', 'ticket_custom_field_67', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(478, '2021-07-04 19:18:20', '2021-07-09 17:20:01', 1, 'decimal', '', 'tickets', 'ticket_custom_field_68', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(479, '2021-07-04 19:18:20', '2021-07-09 17:20:01', 1, 'decimal', '', 'tickets', 'ticket_custom_field_69', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z'),
(480, '2021-07-04 19:18:20', '2021-07-09 17:20:01', 1, 'decimal', '', 'tickets', 'ticket_custom_field_70', '', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'disabled', 'disabled', 'z');

-- --------------------------------------------------------

--
-- Table structure for table `email_log`
--

CREATE TABLE `email_log` (
  `emaillog_id` int(11) NOT NULL,
  `emaillog_created` datetime DEFAULT NULL,
  `emaillog_updated` datetime DEFAULT NULL,
  `emaillog_email` varchar(100) DEFAULT NULL,
  `emaillog_subject` varchar(200) DEFAULT NULL,
  `emaillog_body` text DEFAULT NULL,
  `emaillog_attachment` varchar(250) DEFAULT 'attached file name'
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='[truncate]' ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `email_queue`
--

CREATE TABLE `email_queue` (
  `emailqueue_id` int(11) NOT NULL,
  `emailqueue_created` datetime NOT NULL,
  `emailqueue_updated` datetime NOT NULL,
  `emailqueue_to` varchar(150) DEFAULT NULL,
  `emailqueue_from_email` varchar(150) DEFAULT NULL COMMENT 'optional (used in sending client direct email)',
  `emailqueue_from_name` varchar(150) DEFAULT NULL COMMENT 'optional (used in sending client direct email)',
  `emailqueue_subject` varchar(250) DEFAULT NULL,
  `emailqueue_message` text DEFAULT NULL,
  `emailqueue_type` varchar(150) DEFAULT 'general' COMMENT 'general|pdf (used for emails that need to generate a pdf)',
  `emailqueue_attachments` text DEFAULT NULL COMMENT 'json of request(''attachments'')',
  `emailqueue_resourcetype` varchar(10) DEFAULT NULL COMMENT 'e.g. invoice. Used mainly for deleting records, when resource has been deleted',
  `emailqueue_resourceid` int(11) DEFAULT NULL,
  `emailqueue_pdf_resource_type` varchar(50) DEFAULT NULL COMMENT 'estimate|invoice',
  `emailqueue_pdf_resource_id` int(11) DEFAULT NULL COMMENT 'resource id (e.g. estimate id)',
  `emailqueue_started_at` datetime DEFAULT NULL COMMENT 'timestamp of when processing started',
  `emailqueue_status` varchar(20) DEFAULT 'new' COMMENT 'new|processing (set to processing by the cronjob, to avoid duplicate processing)'
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='[truncate]' ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `email_queue`
--

INSERT INTO `email_queue` (`emailqueue_id`, `emailqueue_created`, `emailqueue_updated`, `emailqueue_to`, `emailqueue_from_email`, `emailqueue_from_name`, `emailqueue_subject`, `emailqueue_message`, `emailqueue_type`, `emailqueue_attachments`, `emailqueue_resourcetype`, `emailqueue_resourceid`, `emailqueue_pdf_resource_type`, `emailqueue_pdf_resource_id`, `emailqueue_started_at`, `emailqueue_status`) VALUES
(1, '2024-02-15 23:00:32', '2024-02-15 23:00:32', 'taha18944@gmail.com', NULL, NULL, 'Welcome - Your Account Details', '<!DOCTYPE html>\n<html>\n\n<head>\n\n    <meta charset=\"utf-8\">\n    <meta http-equiv=\"x-ua-compatible\" content=\"ie=edge\">\n    <title>Email Confirmation</title>\n    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">\n    <style type=\"text/css\">\n        @media screen {\n            @font-face {\n                font-family: \'Source Sans Pro\';\n                font-style: normal;\n                font-weight: 400;\n                src: local(\'Source Sans Pro Regular\'), local(\'SourceSansPro-Regular\'), url(https://fonts.gstatic.com/s/sourcesanspro/v10/ODelI1aHBYDBqgeIAH2zlBM0YzuT7MdOe03otPbuUS0.woff) format(\'woff\');\n            }\n\n            @font-face {\n                font-family: \'Source Sans Pro\';\n                font-style: normal;\n                font-weight: 700;\n                src: local(\'Source Sans Pro Bold\'), local(\'SourceSansPro-Bold\'), url(https://fonts.gstatic.com/s/sourcesanspro/v10/toadOcfmlt9b38dHJxOBGFkQc6VGVFSmCnC_l7QZG60.woff) format(\'woff\');\n            }\n        }\n\n        body,\n        table,\n        td,\n        a {\n            -ms-text-size-adjust: 100%;\n            /* 1 */\n            -webkit-text-size-adjust: 100%;\n            /* 2 */\n        }\n\n        img {\n            -ms-interpolation-mode: bicubic;\n        }\n\n        a[x-apple-data-detectors] {\n            font-family: inherit !important;\n            font-size: inherit !important;\n            font-weight: inherit !important;\n            line-height: inherit !important;\n            color: inherit !important;\n            text-decoration: none !important;\n        }\n\n        div[style*=\"margin: 16px 0;\"] {\n            margin: 0 !important;\n        }\n\n        body {\n            width: 100% !important;\n            height: 100% !important;\n            padding: 0 !important;\n            margin: 0 !important;\n            padding: 24px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 16px;\n            background-color: #f9fafc;\n            color: #60676d;\n        }\n\n        table {\n            border-collapse: collapse !important;\n        }\n\n        a {\n            color: #1a82e2;\n        }\n\n        img {\n            height: auto;\n            line-height: 100%;\n            text-decoration: none;\n            border: 0;\n            outline: none;\n        }\n\n        .table-1 {\n            max-width: 600px;\n        }\n\n        .table-1 td {\n            padding: 36px 24px 40px;\n            text-align: center;\n        }\n\n        .table-1 h1 {\n            margin: 0;\n            font-size: 32px;\n            font-weight: 600;\n            letter-spacing: -1px;\n            line-height: 48px;\n        }\n\n        .table-2 {\n            max-width: 600px;\n        }\n\n        .table-2 td {\n            padding: 36px 24px 0;\n            border-top: 3px solid #d4dadf;\n            background-color: #ffffff;\n        }\n\n        .table-2 h1 {\n            margin: 0;\n            font-size: 20px;\n            font-weight: 600;\n            letter-spacing: -1px;\n            line-height: 48px;\n        }\n\n        .table-3 {\n            max-width: 600px;\n        }\n\n        .table-2 td {\n\n            background-color: #ffffff;\n        }\n\n        .td-1 {\n            padding: 24px;\n            font-size: 16px;\n            line-height: 24px;\n            background-color: #ffffff;\n            text-align: left;\n            padding-bottom: 10px;\n            padding-top: 0px;\n        }\n\n        .table-gray {\n            width: 100%;\n        }\n\n        .table-gray tr {\n            height: 24px;\n        }\n\n        .table-gray .td-1 {\n            background-color: #f1f3f7;\n            width: 30%;\n            border: solid 1px #e7e9ec;\n            padding-top: 5px;\n            padding-bottom: 5px;\n        }\n\n        .table-gray .td-2 {\n            background-color: #f1f3f7;\n            width: 70%;\n            border: solid 1px #e7e9ec;\n        }\n\n        .button, .button:active, .button:visited {\n            display: inline-block;\n            padding: 16px 36px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 16px;\n            color: #ffffff;\n            text-decoration: none;\n            border-radius: 6px;\n            background-color: #1a82e2;\n            border-radius: 6px;\n        }\n\n        .signature {\n            padding: 24px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 16px;\n            line-height: 24px;\n            border-bottom: 3px solid #d4dadf;\n            background-color: #ffffff;\n        }\n\n        .footer {\n            max-width: 600px;\n        }\n\n        .footer td {\n            padding: 12px 24px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 14px;\n            line-height: 20px;\n            color: #666;\n        }\n\n        .td-button {\n            padding: 12px;\n            background-color: #ffffff;\n            text-align: center;\n        }\n\n        .p-24 {\n            padding: 24px;\n        }\n    </style>\n\n</head>\n\n<body>\n<!-- start body -->\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start hero -->\n<tbody>\n<tr>\n<td align=\"center\">\n<table class=\"table-1\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td align=\"left\">\n<h1>Welcome</h1>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end hero --> <!-- start hero -->\n<tr>\n<td align=\"center\">\n<table class=\"table-2\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td align=\"left\">\n<h1>Hi Talha,</h1>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end hero --> <!-- start copy block -->\n<tr>\n<td align=\"center\">\n<table class=\"table-3\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start copy -->\n<tbody>\n<tr>\n<td class=\"td-1\">\n<p>Your account has been created. Below are your login details.</p>\n</td>\n</tr>\n<tr>\n<td class=\"td-1\">\n<table class=\"table-gray\" cellpadding=\"5\">\n<tbody>\n<tr>\n<td class=\"td-1\"><strong>Username</strong></td>\n<td class=\"td-2\">taha18944@gmail.com</td>\n</tr>\n<tr>\n<td class=\"td-1\"><strong>Password</strong></td>\n<td class=\"td-2\">tUuhJ1N</td>\n</tr>\n</tbody>\n</table>\n<p>You will be asked to change your password the first time you log in.</p>\n</td>\n</tr>\n<tr>\n<td align=\"left\" bgcolor=\"#ffffff\">\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td class=\"td-button\">\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td align=\"center\"><a class=\"button\" href=\"http://growcrm.test\" target=\"_blank\" rel=\"noopener\">Login To You Account</a></td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<tr>\n<td class=\"signature\">\n<p><div align=\"left\">\r\n<p>Thanks,</p>\r\n<p><strong>Support Team</strong></p>\r\n</div></p>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end copy block --> <!-- start footer -->\n<tr>\n<td class=\"p-24\" align=\"center\">\n<table class=\"footer\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start permission -->\n<tbody>\n<tr>\n<td align=\"center\">\n<p><p>You received this email because you have an account with us. You can change your email preferences in your account dashboard.</p></p>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end footer --></tbody>\n</table>\n<!-- end body -->\n</body>\n\n</html>', 'general', NULL, NULL, NULL, NULL, NULL, NULL, 'new'),
(2, '2024-02-16 23:49:49', '2024-02-16 23:49:49', 'test@test12.com', NULL, NULL, 'Welcome - Your Account Details', '<!DOCTYPE html>\n<html>\n\n<head>\n\n    <meta charset=\"utf-8\">\n    <meta http-equiv=\"x-ua-compatible\" content=\"ie=edge\">\n    <title>Email Confirmation</title>\n    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">\n    <style type=\"text/css\">\n        @media screen {\n            @font-face {\n                font-family: \'Source Sans Pro\';\n                font-style: normal;\n                font-weight: 400;\n                src: local(\'Source Sans Pro Regular\'), local(\'SourceSansPro-Regular\'), url(https://fonts.gstatic.com/s/sourcesanspro/v10/ODelI1aHBYDBqgeIAH2zlBM0YzuT7MdOe03otPbuUS0.woff) format(\'woff\');\n            }\n\n            @font-face {\n                font-family: \'Source Sans Pro\';\n                font-style: normal;\n                font-weight: 700;\n                src: local(\'Source Sans Pro Bold\'), local(\'SourceSansPro-Bold\'), url(https://fonts.gstatic.com/s/sourcesanspro/v10/toadOcfmlt9b38dHJxOBGFkQc6VGVFSmCnC_l7QZG60.woff) format(\'woff\');\n            }\n        }\n\n        body,\n        table,\n        td,\n        a {\n            -ms-text-size-adjust: 100%;\n            /* 1 */\n            -webkit-text-size-adjust: 100%;\n            /* 2 */\n        }\n\n        img {\n            -ms-interpolation-mode: bicubic;\n        }\n\n        a[x-apple-data-detectors] {\n            font-family: inherit !important;\n            font-size: inherit !important;\n            font-weight: inherit !important;\n            line-height: inherit !important;\n            color: inherit !important;\n            text-decoration: none !important;\n        }\n\n        div[style*=\"margin: 16px 0;\"] {\n            margin: 0 !important;\n        }\n\n        body {\n            width: 100% !important;\n            height: 100% !important;\n            padding: 0 !important;\n            margin: 0 !important;\n            padding: 24px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 16px;\n            background-color: #f9fafc;\n            color: #60676d;\n        }\n\n        table {\n            border-collapse: collapse !important;\n        }\n\n        a {\n            color: #1a82e2;\n        }\n\n        img {\n            height: auto;\n            line-height: 100%;\n            text-decoration: none;\n            border: 0;\n            outline: none;\n        }\n\n        .table-1 {\n            max-width: 600px;\n        }\n\n        .table-1 td {\n            padding: 36px 24px 40px;\n            text-align: center;\n        }\n\n        .table-1 h1 {\n            margin: 0;\n            font-size: 32px;\n            font-weight: 600;\n            letter-spacing: -1px;\n            line-height: 48px;\n        }\n\n        .table-2 {\n            max-width: 600px;\n        }\n\n        .table-2 td {\n            padding: 36px 24px 0;\n            border-top: 3px solid #d4dadf;\n            background-color: #ffffff;\n        }\n\n        .table-2 h1 {\n            margin: 0;\n            font-size: 20px;\n            font-weight: 600;\n            letter-spacing: -1px;\n            line-height: 48px;\n        }\n\n        .table-3 {\n            max-width: 600px;\n        }\n\n        .table-2 td {\n\n            background-color: #ffffff;\n        }\n\n        .td-1 {\n            padding: 24px;\n            font-size: 16px;\n            line-height: 24px;\n            background-color: #ffffff;\n            text-align: left;\n            padding-bottom: 10px;\n            padding-top: 0px;\n        }\n\n        .table-gray {\n            width: 100%;\n        }\n\n        .table-gray tr {\n            height: 24px;\n        }\n\n        .table-gray .td-1 {\n            background-color: #f1f3f7;\n            width: 30%;\n            border: solid 1px #e7e9ec;\n            padding-top: 5px;\n            padding-bottom: 5px;\n        }\n\n        .table-gray .td-2 {\n            background-color: #f1f3f7;\n            width: 70%;\n            border: solid 1px #e7e9ec;\n        }\n\n        .button, .button:active, .button:visited {\n            display: inline-block;\n            padding: 16px 36px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 16px;\n            color: #ffffff;\n            text-decoration: none;\n            border-radius: 6px;\n            background-color: #1a82e2;\n            border-radius: 6px;\n        }\n\n        .signature {\n            padding: 24px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 16px;\n            line-height: 24px;\n            border-bottom: 3px solid #d4dadf;\n            background-color: #ffffff;\n        }\n\n        .footer {\n            max-width: 600px;\n        }\n\n        .footer td {\n            padding: 12px 24px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 14px;\n            line-height: 20px;\n            color: #666;\n        }\n\n        .td-button {\n            padding: 12px;\n            background-color: #ffffff;\n            text-align: center;\n        }\n\n        .p-24 {\n            padding: 24px;\n        }\n    </style>\n\n</head>\n\n<body>\n<!-- start body -->\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start hero -->\n<tbody>\n<tr>\n<td align=\"center\">\n<table class=\"table-1\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td align=\"left\">\n<h1>Welcome</h1>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end hero --> <!-- start hero -->\n<tr>\n<td align=\"center\">\n<table class=\"table-2\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td align=\"left\">\n<h1>Hi ddd,</h1>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end hero --> <!-- start copy block -->\n<tr>\n<td align=\"center\">\n<table class=\"table-3\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start copy -->\n<tbody>\n<tr>\n<td class=\"td-1\">\n<p>Your account has been created. Below are your login details.</p>\n</td>\n</tr>\n<tr>\n<td class=\"td-1\">\n<table class=\"table-gray\" cellpadding=\"5\">\n<tbody>\n<tr>\n<td class=\"td-1\"><strong>Username</strong></td>\n<td class=\"td-2\">test@test12.com</td>\n</tr>\n<tr>\n<td class=\"td-1\"><strong>Password</strong></td>\n<td class=\"td-2\">sdeM9pY</td>\n</tr>\n</tbody>\n</table>\n<p>You will be asked to change your password the first time you log in.</p>\n</td>\n</tr>\n<tr>\n<td align=\"left\" bgcolor=\"#ffffff\">\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td class=\"td-button\">\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td align=\"center\"><a class=\"button\" href=\"http://growcrm.test\" target=\"_blank\" rel=\"noopener\">Login To You Account</a></td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<tr>\n<td class=\"signature\">\n<p><div align=\"left\">\r\n<p>Thanks,</p>\r\n<p><strong>Support Team</strong></p>\r\n</div></p>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end copy block --> <!-- start footer -->\n<tr>\n<td class=\"p-24\" align=\"center\">\n<table class=\"footer\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start permission -->\n<tbody>\n<tr>\n<td align=\"center\">\n<p><p>You received this email because you have an account with us. You can change your email preferences in your account dashboard.</p></p>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end footer --></tbody>\n</table>\n<!-- end body -->\n</body>\n\n</html>', 'general', NULL, NULL, NULL, NULL, NULL, NULL, 'new'),
(3, '2024-02-17 18:29:09', '2024-02-17 18:29:09', 'dontknow@hotmail.com', NULL, NULL, 'Welcome - Your Account Details', '<!DOCTYPE html>\n<html>\n\n<head>\n\n    <meta charset=\"utf-8\">\n    <meta http-equiv=\"x-ua-compatible\" content=\"ie=edge\">\n    <title>Email Confirmation</title>\n    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">\n    <style type=\"text/css\">\n        @media screen {\n            @font-face {\n                font-family: \'Source Sans Pro\';\n                font-style: normal;\n                font-weight: 400;\n                src: local(\'Source Sans Pro Regular\'), local(\'SourceSansPro-Regular\'), url(https://fonts.gstatic.com/s/sourcesanspro/v10/ODelI1aHBYDBqgeIAH2zlBM0YzuT7MdOe03otPbuUS0.woff) format(\'woff\');\n            }\n\n            @font-face {\n                font-family: \'Source Sans Pro\';\n                font-style: normal;\n                font-weight: 700;\n                src: local(\'Source Sans Pro Bold\'), local(\'SourceSansPro-Bold\'), url(https://fonts.gstatic.com/s/sourcesanspro/v10/toadOcfmlt9b38dHJxOBGFkQc6VGVFSmCnC_l7QZG60.woff) format(\'woff\');\n            }\n        }\n\n        body,\n        table,\n        td,\n        a {\n            -ms-text-size-adjust: 100%;\n            /* 1 */\n            -webkit-text-size-adjust: 100%;\n            /* 2 */\n        }\n\n        img {\n            -ms-interpolation-mode: bicubic;\n        }\n\n        a[x-apple-data-detectors] {\n            font-family: inherit !important;\n            font-size: inherit !important;\n            font-weight: inherit !important;\n            line-height: inherit !important;\n            color: inherit !important;\n            text-decoration: none !important;\n        }\n\n        div[style*=\"margin: 16px 0;\"] {\n            margin: 0 !important;\n        }\n\n        body {\n            width: 100% !important;\n            height: 100% !important;\n            padding: 0 !important;\n            margin: 0 !important;\n            padding: 24px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 16px;\n            background-color: #f9fafc;\n            color: #60676d;\n        }\n\n        table {\n            border-collapse: collapse !important;\n        }\n\n        a {\n            color: #1a82e2;\n        }\n\n        img {\n            height: auto;\n            line-height: 100%;\n            text-decoration: none;\n            border: 0;\n            outline: none;\n        }\n\n        .table-1 {\n            max-width: 600px;\n        }\n\n        .table-1 td {\n            padding: 36px 24px 40px;\n            text-align: center;\n        }\n\n        .table-1 h1 {\n            margin: 0;\n            font-size: 32px;\n            font-weight: 600;\n            letter-spacing: -1px;\n            line-height: 48px;\n        }\n\n        .table-2 {\n            max-width: 600px;\n        }\n\n        .table-2 td {\n            padding: 36px 24px 0;\n            border-top: 3px solid #d4dadf;\n            background-color: #ffffff;\n        }\n\n        .table-2 h1 {\n            margin: 0;\n            font-size: 20px;\n            font-weight: 600;\n            letter-spacing: -1px;\n            line-height: 48px;\n        }\n\n        .table-3 {\n            max-width: 600px;\n        }\n\n        .table-2 td {\n\n            background-color: #ffffff;\n        }\n\n        .td-1 {\n            padding: 24px;\n            font-size: 16px;\n            line-height: 24px;\n            background-color: #ffffff;\n            text-align: left;\n            padding-bottom: 10px;\n            padding-top: 0px;\n        }\n\n        .table-gray {\n            width: 100%;\n        }\n\n        .table-gray tr {\n            height: 24px;\n        }\n\n        .table-gray .td-1 {\n            background-color: #f1f3f7;\n            width: 30%;\n            border: solid 1px #e7e9ec;\n            padding-top: 5px;\n            padding-bottom: 5px;\n        }\n\n        .table-gray .td-2 {\n            background-color: #f1f3f7;\n            width: 70%;\n            border: solid 1px #e7e9ec;\n        }\n\n        .button, .button:active, .button:visited {\n            display: inline-block;\n            padding: 16px 36px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 16px;\n            color: #ffffff;\n            text-decoration: none;\n            border-radius: 6px;\n            background-color: #1a82e2;\n            border-radius: 6px;\n        }\n\n        .signature {\n            padding: 24px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 16px;\n            line-height: 24px;\n            border-bottom: 3px solid #d4dadf;\n            background-color: #ffffff;\n        }\n\n        .footer {\n            max-width: 600px;\n        }\n\n        .footer td {\n            padding: 12px 24px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 14px;\n            line-height: 20px;\n            color: #666;\n        }\n\n        .td-button {\n            padding: 12px;\n            background-color: #ffffff;\n            text-align: center;\n        }\n\n        .p-24 {\n            padding: 24px;\n        }\n    </style>\n\n</head>\n\n<body>\n<!-- start body -->\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start hero -->\n<tbody>\n<tr>\n<td align=\"center\">\n<table class=\"table-1\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td align=\"left\">\n<h1>Welcome</h1>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end hero --> <!-- start hero -->\n<tr>\n<td align=\"center\">\n<table class=\"table-2\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td align=\"left\">\n<h1>Hi lamtans01,</h1>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end hero --> <!-- start copy block -->\n<tr>\n<td align=\"center\">\n<table class=\"table-3\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start copy -->\n<tbody>\n<tr>\n<td class=\"td-1\">\n<p>Your account has been created. Below are your login details.</p>\n</td>\n</tr>\n<tr>\n<td class=\"td-1\">\n<table class=\"table-gray\" cellpadding=\"5\">\n<tbody>\n<tr>\n<td class=\"td-1\"><strong>Username</strong></td>\n<td class=\"td-2\">dontknow@hotmail.com</td>\n</tr>\n<tr>\n<td class=\"td-1\"><strong>Password</strong></td>\n<td class=\"td-2\">AgqMIVwNv</td>\n</tr>\n</tbody>\n</table>\n<p>You will be asked to change your password the first time you log in.</p>\n</td>\n</tr>\n<tr>\n<td align=\"left\" bgcolor=\"#ffffff\">\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td class=\"td-button\">\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td align=\"center\"><a class=\"button\" href=\"https://lamtanssystems.com\" target=\"_blank\" rel=\"noopener\">Login To You Account</a></td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<tr>\n<td class=\"signature\">\n<p><div align=\"left\">\r\n<p>Thanks,</p>\r\n<p><strong>Support Team</strong></p>\r\n</div></p>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end copy block --> <!-- start footer -->\n<tr>\n<td class=\"p-24\" align=\"center\">\n<table class=\"footer\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start permission -->\n<tbody>\n<tr>\n<td align=\"center\">\n<p><p>You received this email because you have an account with us. You can change your email preferences in your account dashboard.</p></p>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end footer --></tbody>\n</table>\n<!-- end body -->\n</body>\n\n</html>', 'general', NULL, NULL, NULL, NULL, NULL, NULL, 'new'),
(4, '2024-02-17 20:01:48', '2024-02-17 20:01:48', 'dontknow@hotmail.com', NULL, NULL, 'New Lead Assignment', '<!DOCTYPE html>\n<html>\n\n<head>\n\n    <meta charset=\"utf-8\">\n    <meta http-equiv=\"x-ua-compatible\" content=\"ie=edge\">\n    <title>Email Confirmation</title>\n    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">\n    <style type=\"text/css\">\n        @media screen {\n            @font-face {\n                font-family: \'Source Sans Pro\';\n                font-style: normal;\n                font-weight: 400;\n                src: local(\'Source Sans Pro Regular\'), local(\'SourceSansPro-Regular\'), url(https://fonts.gstatic.com/s/sourcesanspro/v10/ODelI1aHBYDBqgeIAH2zlBM0YzuT7MdOe03otPbuUS0.woff) format(\'woff\');\n            }\n\n            @font-face {\n                font-family: \'Source Sans Pro\';\n                font-style: normal;\n                font-weight: 700;\n                src: local(\'Source Sans Pro Bold\'), local(\'SourceSansPro-Bold\'), url(https://fonts.gstatic.com/s/sourcesanspro/v10/toadOcfmlt9b38dHJxOBGFkQc6VGVFSmCnC_l7QZG60.woff) format(\'woff\');\n            }\n        }\n\n        body,\n        table,\n        td,\n        a {\n            -ms-text-size-adjust: 100%;\n            /* 1 */\n            -webkit-text-size-adjust: 100%;\n            /* 2 */\n        }\n\n        img {\n            -ms-interpolation-mode: bicubic;\n        }\n\n        a[x-apple-data-detectors] {\n            font-family: inherit !important;\n            font-size: inherit !important;\n            font-weight: inherit !important;\n            line-height: inherit !important;\n            color: inherit !important;\n            text-decoration: none !important;\n        }\n\n        div[style*=\"margin: 16px 0;\"] {\n            margin: 0 !important;\n        }\n\n        body {\n            width: 100% !important;\n            height: 100% !important;\n            padding: 0 !important;\n            margin: 0 !important;\n            padding: 24px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 16px;\n            background-color: #f9fafc;\n            color: #60676d;\n        }\n\n        table {\n            border-collapse: collapse !important;\n        }\n\n        a {\n            color: #1a82e2;\n        }\n\n        img {\n            height: auto;\n            line-height: 100%;\n            text-decoration: none;\n            border: 0;\n            outline: none;\n        }\n\n        .table-1 {\n            max-width: 600px;\n        }\n\n        .table-1 td {\n            padding: 36px 24px 40px;\n            text-align: center;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-1 h1 {\n            margin: 0;\n            font-size: 32px;\n            font-weight: 600;\n            letter-spacing: -1px;\n            line-height: 48px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-2 {\n            max-width: 600px;\n        }\n\n        .table-2 td {\n            padding: 36px 24px 0;\n            border-top: 3px solid #d4dadf;\n            background-color: #ffffff;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-2 h1 {\n            margin: 0;\n            font-size: 20px;\n            font-weight: 600;\n            letter-spacing: -1px;\n            line-height: 48px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-3 {\n            max-width: 600px;\n        }\n\n        .table-2 td {\n\n            background-color: #ffffff;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .td-1 {\n            padding: 24px;\n            font-size: 16px;\n            line-height: 24px;\n            background-color: #ffffff;\n            text-align: left;\n            padding-bottom: 10px;\n            padding-top: 0px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-gray {\n            width: 100%;\n        }\n\n        .table-gray tr {\n            height: 24px;\n        }\n\n        .table-gray .td-1 {\n            background-color: #f1f3f7;\n            width: 30%;\n            border: solid 1px #e7e9ec;\n            padding-top: 5px;\n            padding-bottom: 5px;\n            font-size:16px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-gray .td-2 {\n            background-color: #f1f3f7;\n            width: 70%;\n            border: solid 1px #e7e9ec;\n            font-size:16px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .button, .button:active, .button:visited {\n            display: inline-block;\n            padding: 16px 36px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 16px;\n            color: #ffffff;\n            text-decoration: none;\n            border-radius: 6px;\n            background-color: #1a82e2;\n            border-radius: 6px;\n        }\n\n        .signature {\n            padding: 24px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 16px;\n            line-height: 24px;\n            border-bottom: 3px solid #d4dadf;\n            background-color: #ffffff;\n        }\n\n        .footer {\n            max-width: 600px;\n        }\n\n        .footer td {\n            padding: 12px 24px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 14px;\n            line-height: 20px;\n            color: #666;\n        }\n\n        .td-button {\n            padding: 12px;\n            background-color: #ffffff;\n            text-align: center;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .p-24 {\n            padding: 24px;\n        }\n    </style>\n\n</head>\n\n<body>\n<!-- start body -->\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start hero -->\n<tbody>\n<tr>\n<td align=\"center\">\n<table class=\"table-1\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td align=\"left\">\n<h1>Lead Assignment</h1>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end hero --> <!-- start hero -->\n<tr>\n<td align=\"center\">\n<table class=\"table-2\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td align=\"left\">\n<h1>Hi lamtans01,</h1>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end hero --> <!-- start copy block -->\n<tr>\n<td align=\"center\">\n<table class=\"table-3\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start copy -->\n<tbody>\n<tr>\n<td class=\"td-1\">\n<p>You have just been assigned to a lead.</p>\n</td>\n</tr>\n<tr>\n<td class=\"td-1\">\n<table class=\"table-gray\" cellpadding=\"5\">\n<tbody>\n<tr>\n<td class=\"td-1\"><strong>Lead Name</strong></td>\n<td class=\"td-2\">ddd fdsds</td>\n</tr>\n<tr>\n<td class=\"td-1\"><strong>Lead Title</strong></td>\n<td class=\"td-2\">jjj</td>\n</tr>\n</tbody>\n</table>\n<p>You can manage your project via the dashboard.</p>\n</td>\n</tr>\n<tr>\n<td align=\"left\" bgcolor=\"#ffffff\">\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td class=\"td-button\">\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td align=\"center\"><a class=\"button\" href=\"https://lamtanssystems.com/leads\" target=\"_blank\" rel=\"noopener\">Manage Lead</a></td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<tr>\n<td class=\"signature\">\n<p><div align=\"left\">\r\n<p>Thanks,</p>\r\n<p><strong>Support Team</strong></p>\r\n</div></p>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end copy block --> <!-- start footer -->\n<tr>\n<td class=\"p-24\" align=\"center\">\n<table class=\"footer\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start permission -->\n<tbody>\n<tr>\n<td align=\"center\">\n<p><p>You received this email because you have an account with us. You can change your email preferences in your account dashboard.</p></p>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end footer --></tbody>\n</table>\n<!-- end body -->\n</body>\n\n</html>', 'general', NULL, 'lead', 1, NULL, NULL, NULL, 'new'),
(5, '2024-02-19 21:25:38', '2024-02-19 21:25:38', 'dontknow@hotmail.com', NULL, NULL, 'New Lead Assignment', '<!DOCTYPE html>\n<html>\n\n<head>\n\n    <meta charset=\"utf-8\">\n    <meta http-equiv=\"x-ua-compatible\" content=\"ie=edge\">\n    <title>Email Confirmation</title>\n    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">\n    <style type=\"text/css\">\n        @media screen {\n            @font-face {\n                font-family: \'Source Sans Pro\';\n                font-style: normal;\n                font-weight: 400;\n                src: local(\'Source Sans Pro Regular\'), local(\'SourceSansPro-Regular\'), url(https://fonts.gstatic.com/s/sourcesanspro/v10/ODelI1aHBYDBqgeIAH2zlBM0YzuT7MdOe03otPbuUS0.woff) format(\'woff\');\n            }\n\n            @font-face {\n                font-family: \'Source Sans Pro\';\n                font-style: normal;\n                font-weight: 700;\n                src: local(\'Source Sans Pro Bold\'), local(\'SourceSansPro-Bold\'), url(https://fonts.gstatic.com/s/sourcesanspro/v10/toadOcfmlt9b38dHJxOBGFkQc6VGVFSmCnC_l7QZG60.woff) format(\'woff\');\n            }\n        }\n\n        body,\n        table,\n        td,\n        a {\n            -ms-text-size-adjust: 100%;\n            /* 1 */\n            -webkit-text-size-adjust: 100%;\n            /* 2 */\n        }\n\n        img {\n            -ms-interpolation-mode: bicubic;\n        }\n\n        a[x-apple-data-detectors] {\n            font-family: inherit !important;\n            font-size: inherit !important;\n            font-weight: inherit !important;\n            line-height: inherit !important;\n            color: inherit !important;\n            text-decoration: none !important;\n        }\n\n        div[style*=\"margin: 16px 0;\"] {\n            margin: 0 !important;\n        }\n\n        body {\n            width: 100% !important;\n            height: 100% !important;\n            padding: 0 !important;\n            margin: 0 !important;\n            padding: 24px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 16px;\n            background-color: #f9fafc;\n            color: #60676d;\n        }\n\n        table {\n            border-collapse: collapse !important;\n        }\n\n        a {\n            color: #1a82e2;\n        }\n\n        img {\n            height: auto;\n            line-height: 100%;\n            text-decoration: none;\n            border: 0;\n            outline: none;\n        }\n\n        .table-1 {\n            max-width: 600px;\n        }\n\n        .table-1 td {\n            padding: 36px 24px 40px;\n            text-align: center;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-1 h1 {\n            margin: 0;\n            font-size: 32px;\n            font-weight: 600;\n            letter-spacing: -1px;\n            line-height: 48px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-2 {\n            max-width: 600px;\n        }\n\n        .table-2 td {\n            padding: 36px 24px 0;\n            border-top: 3px solid #d4dadf;\n            background-color: #ffffff;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-2 h1 {\n            margin: 0;\n            font-size: 20px;\n            font-weight: 600;\n            letter-spacing: -1px;\n            line-height: 48px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-3 {\n            max-width: 600px;\n        }\n\n        .table-2 td {\n\n            background-color: #ffffff;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .td-1 {\n            padding: 24px;\n            font-size: 16px;\n            line-height: 24px;\n            background-color: #ffffff;\n            text-align: left;\n            padding-bottom: 10px;\n            padding-top: 0px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-gray {\n            width: 100%;\n        }\n\n        .table-gray tr {\n            height: 24px;\n        }\n\n        .table-gray .td-1 {\n            background-color: #f1f3f7;\n            width: 30%;\n            border: solid 1px #e7e9ec;\n            padding-top: 5px;\n            padding-bottom: 5px;\n            font-size:16px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-gray .td-2 {\n            background-color: #f1f3f7;\n            width: 70%;\n            border: solid 1px #e7e9ec;\n            font-size:16px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .button, .button:active, .button:visited {\n            display: inline-block;\n            padding: 16px 36px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 16px;\n            color: #ffffff;\n            text-decoration: none;\n            border-radius: 6px;\n            background-color: #1a82e2;\n            border-radius: 6px;\n        }\n\n        .signature {\n            padding: 24px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 16px;\n            line-height: 24px;\n            border-bottom: 3px solid #d4dadf;\n            background-color: #ffffff;\n        }\n\n        .footer {\n            max-width: 600px;\n        }\n\n        .footer td {\n            padding: 12px 24px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 14px;\n            line-height: 20px;\n            color: #666;\n        }\n\n        .td-button {\n            padding: 12px;\n            background-color: #ffffff;\n            text-align: center;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .p-24 {\n            padding: 24px;\n        }\n    </style>\n\n</head>\n\n<body>\n<!-- start body -->\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start hero -->\n<tbody>\n<tr>\n<td align=\"center\">\n<table class=\"table-1\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td align=\"left\">\n<h1>Lead Assignment</h1>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end hero --> <!-- start hero -->\n<tr>\n<td align=\"center\">\n<table class=\"table-2\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td align=\"left\">\n<h1>Hi lamtans01,</h1>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end hero --> <!-- start copy block -->\n<tr>\n<td align=\"center\">\n<table class=\"table-3\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start copy -->\n<tbody>\n<tr>\n<td class=\"td-1\">\n<p>You have just been assigned to a lead.</p>\n</td>\n</tr>\n<tr>\n<td class=\"td-1\">\n<table class=\"table-gray\" cellpadding=\"5\">\n<tbody>\n<tr>\n<td class=\"td-1\"><strong>Lead Name</strong></td>\n<td class=\"td-2\">Testing FN Testing LN</td>\n</tr>\n<tr>\n<td class=\"td-1\"><strong>Lead Title</strong></td>\n<td class=\"td-2\">Testing Lead Title</td>\n</tr>\n</tbody>\n</table>\n<p>You can manage your project via the dashboard.</p>\n</td>\n</tr>\n<tr>\n<td align=\"left\" bgcolor=\"#ffffff\">\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td class=\"td-button\">\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td align=\"center\"><a class=\"button\" href=\"https://lamtanssystems.com/leads\" target=\"_blank\" rel=\"noopener\">Manage Lead</a></td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<tr>\n<td class=\"signature\">\n<p><div align=\"left\">\r\n<p>Thanks,</p>\r\n<p><strong>Support Team</strong></p>\r\n</div></p>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end copy block --> <!-- start footer -->\n<tr>\n<td class=\"p-24\" align=\"center\">\n<table class=\"footer\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start permission -->\n<tbody>\n<tr>\n<td align=\"center\">\n<p><p>You received this email because you have an account with us. You can change your email preferences in your account dashboard.</p></p>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end footer --></tbody>\n</table>\n<!-- end body -->\n</body>\n\n</html>', 'general', NULL, 'lead', 6, NULL, NULL, NULL, 'new');
INSERT INTO `email_queue` (`emailqueue_id`, `emailqueue_created`, `emailqueue_updated`, `emailqueue_to`, `emailqueue_from_email`, `emailqueue_from_name`, `emailqueue_subject`, `emailqueue_message`, `emailqueue_type`, `emailqueue_attachments`, `emailqueue_resourcetype`, `emailqueue_resourceid`, `emailqueue_pdf_resource_type`, `emailqueue_pdf_resource_id`, `emailqueue_started_at`, `emailqueue_status`) VALUES
(6, '2024-02-20 18:55:57', '2024-02-20 18:55:57', 'dontknow@hotmail.com', NULL, NULL, 'Lead Status Has Changed', '<!DOCTYPE html>\n<html>\n\n<head>\n\n    <meta charset=\"utf-8\">\n    <meta http-equiv=\"x-ua-compatible\" content=\"ie=edge\">\n    <title>Email Confirmation</title>\n    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">\n    <style type=\"text/css\">\n        @media screen {\n            @font-face {\n                font-family: \'Source Sans Pro\';\n                font-style: normal;\n                font-weight: 400;\n                src: local(\'Source Sans Pro Regular\'), local(\'SourceSansPro-Regular\'), url(https://fonts.gstatic.com/s/sourcesanspro/v10/ODelI1aHBYDBqgeIAH2zlBM0YzuT7MdOe03otPbuUS0.woff) format(\'woff\');\n            }\n\n            @font-face {\n                font-family: \'Source Sans Pro\';\n                font-style: normal;\n                font-weight: 700;\n                src: local(\'Source Sans Pro Bold\'), local(\'SourceSansPro-Bold\'), url(https://fonts.gstatic.com/s/sourcesanspro/v10/toadOcfmlt9b38dHJxOBGFkQc6VGVFSmCnC_l7QZG60.woff) format(\'woff\');\n            }\n        }\n\n        body,\n        table,\n        td,\n        a {\n            -ms-text-size-adjust: 100%;\n            /* 1 */\n            -webkit-text-size-adjust: 100%;\n            /* 2 */\n        }\n\n        img {\n            -ms-interpolation-mode: bicubic;\n        }\n\n        a[x-apple-data-detectors] {\n            font-family: inherit !important;\n            font-size: inherit !important;\n            font-weight: inherit !important;\n            line-height: inherit !important;\n            color: inherit !important;\n            text-decoration: none !important;\n        }\n\n        div[style*=\"margin: 16px 0;\"] {\n            margin: 0 !important;\n        }\n\n        body {\n            width: 100% !important;\n            height: 100% !important;\n            padding: 0 !important;\n            margin: 0 !important;\n            padding: 24px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 16px;\n            background-color: #f9fafc;\n            color: #60676d;\n        }\n\n        table {\n            border-collapse: collapse !important;\n        }\n\n        a {\n            color: #1a82e2;\n        }\n\n        img {\n            height: auto;\n            line-height: 100%;\n            text-decoration: none;\n            border: 0;\n            outline: none;\n        }\n\n        .table-1 {\n            max-width: 600px;\n        }\n\n        .table-1 td {\n            padding: 36px 24px 40px;\n            text-align: center;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-1 h1 {\n            margin: 0;\n            font-size: 32px;\n            font-weight: 600;\n            letter-spacing: -1px;\n            line-height: 48px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-2 {\n            max-width: 600px;\n        }\n\n        .table-2 td {\n            padding: 36px 24px 0;\n            border-top: 3px solid #d4dadf;\n            background-color: #ffffff;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-2 h1 {\n            margin: 0;\n            font-size: 20px;\n            font-weight: 600;\n            letter-spacing: -1px;\n            line-height: 48px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-3 {\n            max-width: 600px;\n        }\n\n        .table-2 td {\n\n            background-color: #ffffff;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .td-1 {\n            padding: 24px;\n            font-size: 16px;\n            line-height: 24px;\n            background-color: #ffffff;\n            text-align: left;\n            padding-bottom: 10px;\n            padding-top: 0px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-gray {\n            width: 100%;\n        }\n\n        .table-gray tr {\n            height: 24px;\n        }\n\n        .table-gray .td-1 {\n            background-color: #f1f3f7;\n            width: 30%;\n            border: solid 1px #e7e9ec;\n            padding-top: 5px;\n            padding-bottom: 5px;\n            font-size:16px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-gray .td-2 {\n            background-color: #f1f3f7;\n            width: 70%;\n            border: solid 1px #e7e9ec;\n            font-size:16px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .button, .button:active, .button:visited {\n            display: inline-block;\n            padding: 16px 36px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 16px;\n            color: #ffffff;\n            text-decoration: none;\n            border-radius: 6px;\n            background-color: #1a82e2;\n            border-radius: 6px;\n        }\n\n        .signature {\n            padding: 24px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 16px;\n            line-height: 24px;\n            border-bottom: 3px solid #d4dadf;\n            background-color: #ffffff;\n        }\n\n        .footer {\n            max-width: 600px;\n        }\n\n        .footer td {\n            padding: 12px 24px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 14px;\n            line-height: 20px;\n            color: #666;\n        }\n\n        .td-button {\n            padding: 12px;\n            background-color: #ffffff;\n            text-align: center;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .p-24 {\n            padding: 24px;\n        }\n    </style>\n\n</head>\n\n<body>\n<!-- start body -->\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start hero -->\n<tbody>\n<tr>\n<td align=\"center\">\n<table class=\"table-1\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td align=\"left\">\n<h1>Lead Status Update</h1>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end hero --> <!-- start hero -->\n<tr>\n<td align=\"center\">\n<table class=\"table-2\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td align=\"left\">\n<h1>Hi lamtans01,</h1>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end hero --> <!-- start copy block -->\n<tr>\n<td align=\"center\">\n<table class=\"table-3\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start copy -->\n<tbody>\n<tr>\n<td class=\"td-1\">\n<p>The status of this lead has just been updated. The new status is shown below.</p>\n</td>\n</tr>\n<tr>\n<td class=\"td-1\">\n<table class=\"table-gray\" cellpadding=\"5\">\n<tbody>\n<tr>\n<td class=\"td-1\"><strong>Lead ID</strong></td>\n<td class=\"td-2\">6</td>\n</tr>\n<tr>\n<td class=\"td-1\"><strong>Lead Title</strong></td>\n<td class=\"td-2\">Testing Lead Title</td>\n</tr>\n<tr>\n<td class=\"td-1\"><strong>Lead Name</strong></td>\n<td class=\"td-2\">Testing FN Testing LN</td>\n</tr>\n<tr>\n<td class=\"td-1\"><strong>Lead Status</strong></td>\n<td class=\"td-2\">Voice Mail</td>\n</tr>\n</tbody>\n</table>\n<p>You can manage your lead via the dashboard.</p>\n</td>\n</tr>\n<tr>\n<td align=\"left\" bgcolor=\"#ffffff\">\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td class=\"td-button\">\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td align=\"center\"><a class=\"button\" href=\"https://lamtanssystems.com/leads\" target=\"_blank\" rel=\"noopener\">Manage Lead</a></td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<tr>\n<td class=\"signature\">\n<p><div align=\"left\">\r\n<p>Thanks,</p>\r\n<p><strong>Support Team</strong></p>\r\n</div></p>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end copy block --> <!-- start footer -->\n<tr>\n<td class=\"p-24\" align=\"center\">\n<table class=\"footer\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start permission -->\n<tbody>\n<tr>\n<td align=\"center\">\n<p><p>You received this email because you have an account with us. You can change your email preferences in your account dashboard.</p></p>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end footer --></tbody>\n</table>\n<!-- end body -->\n</body>\n\n</html>', 'general', NULL, 'lead', 6, NULL, NULL, NULL, 'new'),
(7, '2024-02-20 18:57:54', '2024-02-20 18:57:54', 'dontknow@hotmail.com', NULL, NULL, 'Lead Status Has Changed', '<!DOCTYPE html>\n<html>\n\n<head>\n\n    <meta charset=\"utf-8\">\n    <meta http-equiv=\"x-ua-compatible\" content=\"ie=edge\">\n    <title>Email Confirmation</title>\n    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">\n    <style type=\"text/css\">\n        @media screen {\n            @font-face {\n                font-family: \'Source Sans Pro\';\n                font-style: normal;\n                font-weight: 400;\n                src: local(\'Source Sans Pro Regular\'), local(\'SourceSansPro-Regular\'), url(https://fonts.gstatic.com/s/sourcesanspro/v10/ODelI1aHBYDBqgeIAH2zlBM0YzuT7MdOe03otPbuUS0.woff) format(\'woff\');\n            }\n\n            @font-face {\n                font-family: \'Source Sans Pro\';\n                font-style: normal;\n                font-weight: 700;\n                src: local(\'Source Sans Pro Bold\'), local(\'SourceSansPro-Bold\'), url(https://fonts.gstatic.com/s/sourcesanspro/v10/toadOcfmlt9b38dHJxOBGFkQc6VGVFSmCnC_l7QZG60.woff) format(\'woff\');\n            }\n        }\n\n        body,\n        table,\n        td,\n        a {\n            -ms-text-size-adjust: 100%;\n            /* 1 */\n            -webkit-text-size-adjust: 100%;\n            /* 2 */\n        }\n\n        img {\n            -ms-interpolation-mode: bicubic;\n        }\n\n        a[x-apple-data-detectors] {\n            font-family: inherit !important;\n            font-size: inherit !important;\n            font-weight: inherit !important;\n            line-height: inherit !important;\n            color: inherit !important;\n            text-decoration: none !important;\n        }\n\n        div[style*=\"margin: 16px 0;\"] {\n            margin: 0 !important;\n        }\n\n        body {\n            width: 100% !important;\n            height: 100% !important;\n            padding: 0 !important;\n            margin: 0 !important;\n            padding: 24px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 16px;\n            background-color: #f9fafc;\n            color: #60676d;\n        }\n\n        table {\n            border-collapse: collapse !important;\n        }\n\n        a {\n            color: #1a82e2;\n        }\n\n        img {\n            height: auto;\n            line-height: 100%;\n            text-decoration: none;\n            border: 0;\n            outline: none;\n        }\n\n        .table-1 {\n            max-width: 600px;\n        }\n\n        .table-1 td {\n            padding: 36px 24px 40px;\n            text-align: center;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-1 h1 {\n            margin: 0;\n            font-size: 32px;\n            font-weight: 600;\n            letter-spacing: -1px;\n            line-height: 48px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-2 {\n            max-width: 600px;\n        }\n\n        .table-2 td {\n            padding: 36px 24px 0;\n            border-top: 3px solid #d4dadf;\n            background-color: #ffffff;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-2 h1 {\n            margin: 0;\n            font-size: 20px;\n            font-weight: 600;\n            letter-spacing: -1px;\n            line-height: 48px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-3 {\n            max-width: 600px;\n        }\n\n        .table-2 td {\n\n            background-color: #ffffff;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .td-1 {\n            padding: 24px;\n            font-size: 16px;\n            line-height: 24px;\n            background-color: #ffffff;\n            text-align: left;\n            padding-bottom: 10px;\n            padding-top: 0px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-gray {\n            width: 100%;\n        }\n\n        .table-gray tr {\n            height: 24px;\n        }\n\n        .table-gray .td-1 {\n            background-color: #f1f3f7;\n            width: 30%;\n            border: solid 1px #e7e9ec;\n            padding-top: 5px;\n            padding-bottom: 5px;\n            font-size:16px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-gray .td-2 {\n            background-color: #f1f3f7;\n            width: 70%;\n            border: solid 1px #e7e9ec;\n            font-size:16px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .button, .button:active, .button:visited {\n            display: inline-block;\n            padding: 16px 36px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 16px;\n            color: #ffffff;\n            text-decoration: none;\n            border-radius: 6px;\n            background-color: #1a82e2;\n            border-radius: 6px;\n        }\n\n        .signature {\n            padding: 24px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 16px;\n            line-height: 24px;\n            border-bottom: 3px solid #d4dadf;\n            background-color: #ffffff;\n        }\n\n        .footer {\n            max-width: 600px;\n        }\n\n        .footer td {\n            padding: 12px 24px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 14px;\n            line-height: 20px;\n            color: #666;\n        }\n\n        .td-button {\n            padding: 12px;\n            background-color: #ffffff;\n            text-align: center;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .p-24 {\n            padding: 24px;\n        }\n    </style>\n\n</head>\n\n<body>\n<!-- start body -->\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start hero -->\n<tbody>\n<tr>\n<td align=\"center\">\n<table class=\"table-1\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td align=\"left\">\n<h1>Lead Status Update</h1>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end hero --> <!-- start hero -->\n<tr>\n<td align=\"center\">\n<table class=\"table-2\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td align=\"left\">\n<h1>Hi lamtans01,</h1>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end hero --> <!-- start copy block -->\n<tr>\n<td align=\"center\">\n<table class=\"table-3\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start copy -->\n<tbody>\n<tr>\n<td class=\"td-1\">\n<p>The status of this lead has just been updated. The new status is shown below.</p>\n</td>\n</tr>\n<tr>\n<td class=\"td-1\">\n<table class=\"table-gray\" cellpadding=\"5\">\n<tbody>\n<tr>\n<td class=\"td-1\"><strong>Lead ID</strong></td>\n<td class=\"td-2\">1</td>\n</tr>\n<tr>\n<td class=\"td-1\"><strong>Lead Title</strong></td>\n<td class=\"td-2\">jjj</td>\n</tr>\n<tr>\n<td class=\"td-1\"><strong>Lead Name</strong></td>\n<td class=\"td-2\">ddd fdsds</td>\n</tr>\n<tr>\n<td class=\"td-1\"><strong>Lead Status</strong></td>\n<td class=\"td-2\">Follow up</td>\n</tr>\n</tbody>\n</table>\n<p>You can manage your lead via the dashboard.</p>\n</td>\n</tr>\n<tr>\n<td align=\"left\" bgcolor=\"#ffffff\">\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td class=\"td-button\">\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td align=\"center\"><a class=\"button\" href=\"https://lamtanssystems.com/leads\" target=\"_blank\" rel=\"noopener\">Manage Lead</a></td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<tr>\n<td class=\"signature\">\n<p><div align=\"left\">\r\n<p>Thanks,</p>\r\n<p><strong>Support Team</strong></p>\r\n</div></p>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end copy block --> <!-- start footer -->\n<tr>\n<td class=\"p-24\" align=\"center\">\n<table class=\"footer\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start permission -->\n<tbody>\n<tr>\n<td align=\"center\">\n<p><p>You received this email because you have an account with us. You can change your email preferences in your account dashboard.</p></p>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end footer --></tbody>\n</table>\n<!-- end body -->\n</body>\n\n</html>', 'general', NULL, 'lead', 1, NULL, NULL, NULL, 'new'),
(8, '2024-02-20 18:57:58', '2024-02-20 18:57:58', 'dontknow@hotmail.com', NULL, NULL, 'Lead Status Has Changed', '<!DOCTYPE html>\n<html>\n\n<head>\n\n    <meta charset=\"utf-8\">\n    <meta http-equiv=\"x-ua-compatible\" content=\"ie=edge\">\n    <title>Email Confirmation</title>\n    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">\n    <style type=\"text/css\">\n        @media screen {\n            @font-face {\n                font-family: \'Source Sans Pro\';\n                font-style: normal;\n                font-weight: 400;\n                src: local(\'Source Sans Pro Regular\'), local(\'SourceSansPro-Regular\'), url(https://fonts.gstatic.com/s/sourcesanspro/v10/ODelI1aHBYDBqgeIAH2zlBM0YzuT7MdOe03otPbuUS0.woff) format(\'woff\');\n            }\n\n            @font-face {\n                font-family: \'Source Sans Pro\';\n                font-style: normal;\n                font-weight: 700;\n                src: local(\'Source Sans Pro Bold\'), local(\'SourceSansPro-Bold\'), url(https://fonts.gstatic.com/s/sourcesanspro/v10/toadOcfmlt9b38dHJxOBGFkQc6VGVFSmCnC_l7QZG60.woff) format(\'woff\');\n            }\n        }\n\n        body,\n        table,\n        td,\n        a {\n            -ms-text-size-adjust: 100%;\n            /* 1 */\n            -webkit-text-size-adjust: 100%;\n            /* 2 */\n        }\n\n        img {\n            -ms-interpolation-mode: bicubic;\n        }\n\n        a[x-apple-data-detectors] {\n            font-family: inherit !important;\n            font-size: inherit !important;\n            font-weight: inherit !important;\n            line-height: inherit !important;\n            color: inherit !important;\n            text-decoration: none !important;\n        }\n\n        div[style*=\"margin: 16px 0;\"] {\n            margin: 0 !important;\n        }\n\n        body {\n            width: 100% !important;\n            height: 100% !important;\n            padding: 0 !important;\n            margin: 0 !important;\n            padding: 24px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 16px;\n            background-color: #f9fafc;\n            color: #60676d;\n        }\n\n        table {\n            border-collapse: collapse !important;\n        }\n\n        a {\n            color: #1a82e2;\n        }\n\n        img {\n            height: auto;\n            line-height: 100%;\n            text-decoration: none;\n            border: 0;\n            outline: none;\n        }\n\n        .table-1 {\n            max-width: 600px;\n        }\n\n        .table-1 td {\n            padding: 36px 24px 40px;\n            text-align: center;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-1 h1 {\n            margin: 0;\n            font-size: 32px;\n            font-weight: 600;\n            letter-spacing: -1px;\n            line-height: 48px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-2 {\n            max-width: 600px;\n        }\n\n        .table-2 td {\n            padding: 36px 24px 0;\n            border-top: 3px solid #d4dadf;\n            background-color: #ffffff;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-2 h1 {\n            margin: 0;\n            font-size: 20px;\n            font-weight: 600;\n            letter-spacing: -1px;\n            line-height: 48px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-3 {\n            max-width: 600px;\n        }\n\n        .table-2 td {\n\n            background-color: #ffffff;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .td-1 {\n            padding: 24px;\n            font-size: 16px;\n            line-height: 24px;\n            background-color: #ffffff;\n            text-align: left;\n            padding-bottom: 10px;\n            padding-top: 0px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-gray {\n            width: 100%;\n        }\n\n        .table-gray tr {\n            height: 24px;\n        }\n\n        .table-gray .td-1 {\n            background-color: #f1f3f7;\n            width: 30%;\n            border: solid 1px #e7e9ec;\n            padding-top: 5px;\n            padding-bottom: 5px;\n            font-size:16px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-gray .td-2 {\n            background-color: #f1f3f7;\n            width: 70%;\n            border: solid 1px #e7e9ec;\n            font-size:16px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .button, .button:active, .button:visited {\n            display: inline-block;\n            padding: 16px 36px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 16px;\n            color: #ffffff;\n            text-decoration: none;\n            border-radius: 6px;\n            background-color: #1a82e2;\n            border-radius: 6px;\n        }\n\n        .signature {\n            padding: 24px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 16px;\n            line-height: 24px;\n            border-bottom: 3px solid #d4dadf;\n            background-color: #ffffff;\n        }\n\n        .footer {\n            max-width: 600px;\n        }\n\n        .footer td {\n            padding: 12px 24px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 14px;\n            line-height: 20px;\n            color: #666;\n        }\n\n        .td-button {\n            padding: 12px;\n            background-color: #ffffff;\n            text-align: center;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .p-24 {\n            padding: 24px;\n        }\n    </style>\n\n</head>\n\n<body>\n<!-- start body -->\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start hero -->\n<tbody>\n<tr>\n<td align=\"center\">\n<table class=\"table-1\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td align=\"left\">\n<h1>Lead Status Update</h1>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end hero --> <!-- start hero -->\n<tr>\n<td align=\"center\">\n<table class=\"table-2\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td align=\"left\">\n<h1>Hi lamtans01,</h1>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end hero --> <!-- start copy block -->\n<tr>\n<td align=\"center\">\n<table class=\"table-3\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start copy -->\n<tbody>\n<tr>\n<td class=\"td-1\">\n<p>The status of this lead has just been updated. The new status is shown below.</p>\n</td>\n</tr>\n<tr>\n<td class=\"td-1\">\n<table class=\"table-gray\" cellpadding=\"5\">\n<tbody>\n<tr>\n<td class=\"td-1\"><strong>Lead ID</strong></td>\n<td class=\"td-2\">1</td>\n</tr>\n<tr>\n<td class=\"td-1\"><strong>Lead Title</strong></td>\n<td class=\"td-2\">jjj</td>\n</tr>\n<tr>\n<td class=\"td-1\"><strong>Lead Name</strong></td>\n<td class=\"td-2\">ddd fdsds</td>\n</tr>\n<tr>\n<td class=\"td-1\"><strong>Lead Status</strong></td>\n<td class=\"td-2\">Awaiting Photos</td>\n</tr>\n</tbody>\n</table>\n<p>You can manage your lead via the dashboard.</p>\n</td>\n</tr>\n<tr>\n<td align=\"left\" bgcolor=\"#ffffff\">\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td class=\"td-button\">\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td align=\"center\"><a class=\"button\" href=\"https://lamtanssystems.com/leads\" target=\"_blank\" rel=\"noopener\">Manage Lead</a></td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<tr>\n<td class=\"signature\">\n<p><div align=\"left\">\r\n<p>Thanks,</p>\r\n<p><strong>Support Team</strong></p>\r\n</div></p>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end copy block --> <!-- start footer -->\n<tr>\n<td class=\"p-24\" align=\"center\">\n<table class=\"footer\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start permission -->\n<tbody>\n<tr>\n<td align=\"center\">\n<p><p>You received this email because you have an account with us. You can change your email preferences in your account dashboard.</p></p>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end footer --></tbody>\n</table>\n<!-- end body -->\n</body>\n\n</html>', 'general', NULL, 'lead', 1, NULL, NULL, NULL, 'new'),
(9, '2024-02-20 18:58:02', '2024-02-20 18:58:02', 'dontknow@hotmail.com', NULL, NULL, 'Lead Status Has Changed', '<!DOCTYPE html>\n<html>\n\n<head>\n\n    <meta charset=\"utf-8\">\n    <meta http-equiv=\"x-ua-compatible\" content=\"ie=edge\">\n    <title>Email Confirmation</title>\n    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">\n    <style type=\"text/css\">\n        @media screen {\n            @font-face {\n                font-family: \'Source Sans Pro\';\n                font-style: normal;\n                font-weight: 400;\n                src: local(\'Source Sans Pro Regular\'), local(\'SourceSansPro-Regular\'), url(https://fonts.gstatic.com/s/sourcesanspro/v10/ODelI1aHBYDBqgeIAH2zlBM0YzuT7MdOe03otPbuUS0.woff) format(\'woff\');\n            }\n\n            @font-face {\n                font-family: \'Source Sans Pro\';\n                font-style: normal;\n                font-weight: 700;\n                src: local(\'Source Sans Pro Bold\'), local(\'SourceSansPro-Bold\'), url(https://fonts.gstatic.com/s/sourcesanspro/v10/toadOcfmlt9b38dHJxOBGFkQc6VGVFSmCnC_l7QZG60.woff) format(\'woff\');\n            }\n        }\n\n        body,\n        table,\n        td,\n        a {\n            -ms-text-size-adjust: 100%;\n            /* 1 */\n            -webkit-text-size-adjust: 100%;\n            /* 2 */\n        }\n\n        img {\n            -ms-interpolation-mode: bicubic;\n        }\n\n        a[x-apple-data-detectors] {\n            font-family: inherit !important;\n            font-size: inherit !important;\n            font-weight: inherit !important;\n            line-height: inherit !important;\n            color: inherit !important;\n            text-decoration: none !important;\n        }\n\n        div[style*=\"margin: 16px 0;\"] {\n            margin: 0 !important;\n        }\n\n        body {\n            width: 100% !important;\n            height: 100% !important;\n            padding: 0 !important;\n            margin: 0 !important;\n            padding: 24px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 16px;\n            background-color: #f9fafc;\n            color: #60676d;\n        }\n\n        table {\n            border-collapse: collapse !important;\n        }\n\n        a {\n            color: #1a82e2;\n        }\n\n        img {\n            height: auto;\n            line-height: 100%;\n            text-decoration: none;\n            border: 0;\n            outline: none;\n        }\n\n        .table-1 {\n            max-width: 600px;\n        }\n\n        .table-1 td {\n            padding: 36px 24px 40px;\n            text-align: center;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-1 h1 {\n            margin: 0;\n            font-size: 32px;\n            font-weight: 600;\n            letter-spacing: -1px;\n            line-height: 48px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-2 {\n            max-width: 600px;\n        }\n\n        .table-2 td {\n            padding: 36px 24px 0;\n            border-top: 3px solid #d4dadf;\n            background-color: #ffffff;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-2 h1 {\n            margin: 0;\n            font-size: 20px;\n            font-weight: 600;\n            letter-spacing: -1px;\n            line-height: 48px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-3 {\n            max-width: 600px;\n        }\n\n        .table-2 td {\n\n            background-color: #ffffff;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .td-1 {\n            padding: 24px;\n            font-size: 16px;\n            line-height: 24px;\n            background-color: #ffffff;\n            text-align: left;\n            padding-bottom: 10px;\n            padding-top: 0px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-gray {\n            width: 100%;\n        }\n\n        .table-gray tr {\n            height: 24px;\n        }\n\n        .table-gray .td-1 {\n            background-color: #f1f3f7;\n            width: 30%;\n            border: solid 1px #e7e9ec;\n            padding-top: 5px;\n            padding-bottom: 5px;\n            font-size:16px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-gray .td-2 {\n            background-color: #f1f3f7;\n            width: 70%;\n            border: solid 1px #e7e9ec;\n            font-size:16px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .button, .button:active, .button:visited {\n            display: inline-block;\n            padding: 16px 36px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 16px;\n            color: #ffffff;\n            text-decoration: none;\n            border-radius: 6px;\n            background-color: #1a82e2;\n            border-radius: 6px;\n        }\n\n        .signature {\n            padding: 24px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 16px;\n            line-height: 24px;\n            border-bottom: 3px solid #d4dadf;\n            background-color: #ffffff;\n        }\n\n        .footer {\n            max-width: 600px;\n        }\n\n        .footer td {\n            padding: 12px 24px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 14px;\n            line-height: 20px;\n            color: #666;\n        }\n\n        .td-button {\n            padding: 12px;\n            background-color: #ffffff;\n            text-align: center;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .p-24 {\n            padding: 24px;\n        }\n    </style>\n\n</head>\n\n<body>\n<!-- start body -->\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start hero -->\n<tbody>\n<tr>\n<td align=\"center\">\n<table class=\"table-1\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td align=\"left\">\n<h1>Lead Status Update</h1>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end hero --> <!-- start hero -->\n<tr>\n<td align=\"center\">\n<table class=\"table-2\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td align=\"left\">\n<h1>Hi lamtans01,</h1>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end hero --> <!-- start copy block -->\n<tr>\n<td align=\"center\">\n<table class=\"table-3\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start copy -->\n<tbody>\n<tr>\n<td class=\"td-1\">\n<p>The status of this lead has just been updated. The new status is shown below.</p>\n</td>\n</tr>\n<tr>\n<td class=\"td-1\">\n<table class=\"table-gray\" cellpadding=\"5\">\n<tbody>\n<tr>\n<td class=\"td-1\"><strong>Lead ID</strong></td>\n<td class=\"td-2\">1</td>\n</tr>\n<tr>\n<td class=\"td-1\"><strong>Lead Title</strong></td>\n<td class=\"td-2\">jjj</td>\n</tr>\n<tr>\n<td class=\"td-1\"><strong>Lead Name</strong></td>\n<td class=\"td-2\">ddd fdsds</td>\n</tr>\n<tr>\n<td class=\"td-1\"><strong>Lead Status</strong></td>\n<td class=\"td-2\">Voice Mail</td>\n</tr>\n</tbody>\n</table>\n<p>You can manage your lead via the dashboard.</p>\n</td>\n</tr>\n<tr>\n<td align=\"left\" bgcolor=\"#ffffff\">\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td class=\"td-button\">\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td align=\"center\"><a class=\"button\" href=\"https://lamtanssystems.com/leads\" target=\"_blank\" rel=\"noopener\">Manage Lead</a></td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<tr>\n<td class=\"signature\">\n<p><div align=\"left\">\r\n<p>Thanks,</p>\r\n<p><strong>Support Team</strong></p>\r\n</div></p>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end copy block --> <!-- start footer -->\n<tr>\n<td class=\"p-24\" align=\"center\">\n<table class=\"footer\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start permission -->\n<tbody>\n<tr>\n<td align=\"center\">\n<p><p>You received this email because you have an account with us. You can change your email preferences in your account dashboard.</p></p>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end footer --></tbody>\n</table>\n<!-- end body -->\n</body>\n\n</html>', 'general', NULL, 'lead', 1, NULL, NULL, NULL, 'new'),
(10, '2024-02-24 17:49:45', '2024-02-24 17:49:45', 'dontknow@hotmail.com', NULL, NULL, 'New Lead Assignment', '<!DOCTYPE html>\n<html>\n\n<head>\n\n    <meta charset=\"utf-8\">\n    <meta http-equiv=\"x-ua-compatible\" content=\"ie=edge\">\n    <title>Email Confirmation</title>\n    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">\n    <style type=\"text/css\">\n        @media screen {\n            @font-face {\n                font-family: \'Source Sans Pro\';\n                font-style: normal;\n                font-weight: 400;\n                src: local(\'Source Sans Pro Regular\'), local(\'SourceSansPro-Regular\'), url(https://fonts.gstatic.com/s/sourcesanspro/v10/ODelI1aHBYDBqgeIAH2zlBM0YzuT7MdOe03otPbuUS0.woff) format(\'woff\');\n            }\n\n            @font-face {\n                font-family: \'Source Sans Pro\';\n                font-style: normal;\n                font-weight: 700;\n                src: local(\'Source Sans Pro Bold\'), local(\'SourceSansPro-Bold\'), url(https://fonts.gstatic.com/s/sourcesanspro/v10/toadOcfmlt9b38dHJxOBGFkQc6VGVFSmCnC_l7QZG60.woff) format(\'woff\');\n            }\n        }\n\n        body,\n        table,\n        td,\n        a {\n            -ms-text-size-adjust: 100%;\n            /* 1 */\n            -webkit-text-size-adjust: 100%;\n            /* 2 */\n        }\n\n        img {\n            -ms-interpolation-mode: bicubic;\n        }\n\n        a[x-apple-data-detectors] {\n            font-family: inherit !important;\n            font-size: inherit !important;\n            font-weight: inherit !important;\n            line-height: inherit !important;\n            color: inherit !important;\n            text-decoration: none !important;\n        }\n\n        div[style*=\"margin: 16px 0;\"] {\n            margin: 0 !important;\n        }\n\n        body {\n            width: 100% !important;\n            height: 100% !important;\n            padding: 0 !important;\n            margin: 0 !important;\n            padding: 24px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 16px;\n            background-color: #f9fafc;\n            color: #60676d;\n        }\n\n        table {\n            border-collapse: collapse !important;\n        }\n\n        a {\n            color: #1a82e2;\n        }\n\n        img {\n            height: auto;\n            line-height: 100%;\n            text-decoration: none;\n            border: 0;\n            outline: none;\n        }\n\n        .table-1 {\n            max-width: 600px;\n        }\n\n        .table-1 td {\n            padding: 36px 24px 40px;\n            text-align: center;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-1 h1 {\n            margin: 0;\n            font-size: 32px;\n            font-weight: 600;\n            letter-spacing: -1px;\n            line-height: 48px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-2 {\n            max-width: 600px;\n        }\n\n        .table-2 td {\n            padding: 36px 24px 0;\n            border-top: 3px solid #d4dadf;\n            background-color: #ffffff;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-2 h1 {\n            margin: 0;\n            font-size: 20px;\n            font-weight: 600;\n            letter-spacing: -1px;\n            line-height: 48px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-3 {\n            max-width: 600px;\n        }\n\n        .table-2 td {\n\n            background-color: #ffffff;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .td-1 {\n            padding: 24px;\n            font-size: 16px;\n            line-height: 24px;\n            background-color: #ffffff;\n            text-align: left;\n            padding-bottom: 10px;\n            padding-top: 0px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-gray {\n            width: 100%;\n        }\n\n        .table-gray tr {\n            height: 24px;\n        }\n\n        .table-gray .td-1 {\n            background-color: #f1f3f7;\n            width: 30%;\n            border: solid 1px #e7e9ec;\n            padding-top: 5px;\n            padding-bottom: 5px;\n            font-size:16px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-gray .td-2 {\n            background-color: #f1f3f7;\n            width: 70%;\n            border: solid 1px #e7e9ec;\n            font-size:16px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .button, .button:active, .button:visited {\n            display: inline-block;\n            padding: 16px 36px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 16px;\n            color: #ffffff;\n            text-decoration: none;\n            border-radius: 6px;\n            background-color: #1a82e2;\n            border-radius: 6px;\n        }\n\n        .signature {\n            padding: 24px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 16px;\n            line-height: 24px;\n            border-bottom: 3px solid #d4dadf;\n            background-color: #ffffff;\n        }\n\n        .footer {\n            max-width: 600px;\n        }\n\n        .footer td {\n            padding: 12px 24px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 14px;\n            line-height: 20px;\n            color: #666;\n        }\n\n        .td-button {\n            padding: 12px;\n            background-color: #ffffff;\n            text-align: center;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .p-24 {\n            padding: 24px;\n        }\n    </style>\n\n</head>\n\n<body>\n<!-- start body -->\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start hero -->\n<tbody>\n<tr>\n<td align=\"center\">\n<table class=\"table-1\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td align=\"left\">\n<h1>Lead Assignment</h1>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end hero --> <!-- start hero -->\n<tr>\n<td align=\"center\">\n<table class=\"table-2\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td align=\"left\">\n<h1>Hi lamtans01,</h1>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end hero --> <!-- start copy block -->\n<tr>\n<td align=\"center\">\n<table class=\"table-3\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start copy -->\n<tbody>\n<tr>\n<td class=\"td-1\">\n<p>You have just been assigned to a lead.</p>\n</td>\n</tr>\n<tr>\n<td class=\"td-1\">\n<table class=\"table-gray\" cellpadding=\"5\">\n<tbody>\n<tr>\n<td class=\"td-1\"><strong>Lead Name</strong></td>\n<td class=\"td-2\">test test</td>\n</tr>\n<tr>\n<td class=\"td-1\"><strong>Lead Title</strong></td>\n<td class=\"td-2\">Lead</td>\n</tr>\n</tbody>\n</table>\n<p>You can manage your project via the dashboard.</p>\n</td>\n</tr>\n<tr>\n<td align=\"left\" bgcolor=\"#ffffff\">\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td class=\"td-button\">\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td align=\"center\"><a class=\"button\" href=\"https://lamtanssystems.com/leads\" target=\"_blank\" rel=\"noopener\">Manage Lead</a></td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<tr>\n<td class=\"signature\">\n<p><div align=\"left\">\r\n<p>Thanks,</p>\r\n<p><strong>Support Team</strong></p>\r\n</div></p>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end copy block --> <!-- start footer -->\n<tr>\n<td class=\"p-24\" align=\"center\">\n<table class=\"footer\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start permission -->\n<tbody>\n<tr>\n<td align=\"center\">\n<p><p>You received this email because you have an account with us. You can change your email preferences in your account dashboard.</p></p>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end footer --></tbody>\n</table>\n<!-- end body -->\n</body>\n\n</html>', 'general', NULL, 'lead', 7, NULL, NULL, NULL, 'new');

-- --------------------------------------------------------

--
-- Table structure for table `email_templates`
--

CREATE TABLE `email_templates` (
  `emailtemplate_module_unique_id` varchar(250) DEFAULT NULL,
  `emailtemplate_module_name` varchar(250) DEFAULT NULL,
  `emailtemplate_name` varchar(100) DEFAULT NULL,
  `emailtemplate_lang` varchar(250) DEFAULT NULL COMMENT 'to match to language',
  `emailtemplate_type` varchar(30) DEFAULT NULL COMMENT 'everyone|admin|client',
  `emailtemplate_category` varchar(30) DEFAULT NULL COMMENT 'modules|users|projects|tasks|leads|tickets|billing|estimates|other',
  `emailtemplate_subject` varchar(250) DEFAULT NULL,
  `emailtemplate_body` text DEFAULT NULL,
  `emailtemplate_variables` text DEFAULT NULL,
  `emailtemplate_created` datetime DEFAULT NULL,
  `emailtemplate_updated` datetime DEFAULT NULL,
  `emailtemplate_status` varchar(20) DEFAULT 'enabled' COMMENT 'enabled|disabled',
  `emailtemplate_language` varchar(50) DEFAULT NULL,
  `emailtemplate_real_template` varchar(50) DEFAULT 'yes' COMMENT 'yes|no',
  `emailtemplate_show_enabled` varchar(50) DEFAULT 'yes' COMMENT 'yes|no',
  `emailtemplate_id` int(11) NOT NULL COMMENT 'x'
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='[do not truncate]' ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `email_templates`
--

INSERT INTO `email_templates` (`emailtemplate_module_unique_id`, `emailtemplate_module_name`, `emailtemplate_name`, `emailtemplate_lang`, `emailtemplate_type`, `emailtemplate_category`, `emailtemplate_subject`, `emailtemplate_body`, `emailtemplate_variables`, `emailtemplate_created`, `emailtemplate_updated`, `emailtemplate_status`, `emailtemplate_language`, `emailtemplate_real_template`, `emailtemplate_show_enabled`, `emailtemplate_id`) VALUES
(NULL, NULL, 'New User Welcome', 'template_lang_new_user_welcome', 'everyone', 'users', 'Welcome - Your Account Details', '<!DOCTYPE html>\n<html>\n\n<head>\n\n    <meta charset=\"utf-8\">\n    <meta http-equiv=\"x-ua-compatible\" content=\"ie=edge\">\n    <title>Email Confirmation</title>\n    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">\n    <style type=\"text/css\">\n        @media screen {\n            @font-face {\n                font-family: \'Source Sans Pro\';\n                font-style: normal;\n                font-weight: 400;\n                src: local(\'Source Sans Pro Regular\'), local(\'SourceSansPro-Regular\'), url(https://fonts.gstatic.com/s/sourcesanspro/v10/ODelI1aHBYDBqgeIAH2zlBM0YzuT7MdOe03otPbuUS0.woff) format(\'woff\');\n            }\n\n            @font-face {\n                font-family: \'Source Sans Pro\';\n                font-style: normal;\n                font-weight: 700;\n                src: local(\'Source Sans Pro Bold\'), local(\'SourceSansPro-Bold\'), url(https://fonts.gstatic.com/s/sourcesanspro/v10/toadOcfmlt9b38dHJxOBGFkQc6VGVFSmCnC_l7QZG60.woff) format(\'woff\');\n            }\n        }\n\n        body,\n        table,\n        td,\n        a {\n            -ms-text-size-adjust: 100%;\n            /* 1 */\n            -webkit-text-size-adjust: 100%;\n            /* 2 */\n        }\n\n        img {\n            -ms-interpolation-mode: bicubic;\n        }\n\n        a[x-apple-data-detectors] {\n            font-family: inherit !important;\n            font-size: inherit !important;\n            font-weight: inherit !important;\n            line-height: inherit !important;\n            color: inherit !important;\n            text-decoration: none !important;\n        }\n\n        div[style*=\"margin: 16px 0;\"] {\n            margin: 0 !important;\n        }\n\n        body {\n            width: 100% !important;\n            height: 100% !important;\n            padding: 0 !important;\n            margin: 0 !important;\n            padding: 24px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 16px;\n            background-color: #f9fafc;\n            color: #60676d;\n        }\n\n        table {\n            border-collapse: collapse !important;\n        }\n\n        a {\n            color: #1a82e2;\n        }\n\n        img {\n            height: auto;\n            line-height: 100%;\n            text-decoration: none;\n            border: 0;\n            outline: none;\n        }\n\n        .table-1 {\n            max-width: 600px;\n        }\n\n        .table-1 td {\n            padding: 36px 24px 40px;\n            text-align: center;\n        }\n\n        .table-1 h1 {\n            margin: 0;\n            font-size: 32px;\n            font-weight: 600;\n            letter-spacing: -1px;\n            line-height: 48px;\n        }\n\n        .table-2 {\n            max-width: 600px;\n        }\n\n        .table-2 td {\n            padding: 36px 24px 0;\n            border-top: 3px solid #d4dadf;\n            background-color: #ffffff;\n        }\n\n        .table-2 h1 {\n            margin: 0;\n            font-size: 20px;\n            font-weight: 600;\n            letter-spacing: -1px;\n            line-height: 48px;\n        }\n\n        .table-3 {\n            max-width: 600px;\n        }\n\n        .table-2 td {\n\n            background-color: #ffffff;\n        }\n\n        .td-1 {\n            padding: 24px;\n            font-size: 16px;\n            line-height: 24px;\n            background-color: #ffffff;\n            text-align: left;\n            padding-bottom: 10px;\n            padding-top: 0px;\n        }\n\n        .table-gray {\n            width: 100%;\n        }\n\n        .table-gray tr {\n            height: 24px;\n        }\n\n        .table-gray .td-1 {\n            background-color: #f1f3f7;\n            width: 30%;\n            border: solid 1px #e7e9ec;\n            padding-top: 5px;\n            padding-bottom: 5px;\n        }\n\n        .table-gray .td-2 {\n            background-color: #f1f3f7;\n            width: 70%;\n            border: solid 1px #e7e9ec;\n        }\n\n        .button, .button:active, .button:visited {\n            display: inline-block;\n            padding: 16px 36px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 16px;\n            color: #ffffff;\n            text-decoration: none;\n            border-radius: 6px;\n            background-color: #1a82e2;\n            border-radius: 6px;\n        }\n\n        .signature {\n            padding: 24px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 16px;\n            line-height: 24px;\n            border-bottom: 3px solid #d4dadf;\n            background-color: #ffffff;\n        }\n\n        .footer {\n            max-width: 600px;\n        }\n\n        .footer td {\n            padding: 12px 24px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 14px;\n            line-height: 20px;\n            color: #666;\n        }\n\n        .td-button {\n            padding: 12px;\n            background-color: #ffffff;\n            text-align: center;\n        }\n\n        .p-24 {\n            padding: 24px;\n        }\n    </style>\n\n</head>\n\n<body>\n<!-- start body -->\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start hero -->\n<tbody>\n<tr>\n<td align=\"center\">\n<table class=\"table-1\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td align=\"left\">\n<h1>Welcome</h1>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end hero --> <!-- start hero -->\n<tr>\n<td align=\"center\">\n<table class=\"table-2\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td align=\"left\">\n<h1>Hi {first_name},</h1>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end hero --> <!-- start copy block -->\n<tr>\n<td align=\"center\">\n<table class=\"table-3\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start copy -->\n<tbody>\n<tr>\n<td class=\"td-1\">\n<p>Your account has been created. Below are your login details.</p>\n</td>\n</tr>\n<tr>\n<td class=\"td-1\">\n<table class=\"table-gray\" cellpadding=\"5\">\n<tbody>\n<tr>\n<td class=\"td-1\"><strong>Username</strong></td>\n<td class=\"td-2\">{username}</td>\n</tr>\n<tr>\n<td class=\"td-1\"><strong>Password</strong></td>\n<td class=\"td-2\">{password}</td>\n</tr>\n</tbody>\n</table>\n<p>You will be asked to change your password the first time you log in.</p>\n</td>\n</tr>\n<tr>\n<td align=\"left\" bgcolor=\"#ffffff\">\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td class=\"td-button\">\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td align=\"center\"><a class=\"button\" href=\"{dashboard_url}\" target=\"_blank\" rel=\"noopener\">Login To You Account</a></td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<tr>\n<td class=\"signature\">\n<p>{email_signature}</p>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end copy block --> <!-- start footer -->\n<tr>\n<td class=\"p-24\" align=\"center\">\n<table class=\"footer\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start permission -->\n<tbody>\n<tr>\n<td align=\"center\">\n<p>{email_footer}</p>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end footer --></tbody>\n</table>\n<!-- end body -->\n</body>\n\n</html>', '{first_name}, {last_name}, {username}, {password}', '2019-12-08 17:13:10', '2020-11-12 10:10:48', 'enabled', 'english', 'yes', 'yes', 1),
(NULL, NULL, 'Reset Password Request', 'template_lang_reset_password_request', 'everyone', 'users', 'Reset Password Request', '<!DOCTYPE html>\n<html>\n\n<head>\n\n    <meta charset=\"utf-8\">\n    <meta http-equiv=\"x-ua-compatible\" content=\"ie=edge\">\n    <title>Email Confirmation</title>\n    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">\n    <style type=\"text/css\">\n        @media screen {\n            @font-face {\n                font-family: \'Source Sans Pro\';\n                font-style: normal;\n                font-weight: 400;\n                src: local(\'Source Sans Pro Regular\'), local(\'SourceSansPro-Regular\'), url(https://fonts.gstatic.com/s/sourcesanspro/v10/ODelI1aHBYDBqgeIAH2zlBM0YzuT7MdOe03otPbuUS0.woff) format(\'woff\');\n            }\n\n            @font-face {\n                font-family: \'Source Sans Pro\';\n                font-style: normal;\n                font-weight: 700;\n                src: local(\'Source Sans Pro Bold\'), local(\'SourceSansPro-Bold\'), url(https://fonts.gstatic.com/s/sourcesanspro/v10/toadOcfmlt9b38dHJxOBGFkQc6VGVFSmCnC_l7QZG60.woff) format(\'woff\');\n            }\n        }\n\n        body,\n        table,\n        td,\n        a {\n            -ms-text-size-adjust: 100%;\n            /* 1 */\n            -webkit-text-size-adjust: 100%;\n            /* 2 */\n        }\n\n        img {\n            -ms-interpolation-mode: bicubic;\n        }\n\n        a[x-apple-data-detectors] {\n            font-family: inherit !important;\n            font-size: inherit !important;\n            font-weight: inherit !important;\n            line-height: inherit !important;\n            color: inherit !important;\n            text-decoration: none !important;\n        }\n\n        div[style*=\"margin: 16px 0;\"] {\n            margin: 0 !important;\n        }\n\n        body {\n            width: 100% !important;\n            height: 100% !important;\n            padding: 0 !important;\n            margin: 0 !important;\n            padding: 24px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 16px;\n            background-color: #f9fafc;\n            color: #60676d;\n        }\n\n        table {\n            border-collapse: collapse !important;\n        }\n\n        a {\n            color: #1a82e2;\n        }\n\n        img {\n            height: auto;\n            line-height: 100%;\n            text-decoration: none;\n            border: 0;\n            outline: none;\n        }\n\n        .table-1 {\n            max-width: 600px;\n        }\n\n        .table-1 td {\n            padding: 36px 24px 40px;\n            text-align: center;\n        }\n\n        .table-1 h1 {\n            margin: 0;\n            font-size: 32px;\n            font-weight: 600;\n            letter-spacing: -1px;\n            line-height: 48px;\n        }\n\n        .table-2 {\n            max-width: 600px;\n        }\n\n        .table-2 td {\n            padding: 36px 24px 0;\n            border-top: 3px solid #d4dadf;\n            background-color: #ffffff;\n        }\n\n        .table-2 h1 {\n            margin: 0;\n            font-size: 20px;\n            font-weight: 600;\n            letter-spacing: -1px;\n            line-height: 48px;\n        }\n\n        .table-3 {\n            max-width: 600px;\n        }\n\n        .table-2 td {\n\n            background-color: #ffffff;\n        }\n\n        .td-1 {\n            padding: 24px;\n            font-size: 16px;\n            line-height: 24px;\n            background-color: #ffffff;\n            text-align: left;\n            padding-bottom: 10px;\n            padding-top: 0px;\n        }\n\n        .table-gray {\n            width: 100%;\n        }\n\n        .table-gray tr {\n            height: 24px;\n        }\n\n        .table-gray .td-1 {\n            background-color: #f1f3f7;\n            width: 30%;\n            border: solid 1px #e7e9ec;\n            padding-top: 5px;\n            padding-bottom: 5px;\n        }\n\n        .table-gray .td-2 {\n            background-color: #f1f3f7;\n            width: 70%;\n            border: solid 1px #e7e9ec;\n        }\n\n        .button, .button:active, .button:visited {\n            display: inline-block;\n            padding: 16px 36px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 16px;\n            color: #ffffff;\n            text-decoration: none;\n            border-radius: 6px;\n            background-color: #1a82e2;\n            border-radius: 6px;\n        }\n\n        .signature {\n            padding: 24px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 16px;\n            line-height: 24px;\n            border-bottom: 3px solid #d4dadf;\n            background-color: #ffffff;\n        }\n\n        .footer {\n            max-width: 600px;\n        }\n\n        .footer td {\n            padding: 12px 24px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 14px;\n            line-height: 20px;\n            color: #666;\n        }\n\n        .td-button {\n            padding: 12px;\n            background-color: #ffffff;\n            text-align: center;\n        }\n\n        .p-24 {\n            padding: 24px;\n        }\n    </style>\n\n</head>\n\n<body>\n<!-- start body -->\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start hero -->\n<tbody>\n<tr>\n<td align=\"center\">\n<table class=\"table-1\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td align=\"left\">\n<h1>Reset Your Password</h1>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end hero --> <!-- start hero -->\n<tr>\n<td align=\"center\">\n<table class=\"table-2\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td align=\"left\">\n<h1>Hi {first_name},</h1>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end hero --> <!-- start copy block -->\n<tr>\n<td align=\"center\">\n<table class=\"table-3\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start copy -->\n<tbody>\n<tr>\n<td class=\"td-1\">\n<p>To complete your password request, please follow the link below.</p>\n</td>\n</tr>\n<tr>\n<td class=\"td-1\">\n<p>If you are not the one that has initiated this password request, please contact us.</p>\n</td>\n</tr>\n<tr>\n<td align=\"left\" bgcolor=\"#ffffff\">\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td class=\"td-button\">\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td align=\"center\"><a class=\"button\" href=\"{password_reset_link}\" target=\"_blank\" rel=\"noopener\">Reset Password</a></td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<tr>\n<td class=\"signature\">\n<p>{email_signature}</p>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end copy block --> <!-- start footer -->\n<tr>\n<td class=\"p-24\" align=\"center\">\n<table class=\"footer\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start permission -->\n<tbody>\n<tr>\n<td align=\"center\">\n<p>{email_footer}</p>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end footer --></tbody>\n</table>\n<!-- end body -->\n</body>\n\n</html>', '{first_name}, {last_name}, {password_reset_link}', '2019-12-08 17:13:10', '2020-11-12 12:21:58', 'enabled', 'english', 'yes', 'yes', 2),
(NULL, NULL, 'Email Signature', 'template_lang_email_signature', 'everyone', 'other', '---', '<div align=\"left\">\r\n<p>Thanks,</p>\r\n<p><strong>Support Team</strong></p>\r\n</div>', '', '2019-12-08 17:13:10', '2020-08-23 06:58:05', 'disabled', 'english', 'no', 'no', 100),
(NULL, NULL, 'Email Footer', 'template_lang_email_footer', 'everyone', 'other', '---', '<p>You received this email because you have an account with us. You can change your email preferences in your account dashboard.</p>', '', '2019-12-08 17:13:10', '2020-11-12 20:38:15', 'disabled', 'english', 'no', 'no', 102),
(NULL, NULL, 'New Project Created', 'template_lang_new_project_created', 'client', 'projects', 'New Project Created', '<!DOCTYPE html>\n<html>\n\n<head>\n\n    <meta charset=\"utf-8\">\n    <meta http-equiv=\"x-ua-compatible\" content=\"ie=edge\">\n    <title>Email Confirmation</title>\n    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">\n    <style type=\"text/css\">\n        @media screen {\n            @font-face {\n                font-family: \'Source Sans Pro\';\n                font-style: normal;\n                font-weight: 400;\n                src: local(\'Source Sans Pro Regular\'), local(\'SourceSansPro-Regular\'), url(https://fonts.gstatic.com/s/sourcesanspro/v10/ODelI1aHBYDBqgeIAH2zlBM0YzuT7MdOe03otPbuUS0.woff) format(\'woff\');\n            }\n\n            @font-face {\n                font-family: \'Source Sans Pro\';\n                font-style: normal;\n                font-weight: 700;\n                src: local(\'Source Sans Pro Bold\'), local(\'SourceSansPro-Bold\'), url(https://fonts.gstatic.com/s/sourcesanspro/v10/toadOcfmlt9b38dHJxOBGFkQc6VGVFSmCnC_l7QZG60.woff) format(\'woff\');\n            }\n        }\n\n        body,\n        table,\n        td,\n        a {\n            -ms-text-size-adjust: 100%;\n            /* 1 */\n            -webkit-text-size-adjust: 100%;\n            /* 2 */\n        }\n\n        img {\n            -ms-interpolation-mode: bicubic;\n        }\n\n        a[x-apple-data-detectors] {\n            font-family: inherit !important;\n            font-size: inherit !important;\n            font-weight: inherit !important;\n            line-height: inherit !important;\n            color: inherit !important;\n            text-decoration: none !important;\n        }\n\n        div[style*=\"margin: 16px 0;\"] {\n            margin: 0 !important;\n        }\n\n        body {\n            width: 100% !important;\n            height: 100% !important;\n            padding: 0 !important;\n            margin: 0 !important;\n            padding: 24px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 16px;\n            background-color: #f9fafc;\n            color: #60676d;\n        }\n\n        table {\n            border-collapse: collapse !important;\n        }\n\n        a {\n            color: #1a82e2;\n        }\n\n        img {\n            height: auto;\n            line-height: 100%;\n            text-decoration: none;\n            border: 0;\n            outline: none;\n        }\n\n        .table-1 {\n            max-width: 600px;\n        }\n\n        .table-1 td {\n            padding: 36px 24px 40px;\n            text-align: center;\n        }\n\n        .table-1 h1 {\n            margin: 0;\n            font-size: 32px;\n            font-weight: 600;\n            letter-spacing: -1px;\n            line-height: 48px;\n        }\n\n        .table-2 {\n            max-width: 600px;\n        }\n\n        .table-2 td {\n            padding: 36px 24px 0;\n            border-top: 3px solid #d4dadf;\n            background-color: #ffffff;\n        }\n\n        .table-2 h1 {\n            margin: 0;\n            font-size: 20px;\n            font-weight: 600;\n            letter-spacing: -1px;\n            line-height: 48px;\n        }\n\n        .table-3 {\n            max-width: 600px;\n        }\n\n        .table-2 td {\n\n            background-color: #ffffff;\n        }\n\n        .td-1 {\n            padding: 24px;\n            font-size: 16px;\n            line-height: 24px;\n            background-color: #ffffff;\n            text-align: left;\n            padding-bottom: 10px;\n            padding-top: 0px;\n        }\n\n        .table-gray {\n            width: 100%;\n        }\n\n        .table-gray tr {\n            height: 24px;\n        }\n\n        .table-gray .td-1 {\n            background-color: #f1f3f7;\n            width: 30%;\n            border: solid 1px #e7e9ec;\n            padding-top: 5px;\n            padding-bottom: 5px;\n            font-size:16px;\n        }\n\n        .table-gray .td-2 {\n            background-color: #f1f3f7;\n            width: 70%;\n            border: solid 1px #e7e9ec;\n            font-size:16px;\n        }\n\n        .button, .button:active, .button:visited {\n            display: inline-block;\n            padding: 16px 36px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 16px;\n            color: #ffffff;\n            text-decoration: none;\n            border-radius: 6px;\n            background-color: #1a82e2;\n            border-radius: 6px;\n        }\n\n        .signature {\n            padding: 24px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 16px;\n            line-height: 24px;\n            border-bottom: 3px solid #d4dadf;\n            background-color: #ffffff;\n        }\n\n        .footer {\n            max-width: 600px;\n        }\n\n        .footer td {\n            padding: 12px 24px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 14px;\n            line-height: 20px;\n            color: #666;\n        }\n\n        .td-button {\n            padding: 12px;\n            background-color: #ffffff;\n            text-align: center;\n        }\n\n        .p-24 {\n            padding: 24px;\n        }\n    </style>\n\n</head>\n\n<body>\n<!-- start body -->\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start hero -->\n<tbody>\n<tr>\n<td align=\"center\">\n<table class=\"table-1\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td align=\"left\">\n<h1>New Project Details</h1>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end hero --> <!-- start hero -->\n<tr>\n<td align=\"center\">\n<table class=\"table-2\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td align=\"left\">\n<h1>Hi {first_name},</h1>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end hero --> <!-- start copy block -->\n<tr>\n<td align=\"center\">\n<table class=\"table-3\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start copy -->\n<tbody>\n<tr>\n<td class=\"td-1\">\n<p>Your new project has just been created. Below are the project\'s details.</p>\n</td>\n</tr>\n<tr>\n<td class=\"td-1\">\n<table class=\"table-gray\" cellpadding=\"5\">\n<tbody>\n<tr>\n<td class=\"td-1\"><strong>Project ID</strong></td>\n<td class=\"td-2\">{project_id}</td>\n</tr>\n<tr>\n<td class=\"td-1\"><strong>Project Title</strong></td>\n<td class=\"td-2\">{project_title}</td>\n</tr>\n<tr>\n<td class=\"td-1\"><strong>Start Date</strong></td>\n<td class=\"td-2\">{project_start_date}</td>\n</tr>\n<tr>\n<td class=\"td-1\"><strong>Due Date</strong></td>\n<td class=\"td-2\">{project_due_date}</td>\n</tr>\n</tbody>\n</table>\n<p>You can manage your project via the dashboard.</p>\n</td>\n</tr>\n<tr>\n<td align=\"left\" bgcolor=\"#ffffff\">\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td class=\"td-button\">\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td align=\"center\"><a class=\"button\" href=\"{dashboard_url}\" target=\"_blank\" rel=\"noopener\">Login To You Account</a></td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<tr>\n<td class=\"signature\">\n<p>{email_signature}</p>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end copy block --> <!-- start footer -->\n<tr>\n<td class=\"p-24\" align=\"center\">\n<table class=\"footer\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start permission -->\n<tbody>\n<tr>\n<td align=\"center\">\n<p>{email_footer}</p>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end footer --></tbody>\n</table>\n<!-- end body -->\n</body>\n\n</html>', '{first_name}, {last_name}, {project_id}, {project_title}, {project_start_date}, {project_due_date}, {project_status}, {project_category}, {project_hourly_rate}, {project_description}, {client_name}, {client_id}, {project_url}', '2019-12-08 17:13:10', '2021-01-15 20:00:36', 'enabled', 'english', 'yes', 'yes', 103),
(NULL, NULL, 'Project Status Change', 'template_lang_project_status_change', 'client', 'projects', 'Project Status Has Changed', '<!DOCTYPE html>\n<html>\n\n<head>\n\n    <meta charset=\"utf-8\">\n    <meta http-equiv=\"x-ua-compatible\" content=\"ie=edge\">\n    <title>Email Confirmation</title>\n    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">\n    <style type=\"text/css\">\n        @media screen {\n            @font-face {\n                font-family: \'Source Sans Pro\';\n                font-style: normal;\n                font-weight: 400;\n                src: local(\'Source Sans Pro Regular\'), local(\'SourceSansPro-Regular\'), url(https://fonts.gstatic.com/s/sourcesanspro/v10/ODelI1aHBYDBqgeIAH2zlBM0YzuT7MdOe03otPbuUS0.woff) format(\'woff\');\n            }\n\n            @font-face {\n                font-family: \'Source Sans Pro\';\n                font-style: normal;\n                font-weight: 700;\n                src: local(\'Source Sans Pro Bold\'), local(\'SourceSansPro-Bold\'), url(https://fonts.gstatic.com/s/sourcesanspro/v10/toadOcfmlt9b38dHJxOBGFkQc6VGVFSmCnC_l7QZG60.woff) format(\'woff\');\n            }\n        }\n\n        body,\n        table,\n        td,\n        a {\n            -ms-text-size-adjust: 100%;\n            /* 1 */\n            -webkit-text-size-adjust: 100%;\n            /* 2 */\n        }\n\n        img {\n            -ms-interpolation-mode: bicubic;\n        }\n\n        a[x-apple-data-detectors] {\n            font-family: inherit !important;\n            font-size: inherit !important;\n            font-weight: inherit !important;\n            line-height: inherit !important;\n            color: inherit !important;\n            text-decoration: none !important;\n        }\n\n        div[style*=\"margin: 16px 0;\"] {\n            margin: 0 !important;\n        }\n\n        body {\n            width: 100% !important;\n            height: 100% !important;\n            padding: 0 !important;\n            margin: 0 !important;\n            padding: 24px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 16px;\n            background-color: #f9fafc;\n            color: #60676d;\n        }\n\n        table {\n            border-collapse: collapse !important;\n        }\n\n        a {\n            color: #1a82e2;\n        }\n\n        img {\n            height: auto;\n            line-height: 100%;\n            text-decoration: none;\n            border: 0;\n            outline: none;\n        }\n\n        .table-1 {\n            max-width: 600px;\n        }\n\n        .table-1 td {\n            padding: 36px 24px 40px;\n            text-align: center;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-1 h1 {\n            margin: 0;\n            font-size: 32px;\n            font-weight: 600;\n            letter-spacing: -1px;\n            line-height: 48px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-2 {\n            max-width: 600px;\n        }\n\n        .table-2 td {\n            padding: 36px 24px 0;\n            border-top: 3px solid #d4dadf;\n            background-color: #ffffff;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-2 h1 {\n            margin: 0;\n            font-size: 20px;\n            font-weight: 600;\n            letter-spacing: -1px;\n            line-height: 48px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-3 {\n            max-width: 600px;\n        }\n\n        .table-2 td {\n\n            background-color: #ffffff;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .td-1 {\n            padding: 24px;\n            font-size: 16px;\n            line-height: 24px;\n            background-color: #ffffff;\n            text-align: left;\n            padding-bottom: 10px;\n            padding-top: 0px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-gray {\n            width: 100%;\n        }\n\n        .table-gray tr {\n            height: 24px;\n        }\n\n        .table-gray .td-1 {\n            background-color: #f1f3f7;\n            width: 30%;\n            border: solid 1px #e7e9ec;\n            padding-top: 5px;\n            padding-bottom: 5px;\n            font-size:16px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-gray .td-2 {\n            background-color: #f1f3f7;\n            width: 70%;\n            border: solid 1px #e7e9ec;\n            font-size:16px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .button, .button:active, .button:visited {\n            display: inline-block;\n            padding: 16px 36px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 16px;\n            color: #ffffff;\n            text-decoration: none;\n            border-radius: 6px;\n            background-color: #1a82e2;\n            border-radius: 6px;\n        }\n\n        .signature {\n            padding: 24px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 16px;\n            line-height: 24px;\n            border-bottom: 3px solid #d4dadf;\n            background-color: #ffffff;\n        }\n\n        .footer {\n            max-width: 600px;\n        }\n\n        .footer td {\n            padding: 12px 24px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 14px;\n            line-height: 20px;\n            color: #666;\n        }\n\n        .td-button {\n            padding: 12px;\n            background-color: #ffffff;\n            text-align: center;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .p-24 {\n            padding: 24px;\n        }\n    </style>\n\n</head>\n\n<body>\n<!-- start body -->\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start hero -->\n<tbody>\n<tr>\n<td align=\"center\">\n<table class=\"table-1\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td align=\"left\">\n<h1>Project Status Changed</h1>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end hero --> <!-- start hero -->\n<tr>\n<td align=\"center\">\n<table class=\"table-2\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td align=\"left\">\n<h1>Hi {first_name},</h1>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end hero --> <!-- start copy block -->\n<tr>\n<td align=\"center\">\n<table class=\"table-3\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start copy -->\n<tbody>\n<tr>\n<td class=\"td-1\">\n<p>The status of your project has just been updated. The new status is shown below.</p>\n</td>\n</tr>\n<tr>\n<td class=\"td-1\">\n<table class=\"table-gray\" cellpadding=\"5\">\n<tbody>\n<tr>\n<td class=\"td-1\"><strong>Project ID</strong></td>\n<td class=\"td-2\">{project_id}</td>\n</tr>\n<tr>\n<td class=\"td-1\"><strong>Project Title</strong></td>\n<td class=\"td-2\">{project_title}</td>\n</tr>\n<tr>\n<td class=\"td-1\"><strong>Status</strong></td>\n<td class=\"td-2\">{project_status}</td>\n</tr>\n</tbody>\n</table>\n<p>You can manage your project via the dashboard.</p>\n</td>\n</tr>\n<tr>\n<td align=\"left\" bgcolor=\"#ffffff\">\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td class=\"td-button\">\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td align=\"center\"><a class=\"button\" href=\"{project_url}\" target=\"_blank\" rel=\"noopener\">Manage Project</a></td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<tr>\n<td class=\"signature\">\n<p>{email_signature}</p>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end copy block --> <!-- start footer -->\n<tr>\n<td class=\"p-24\" align=\"center\">\n<table class=\"footer\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start permission -->\n<tbody>\n<tr>\n<td align=\"center\">\n<p>{email_footer}</p>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end footer --></tbody>\n</table>\n<!-- end body -->\n</body>\n\n</html>', '{first_name}, {last_name}, {project_id}, {project_title}, {project_description}, {project_start_date}, {project_due_date}, {project_status}, {project_category}, {project_hourly_rate}, {project_description}, {client_name}, {client_id}, {project_url}', '2019-12-08 17:13:10', '2020-11-13 08:11:06', 'enabled', 'english', 'yes', 'yes', 105),
(NULL, NULL, 'Project File Uploaded', 'template_lang_project_file_uploaded', 'everyone', 'projects', 'New Project File Uploaded', '<!DOCTYPE html>\n<html>\n\n<head>\n\n    <meta charset=\"utf-8\">\n    <meta http-equiv=\"x-ua-compatible\" content=\"ie=edge\">\n    <title>Email Confirmation</title>\n    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">\n    <style type=\"text/css\">\n        @media screen {\n            @font-face {\n                font-family: \'Source Sans Pro\';\n                font-style: normal;\n                font-weight: 400;\n                src: local(\'Source Sans Pro Regular\'), local(\'SourceSansPro-Regular\'), url(https://fonts.gstatic.com/s/sourcesanspro/v10/ODelI1aHBYDBqgeIAH2zlBM0YzuT7MdOe03otPbuUS0.woff) format(\'woff\');\n            }\n\n            @font-face {\n                font-family: \'Source Sans Pro\';\n                font-style: normal;\n                font-weight: 700;\n                src: local(\'Source Sans Pro Bold\'), local(\'SourceSansPro-Bold\'), url(https://fonts.gstatic.com/s/sourcesanspro/v10/toadOcfmlt9b38dHJxOBGFkQc6VGVFSmCnC_l7QZG60.woff) format(\'woff\');\n            }\n        }\n\n        body,\n        table,\n        td,\n        a {\n            -ms-text-size-adjust: 100%;\n            /* 1 */\n            -webkit-text-size-adjust: 100%;\n            /* 2 */\n        }\n\n        img {\n            -ms-interpolation-mode: bicubic;\n        }\n\n        a[x-apple-data-detectors] {\n            font-family: inherit !important;\n            font-size: inherit !important;\n            font-weight: inherit !important;\n            line-height: inherit !important;\n            color: inherit !important;\n            text-decoration: none !important;\n        }\n\n        div[style*=\"margin: 16px 0;\"] {\n            margin: 0 !important;\n        }\n\n        body {\n            width: 100% !important;\n            height: 100% !important;\n            padding: 0 !important;\n            margin: 0 !important;\n            padding: 24px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 16px;\n            background-color: #f9fafc;\n            color: #60676d;\n        }\n\n        table {\n            border-collapse: collapse !important;\n        }\n\n        a {\n            color: #1a82e2;\n        }\n\n        img {\n            height: auto;\n            line-height: 100%;\n            text-decoration: none;\n            border: 0;\n            outline: none;\n        }\n\n        .table-1 {\n            max-width: 600px;\n        }\n\n        .table-1 td {\n            padding: 36px 24px 40px;\n            text-align: center;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-1 h1 {\n            margin: 0;\n            font-size: 32px;\n            font-weight: 600;\n            letter-spacing: -1px;\n            line-height: 48px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-2 {\n            max-width: 600px;\n        }\n\n        .table-2 td {\n            padding: 36px 24px 0;\n            border-top: 3px solid #d4dadf;\n            background-color: #ffffff;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-2 h1 {\n            margin: 0;\n            font-size: 20px;\n            font-weight: 600;\n            letter-spacing: -1px;\n            line-height: 48px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-3 {\n            max-width: 600px;\n        }\n\n        .table-2 td {\n\n            background-color: #ffffff;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .td-1 {\n            padding: 24px;\n            font-size: 16px;\n            line-height: 24px;\n            background-color: #ffffff;\n            text-align: left;\n            padding-bottom: 10px;\n            padding-top: 0px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-gray {\n            width: 100%;\n        }\n\n        .table-gray tr {\n            height: 24px;\n        }\n\n        .table-gray .td-1 {\n            background-color: #f1f3f7;\n            width: 30%;\n            border: solid 1px #e7e9ec;\n            padding-top: 5px;\n            padding-bottom: 5px;\n            font-size:16px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-gray .td-2 {\n            background-color: #f1f3f7;\n            width: 70%;\n            border: solid 1px #e7e9ec;\n            font-size:16px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .button, .button:active, .button:visited {\n            display: inline-block;\n            padding: 16px 36px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 16px;\n            color: #ffffff;\n            text-decoration: none;\n            border-radius: 6px;\n            background-color: #1a82e2;\n            border-radius: 6px;\n        }\n\n        .signature {\n            padding: 24px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 16px;\n            line-height: 24px;\n            border-bottom: 3px solid #d4dadf;\n            background-color: #ffffff;\n        }\n\n        .footer {\n            max-width: 600px;\n        }\n\n        .footer td {\n            padding: 12px 24px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 14px;\n            line-height: 20px;\n            color: #666;\n        }\n\n        .td-button {\n            padding: 12px;\n            background-color: #ffffff;\n            text-align: center;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .p-24 {\n            padding: 24px;\n        }\n    </style>\n\n</head>\n\n<body>\n<!-- start body -->\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start hero -->\n<tbody>\n<tr>\n<td align=\"center\">\n<table class=\"table-1\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td align=\"left\">\n<h1>New File Uploaded</h1>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end hero --> <!-- start hero -->\n<tr>\n<td align=\"center\">\n<table class=\"table-2\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td align=\"left\">\n<h1>Hi {first_name},</h1>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end hero --> <!-- start copy block -->\n<tr>\n<td align=\"center\">\n<table class=\"table-3\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start copy -->\n<tbody>\n<tr>\n<td class=\"td-1\">\n<p>A new file has been uploaded to the project.</p>\n</td>\n</tr>\n<tr>\n<td class=\"td-1\">\n<table class=\"table-gray\" cellpadding=\"5\">\n<tbody>\n<tr>\n<td class=\"td-1\"><strong>Project ID</strong></td>\n<td class=\"td-2\">{project_id}</td>\n</tr>\n<tr>\n<td class=\"td-1\"><strong>Project Title</strong></td>\n<td class=\"td-2\">{project_title}</td>\n</tr>\n<tr>\n<td class=\"td-1\"><strong>File</strong></td>\n<td class=\"td-2\"><a href=\"{file_url}\">{file_name}</a></td>\n</tr>\n<tr>\n<td class=\"td-1\"><strong>Uploaded By</strong></td>\n<td class=\"td-2\">{uploader_first_name}</td>\n</tr>\n</tbody>\n</table>\n<p>You can manage your project via the dashboard.</p>\n</td>\n</tr>\n<tr>\n<td align=\"left\" bgcolor=\"#ffffff\">\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td class=\"td-button\">\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td align=\"center\"><a class=\"button\" href=\"{project_files_url}\" target=\"_blank\" rel=\"noopener\">Manage Project</a></td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<tr>\n<td class=\"signature\">\n<p>{email_signature}</p>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end copy block --> <!-- start footer -->\n<tr>\n<td class=\"p-24\" align=\"center\">\n<table class=\"footer\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start permission -->\n<tbody>\n<tr>\n<td align=\"center\">\n<p>{email_footer}</p>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end footer --></tbody>\n</table>\n<!-- end body -->\n</body>\n\n</html>', '{first_name}, {last_name}, {file_name}, {file_size}, {file_extension}, {file_url}, {uploader_first_name}, {uploader_last_name}, {project_id}, {project_description}, {project_title}, {project_start_date}, {project_due_date}, {project_status}, {project_category}, {project_hourly_rate}, {project_description}, {client_name}, {client_id}, {project_url}, {project_files_url}', '2019-12-08 17:13:10', '2020-11-12 12:25:45', 'enabled', 'english', 'yes', 'yes', 106);
INSERT INTO `email_templates` (`emailtemplate_module_unique_id`, `emailtemplate_module_name`, `emailtemplate_name`, `emailtemplate_lang`, `emailtemplate_type`, `emailtemplate_category`, `emailtemplate_subject`, `emailtemplate_body`, `emailtemplate_variables`, `emailtemplate_created`, `emailtemplate_updated`, `emailtemplate_status`, `emailtemplate_language`, `emailtemplate_real_template`, `emailtemplate_show_enabled`, `emailtemplate_id`) VALUES
(NULL, NULL, 'Project Comment', 'template_lang_project_comment', 'everyone', 'projects', 'New Project Comment', '<!DOCTYPE html>\r\n<html>\r\n\r\n<head>\r\n\r\n    <meta charset=\"utf-8\">\r\n    <meta http-equiv=\"x-ua-compatible\" content=\"ie=edge\">\r\n    <title>Email Confirmation</title>\r\n    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">\r\n    <style type=\"text/css\">\r\n        @media screen {\r\n            @font-face {\r\n                font-family: \'Source Sans Pro\';\r\n                font-style: normal;\r\n                font-weight: 400;\r\n                src: local(\'Source Sans Pro Regular\'), local(\'SourceSansPro-Regular\'), url(https://fonts.gstatic.com/s/sourcesanspro/v10/ODelI1aHBYDBqgeIAH2zlBM0YzuT7MdOe03otPbuUS0.woff) format(\'woff\');\r\n            }\r\n\r\n            @font-face {\r\n                font-family: \'Source Sans Pro\';\r\n                font-style: normal;\r\n                font-weight: 700;\r\n                src: local(\'Source Sans Pro Bold\'), local(\'SourceSansPro-Bold\'), url(https://fonts.gstatic.com/s/sourcesanspro/v10/toadOcfmlt9b38dHJxOBGFkQc6VGVFSmCnC_l7QZG60.woff) format(\'woff\');\r\n            }\r\n        }\r\n\r\n        body,\r\n        table,\r\n        td,\r\n        a {\r\n            -ms-text-size-adjust: 100%;\r\n            /* 1 */\r\n            -webkit-text-size-adjust: 100%;\r\n            /* 2 */\r\n        }\r\n\r\n        img {\r\n            -ms-interpolation-mode: bicubic;\r\n        }\r\n\r\n        a[x-apple-data-detectors] {\r\n            font-family: inherit !important;\r\n            font-size: inherit !important;\r\n            font-weight: inherit !important;\r\n            line-height: inherit !important;\r\n            color: inherit !important;\r\n            text-decoration: none !important;\r\n        }\r\n\r\n        div[style*=\"margin: 16px 0;\"] {\r\n            margin: 0 !important;\r\n        }\r\n\r\n        body {\r\n            width: 100% !important;\r\n            height: 100% !important;\r\n            padding: 0 !important;\r\n            margin: 0 !important;\r\n            padding: 24px;\r\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\r\n            font-size: 16px;\r\n            background-color: #f9fafc;\r\n            color: #60676d;\r\n        }\r\n\r\n        table {\r\n            border-collapse: collapse !important;\r\n        }\r\n\r\n        a {\r\n            color: #1a82e2;\r\n        }\r\n\r\n        img {\r\n            height: auto;\r\n            line-height: 100%;\r\n            text-decoration: none;\r\n            border: 0;\r\n            outline: none;\r\n        }\r\n\r\n        .table-1 {\r\n            max-width: 600px;\r\n        }\r\n\r\n        .table-1 td {\r\n            padding: 36px 24px 40px;\r\n            text-align: center;\r\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\r\n        }\r\n\r\n        .table-1 h1 {\r\n            margin: 0;\r\n            font-size: 32px;\r\n            font-weight: 600;\r\n            letter-spacing: -1px;\r\n            line-height: 48px;\r\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\r\n        }\r\n\r\n        .table-2 {\r\n            max-width: 600px;\r\n        }\r\n\r\n        .table-2 td {\r\n            padding: 36px 24px 0;\r\n            border-top: 3px solid #d4dadf;\r\n            background-color: #ffffff;\r\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\r\n        }\r\n\r\n        .table-2 h1 {\r\n            margin: 0;\r\n            font-size: 20px;\r\n            font-weight: 600;\r\n            letter-spacing: -1px;\r\n            line-height: 48px;\r\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\r\n        }\r\n\r\n        .table-3 {\r\n            max-width: 600px;\r\n        }\r\n\r\n        .table-2 td {\r\n\r\n            background-color: #ffffff;\r\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\r\n        }\r\n\r\n        .td-1 {\r\n            padding: 24px;\r\n            font-size: 16px;\r\n            line-height: 24px;\r\n            background-color: #ffffff;\r\n            text-align: left;\r\n            padding-bottom: 10px;\r\n            padding-top: 0px;\r\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\r\n        }\r\n\r\n        .table-gray {\r\n            width: 100%;\r\n        }\r\n\r\n        .table-gray tr {\r\n            height: 24px;\r\n        }\r\n\r\n        .table-gray .td-1 {\r\n            background-color: #f1f3f7;\r\n            width: 30%;\r\n            border: solid 1px #e7e9ec;\r\n            padding-top: 5px;\r\n            padding-bottom: 5px;\r\n            font-size:16px;\r\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\r\n        }\r\n\r\n        .table-gray .td-2 {\r\n            background-color: #f1f3f7;\r\n            width: 70%;\r\n            border: solid 1px #e7e9ec;\r\n            font-size:16px;\r\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\r\n        }\r\n\r\n        .button, .button:active, .button:visited {\r\n            display: inline-block;\r\n            padding: 16px 36px;\r\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\r\n            font-size: 16px;\r\n            color: #ffffff;\r\n            text-decoration: none;\r\n            border-radius: 6px;\r\n            background-color: #1a82e2;\r\n            border-radius: 6px;\r\n        }\r\n\r\n        .signature {\r\n            padding: 24px;\r\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\r\n            font-size: 16px;\r\n            line-height: 24px;\r\n            border-bottom: 3px solid #d4dadf;\r\n            background-color: #ffffff;\r\n        }\r\n\r\n        .footer {\r\n            max-width: 600px;\r\n        }\r\n\r\n        .footer td {\r\n            padding: 12px 24px;\r\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\r\n            font-size: 14px;\r\n            line-height: 20px;\r\n            color: #666;\r\n        }\r\n\r\n        .td-button {\r\n            padding: 12px;\r\n            background-color: #ffffff;\r\n            text-align: center;\r\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\r\n        }\r\n\r\n        .p-24 {\r\n            padding: 24px;\r\n        }\r\n    </style>\r\n\r\n</head>\r\n\r\n<body>\r\n<!-- start body -->\r\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start hero -->\r\n<tbody>\r\n<tr>\r\n<td align=\"center\">\r\n<table class=\"table-1\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\r\n<tbody>\r\n<tr>\r\n<td align=\"left\">\r\n<h1>New Comment Posted</h1>\r\n</td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n</td>\r\n</tr>\r\n<!-- end hero --> <!-- start hero -->\r\n<tr>\r\n<td align=\"center\">\r\n<table class=\"table-2\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\r\n<tbody>\r\n<tr>\r\n<td align=\"left\">\r\n<h1>Hi {first_name},</h1>\r\n</td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n</td>\r\n</tr>\r\n<!-- end hero --> <!-- start copy block -->\r\n<tr>\r\n<td align=\"center\">\r\n<table class=\"table-3\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start copy -->\r\n<tbody>\r\n<tr>\r\n<td class=\"td-1\">\r\n<p>A new comment has been posted on this project.</p>\r\n</td>\r\n</tr>\r\n<tr>\r\n<td class=\"td-1\">\r\n<table class=\"table-gray\" cellpadding=\"5\">\r\n<tbody>\r\n<tr>\r\n<td class=\"td-1\"><strong>Project Title</strong></td>\r\n<td class=\"td-2\">{project_title}</td>\r\n</tr>\r\n<tr>\r\n<td class=\"td-1\"><strong>Posted By</strong></td>\r\n<td class=\"td-2\">{poster_first_name}</td>\r\n</tr>\r\n<tr>\r\n<td class=\"td-1\" colspan=\"2\">{comment}</td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n<p>You can manage your project via the dashboard.</p>\r\n</td>\r\n</tr>\r\n<tr>\r\n<td align=\"left\" bgcolor=\"#ffffff\">\r\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\r\n<tbody>\r\n<tr>\r\n<td class=\"td-button\">\r\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\r\n<tbody>\r\n<tr>\r\n<td align=\"center\"><a class=\"button\" href=\"{project_comments_url}\" target=\"_blank\" rel=\"noopener\">Manage Project</a></td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n</td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n</td>\r\n</tr>\r\n<tr>\r\n<td class=\"signature\">\r\n<p>{email_signature}</p>\r\n</td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n</td>\r\n</tr>\r\n<!-- end copy block --> <!-- start footer -->\r\n<tr>\r\n<td class=\"p-24\" align=\"center\">\r\n<table class=\"footer\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start permission -->\r\n<tbody>\r\n<tr>\r\n<td align=\"center\">\r\n<p>{email_footer}</p>\r\n</td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n</td>\r\n</tr>\r\n<!-- end footer --></tbody>\r\n</table>\r\n<!-- end body -->\r\n</body>\r\n\r\n</html>', '{first_name}, {last_name}, {comment}, {poster_first_name}, {poster_last_name}, {project_id}, {project_title}, {project_start_date}, {project_due_date}, {project_status}, {project_category}, {project_hourly_rate}, {project_description}, {client_name}, {client_id}, {project_url}, {project_comments_url}', '2019-12-08 17:13:10', '2020-11-21 19:24:33', 'enabled', 'english', 'yes', 'yes', 107),
(NULL, NULL, 'Project Assignment', 'template_lang_project_assignment', 'team', 'projects', 'New Project Assignment', '<!DOCTYPE html>\n<html>\n\n<head>\n\n    <meta charset=\"utf-8\">\n    <meta http-equiv=\"x-ua-compatible\" content=\"ie=edge\">\n    <title>Email Confirmation</title>\n    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">\n    <style type=\"text/css\">\n        @media screen {\n            @font-face {\n                font-family: \'Source Sans Pro\';\n                font-style: normal;\n                font-weight: 400;\n                src: local(\'Source Sans Pro Regular\'), local(\'SourceSansPro-Regular\'), url(https://fonts.gstatic.com/s/sourcesanspro/v10/ODelI1aHBYDBqgeIAH2zlBM0YzuT7MdOe03otPbuUS0.woff) format(\'woff\');\n            }\n\n            @font-face {\n                font-family: \'Source Sans Pro\';\n                font-style: normal;\n                font-weight: 700;\n                src: local(\'Source Sans Pro Bold\'), local(\'SourceSansPro-Bold\'), url(https://fonts.gstatic.com/s/sourcesanspro/v10/toadOcfmlt9b38dHJxOBGFkQc6VGVFSmCnC_l7QZG60.woff) format(\'woff\');\n            }\n        }\n\n        body,\n        table,\n        td,\n        a {\n            -ms-text-size-adjust: 100%;\n            /* 1 */\n            -webkit-text-size-adjust: 100%;\n            /* 2 */\n        }\n\n        img {\n            -ms-interpolation-mode: bicubic;\n        }\n\n        a[x-apple-data-detectors] {\n            font-family: inherit !important;\n            font-size: inherit !important;\n            font-weight: inherit !important;\n            line-height: inherit !important;\n            color: inherit !important;\n            text-decoration: none !important;\n        }\n\n        div[style*=\"margin: 16px 0;\"] {\n            margin: 0 !important;\n        }\n\n        body {\n            width: 100% !important;\n            height: 100% !important;\n            padding: 0 !important;\n            margin: 0 !important;\n            padding: 24px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 16px;\n            background-color: #f9fafc;\n            color: #60676d;\n        }\n\n        table {\n            border-collapse: collapse !important;\n        }\n\n        a {\n            color: #1a82e2;\n        }\n\n        img {\n            height: auto;\n            line-height: 100%;\n            text-decoration: none;\n            border: 0;\n            outline: none;\n        }\n\n        .table-1 {\n            max-width: 600px;\n        }\n\n        .table-1 td {\n            padding: 36px 24px 40px;\n            text-align: center;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-1 h1 {\n            margin: 0;\n            font-size: 32px;\n            font-weight: 600;\n            letter-spacing: -1px;\n            line-height: 48px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-2 {\n            max-width: 600px;\n        }\n\n        .table-2 td {\n            padding: 36px 24px 0;\n            border-top: 3px solid #d4dadf;\n            background-color: #ffffff;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-2 h1 {\n            margin: 0;\n            font-size: 20px;\n            font-weight: 600;\n            letter-spacing: -1px;\n            line-height: 48px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-3 {\n            max-width: 600px;\n        }\n\n        .table-2 td {\n\n            background-color: #ffffff;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .td-1 {\n            padding: 24px;\n            font-size: 16px;\n            line-height: 24px;\n            background-color: #ffffff;\n            text-align: left;\n            padding-bottom: 10px;\n            padding-top: 0px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-gray {\n            width: 100%;\n        }\n\n        .table-gray tr {\n            height: 24px;\n        }\n\n        .table-gray .td-1 {\n            background-color: #f1f3f7;\n            width: 30%;\n            border: solid 1px #e7e9ec;\n            padding-top: 5px;\n            padding-bottom: 5px;\n            font-size:16px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-gray .td-2 {\n            background-color: #f1f3f7;\n            width: 70%;\n            border: solid 1px #e7e9ec;\n            font-size:16px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .button, .button:active, .button:visited {\n            display: inline-block;\n            padding: 16px 36px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 16px;\n            color: #ffffff;\n            text-decoration: none;\n            border-radius: 6px;\n            background-color: #1a82e2;\n            border-radius: 6px;\n        }\n\n        .signature {\n            padding: 24px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 16px;\n            line-height: 24px;\n            border-bottom: 3px solid #d4dadf;\n            background-color: #ffffff;\n        }\n\n        .footer {\n            max-width: 600px;\n        }\n\n        .footer td {\n            padding: 12px 24px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 14px;\n            line-height: 20px;\n            color: #666;\n        }\n\n        .td-button {\n            padding: 12px;\n            background-color: #ffffff;\n            text-align: center;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .p-24 {\n            padding: 24px;\n        }\n    </style>\n\n</head>\n\n<body>\n<!-- start body -->\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start hero -->\n<tbody>\n<tr>\n<td align=\"center\">\n<table class=\"table-1\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td align=\"left\">\n<h1>Project Assignment</h1>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end hero --> <!-- start hero -->\n<tr>\n<td align=\"center\">\n<table class=\"table-2\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td align=\"left\">\n<h1>Hi {first_name},</h1>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end hero --> <!-- start copy block -->\n<tr>\n<td align=\"center\">\n<table class=\"table-3\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start copy -->\n<tbody>\n<tr>\n<td class=\"td-1\">\n<p>You have just been assigned to a new project.</p>\n</td>\n</tr>\n<tr>\n<td class=\"td-1\">\n<table class=\"table-gray\" cellpadding=\"5\">\n<tbody>\n<tr>\n<td class=\"td-1\"><strong>Project ID</strong></td>\n<td class=\"td-2\">{project_id}</td>\n</tr>\n<tr>\n<td class=\"td-1\"><strong>Project Title</strong></td>\n<td class=\"td-2\">{project_title}</td>\n</tr>\n<tr>\n<td class=\"td-1\"><strong>Start Date</strong></td>\n<td class=\"td-2\">{project_start_date}</td>\n</tr>\n<tr>\n<td class=\"td-1\"><strong>Due Date</strong></td>\n<td class=\"td-2\">{project_due_date}</td>\n</tr>\n</tbody>\n</table>\n<p>You can manage your project via the dashboard.</p>\n</td>\n</tr>\n<tr>\n<td align=\"left\" bgcolor=\"#ffffff\">\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td class=\"td-button\">\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td align=\"center\"><a class=\"button\" href=\"{project_url}\" target=\"_blank\" rel=\"noopener\">Manage Project</a></td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<tr>\n<td class=\"signature\">\n<p>{email_signature}</p>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end copy block --> <!-- start footer -->\n<tr>\n<td class=\"p-24\" align=\"center\">\n<table class=\"footer\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start permission -->\n<tbody>\n<tr>\n<td align=\"center\">\n<p>{email_footer}</p>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end footer --></tbody>\n</table>\n<!-- end body -->\n</body>\n\n</html>', '{first_name}, {last_name}, {assigned_by_first_name}, {assigned_by_last_name}, {project_id}, {project_description}, {project_title}, {project_description}, {project_start_date}, {project_due_date}, {project_status}, {project_category}, {project_hourly_rate}, {project_description}, {client_name}, {client_id}, {project_url}', '2019-12-08 17:13:10', '2020-11-12 12:39:45', 'enabled', 'english', 'yes', 'yes', 108),
(NULL, NULL, 'Lead Status Change', 'template_lang_lead_status_change', 'team', 'leads', 'Lead Status Has Changed', '<!DOCTYPE html>\n<html>\n\n<head>\n\n    <meta charset=\"utf-8\">\n    <meta http-equiv=\"x-ua-compatible\" content=\"ie=edge\">\n    <title>Email Confirmation</title>\n    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">\n    <style type=\"text/css\">\n        @media screen {\n            @font-face {\n                font-family: \'Source Sans Pro\';\n                font-style: normal;\n                font-weight: 400;\n                src: local(\'Source Sans Pro Regular\'), local(\'SourceSansPro-Regular\'), url(https://fonts.gstatic.com/s/sourcesanspro/v10/ODelI1aHBYDBqgeIAH2zlBM0YzuT7MdOe03otPbuUS0.woff) format(\'woff\');\n            }\n\n            @font-face {\n                font-family: \'Source Sans Pro\';\n                font-style: normal;\n                font-weight: 700;\n                src: local(\'Source Sans Pro Bold\'), local(\'SourceSansPro-Bold\'), url(https://fonts.gstatic.com/s/sourcesanspro/v10/toadOcfmlt9b38dHJxOBGFkQc6VGVFSmCnC_l7QZG60.woff) format(\'woff\');\n            }\n        }\n\n        body,\n        table,\n        td,\n        a {\n            -ms-text-size-adjust: 100%;\n            /* 1 */\n            -webkit-text-size-adjust: 100%;\n            /* 2 */\n        }\n\n        img {\n            -ms-interpolation-mode: bicubic;\n        }\n\n        a[x-apple-data-detectors] {\n            font-family: inherit !important;\n            font-size: inherit !important;\n            font-weight: inherit !important;\n            line-height: inherit !important;\n            color: inherit !important;\n            text-decoration: none !important;\n        }\n\n        div[style*=\"margin: 16px 0;\"] {\n            margin: 0 !important;\n        }\n\n        body {\n            width: 100% !important;\n            height: 100% !important;\n            padding: 0 !important;\n            margin: 0 !important;\n            padding: 24px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 16px;\n            background-color: #f9fafc;\n            color: #60676d;\n        }\n\n        table {\n            border-collapse: collapse !important;\n        }\n\n        a {\n            color: #1a82e2;\n        }\n\n        img {\n            height: auto;\n            line-height: 100%;\n            text-decoration: none;\n            border: 0;\n            outline: none;\n        }\n\n        .table-1 {\n            max-width: 600px;\n        }\n\n        .table-1 td {\n            padding: 36px 24px 40px;\n            text-align: center;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-1 h1 {\n            margin: 0;\n            font-size: 32px;\n            font-weight: 600;\n            letter-spacing: -1px;\n            line-height: 48px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-2 {\n            max-width: 600px;\n        }\n\n        .table-2 td {\n            padding: 36px 24px 0;\n            border-top: 3px solid #d4dadf;\n            background-color: #ffffff;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-2 h1 {\n            margin: 0;\n            font-size: 20px;\n            font-weight: 600;\n            letter-spacing: -1px;\n            line-height: 48px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-3 {\n            max-width: 600px;\n        }\n\n        .table-2 td {\n\n            background-color: #ffffff;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .td-1 {\n            padding: 24px;\n            font-size: 16px;\n            line-height: 24px;\n            background-color: #ffffff;\n            text-align: left;\n            padding-bottom: 10px;\n            padding-top: 0px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-gray {\n            width: 100%;\n        }\n\n        .table-gray tr {\n            height: 24px;\n        }\n\n        .table-gray .td-1 {\n            background-color: #f1f3f7;\n            width: 30%;\n            border: solid 1px #e7e9ec;\n            padding-top: 5px;\n            padding-bottom: 5px;\n            font-size:16px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-gray .td-2 {\n            background-color: #f1f3f7;\n            width: 70%;\n            border: solid 1px #e7e9ec;\n            font-size:16px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .button, .button:active, .button:visited {\n            display: inline-block;\n            padding: 16px 36px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 16px;\n            color: #ffffff;\n            text-decoration: none;\n            border-radius: 6px;\n            background-color: #1a82e2;\n            border-radius: 6px;\n        }\n\n        .signature {\n            padding: 24px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 16px;\n            line-height: 24px;\n            border-bottom: 3px solid #d4dadf;\n            background-color: #ffffff;\n        }\n\n        .footer {\n            max-width: 600px;\n        }\n\n        .footer td {\n            padding: 12px 24px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 14px;\n            line-height: 20px;\n            color: #666;\n        }\n\n        .td-button {\n            padding: 12px;\n            background-color: #ffffff;\n            text-align: center;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .p-24 {\n            padding: 24px;\n        }\n    </style>\n\n</head>\n\n<body>\n<!-- start body -->\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start hero -->\n<tbody>\n<tr>\n<td align=\"center\">\n<table class=\"table-1\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td align=\"left\">\n<h1>Lead Status Update</h1>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end hero --> <!-- start hero -->\n<tr>\n<td align=\"center\">\n<table class=\"table-2\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td align=\"left\">\n<h1>Hi {first_name},</h1>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end hero --> <!-- start copy block -->\n<tr>\n<td align=\"center\">\n<table class=\"table-3\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start copy -->\n<tbody>\n<tr>\n<td class=\"td-1\">\n<p>The status of this lead has just been updated. The new status is shown below.</p>\n</td>\n</tr>\n<tr>\n<td class=\"td-1\">\n<table class=\"table-gray\" cellpadding=\"5\">\n<tbody>\n<tr>\n<td class=\"td-1\"><strong>Lead ID</strong></td>\n<td class=\"td-2\">{lead_id}</td>\n</tr>\n<tr>\n<td class=\"td-1\"><strong>Lead Title</strong></td>\n<td class=\"td-2\">{lead_title}</td>\n</tr>\n<tr>\n<td class=\"td-1\"><strong>Lead Name</strong></td>\n<td class=\"td-2\">{lead_name}</td>\n</tr>\n<tr>\n<td class=\"td-1\"><strong>Lead Status</strong></td>\n<td class=\"td-2\">{lead_status}</td>\n</tr>\n</tbody>\n</table>\n<p>You can manage your lead via the dashboard.</p>\n</td>\n</tr>\n<tr>\n<td align=\"left\" bgcolor=\"#ffffff\">\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td class=\"td-button\">\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td align=\"center\"><a class=\"button\" href=\"{lead_url}\" target=\"_blank\" rel=\"noopener\">Manage Lead</a></td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<tr>\n<td class=\"signature\">\n<p>{email_signature}</p>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end copy block --> <!-- start footer -->\n<tr>\n<td class=\"p-24\" align=\"center\">\n<table class=\"footer\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start permission -->\n<tbody>\n<tr>\n<td align=\"center\">\n<p>{email_footer}</p>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end footer --></tbody>\n</table>\n<!-- end body -->\n</body>\n\n</html>', '{first_name}, {last_name}, {lead_id}, {lead_name}, {lead_title}, {lead_description}, {lead_created_date}, {lead_value}, {lead_status}, {lead_category}, {lead_url}', '2019-12-08 17:13:10', '2020-11-12 12:42:09', 'enabled', 'english', 'yes', 'yes', 109),
(NULL, NULL, 'Lead Comment', 'template_lang_lead_comment', 'team', 'leads', 'New Lead Comment', '<!DOCTYPE html>\r\n<html>\r\n\r\n<head>\r\n\r\n    <meta charset=\"utf-8\">\r\n    <meta http-equiv=\"x-ua-compatible\" content=\"ie=edge\">\r\n    <title>Email Confirmation</title>\r\n    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">\r\n    <style type=\"text/css\">\r\n        @media screen {\r\n            @font-face {\r\n                font-family: \'Source Sans Pro\';\r\n                font-style: normal;\r\n                font-weight: 400;\r\n                src: local(\'Source Sans Pro Regular\'), local(\'SourceSansPro-Regular\'), url(https://fonts.gstatic.com/s/sourcesanspro/v10/ODelI1aHBYDBqgeIAH2zlBM0YzuT7MdOe03otPbuUS0.woff) format(\'woff\');\r\n            }\r\n\r\n            @font-face {\r\n                font-family: \'Source Sans Pro\';\r\n                font-style: normal;\r\n                font-weight: 700;\r\n                src: local(\'Source Sans Pro Bold\'), local(\'SourceSansPro-Bold\'), url(https://fonts.gstatic.com/s/sourcesanspro/v10/toadOcfmlt9b38dHJxOBGFkQc6VGVFSmCnC_l7QZG60.woff) format(\'woff\');\r\n            }\r\n        }\r\n\r\n        body,\r\n        table,\r\n        td,\r\n        a {\r\n            -ms-text-size-adjust: 100%;\r\n            /* 1 */\r\n            -webkit-text-size-adjust: 100%;\r\n            /* 2 */\r\n        }\r\n\r\n        img {\r\n            -ms-interpolation-mode: bicubic;\r\n        }\r\n\r\n        a[x-apple-data-detectors] {\r\n            font-family: inherit !important;\r\n            font-size: inherit !important;\r\n            font-weight: inherit !important;\r\n            line-height: inherit !important;\r\n            color: inherit !important;\r\n            text-decoration: none !important;\r\n        }\r\n\r\n        div[style*=\"margin: 16px 0;\"] {\r\n            margin: 0 !important;\r\n        }\r\n\r\n        body {\r\n            width: 100% !important;\r\n            height: 100% !important;\r\n            padding: 0 !important;\r\n            margin: 0 !important;\r\n            padding: 24px;\r\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\r\n            font-size: 16px;\r\n            background-color: #f9fafc;\r\n            color: #60676d;\r\n        }\r\n\r\n        table {\r\n            border-collapse: collapse !important;\r\n        }\r\n\r\n        a {\r\n            color: #1a82e2;\r\n        }\r\n\r\n        img {\r\n            height: auto;\r\n            line-height: 100%;\r\n            text-decoration: none;\r\n            border: 0;\r\n            outline: none;\r\n        }\r\n\r\n        .table-1 {\r\n            max-width: 600px;\r\n        }\r\n\r\n        .table-1 td {\r\n            padding: 36px 24px 40px;\r\n            text-align: center;\r\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\r\n        }\r\n\r\n        .table-1 h1 {\r\n            margin: 0;\r\n            font-size: 32px;\r\n            font-weight: 600;\r\n            letter-spacing: -1px;\r\n            line-height: 48px;\r\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\r\n        }\r\n\r\n        .table-2 {\r\n            max-width: 600px;\r\n        }\r\n\r\n        .table-2 td {\r\n            padding: 36px 24px 0;\r\n            border-top: 3px solid #d4dadf;\r\n            background-color: #ffffff;\r\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\r\n        }\r\n\r\n        .table-2 h1 {\r\n            margin: 0;\r\n            font-size: 20px;\r\n            font-weight: 600;\r\n            letter-spacing: -1px;\r\n            line-height: 48px;\r\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\r\n        }\r\n\r\n        .table-3 {\r\n            max-width: 600px;\r\n        }\r\n\r\n        .table-2 td {\r\n\r\n            background-color: #ffffff;\r\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\r\n        }\r\n\r\n        .td-1 {\r\n            padding: 24px;\r\n            font-size: 16px;\r\n            line-height: 24px;\r\n            background-color: #ffffff;\r\n            text-align: left;\r\n            padding-bottom: 10px;\r\n            padding-top: 0px;\r\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\r\n        }\r\n\r\n        .table-gray {\r\n            width: 100%;\r\n        }\r\n\r\n        .table-gray tr {\r\n            height: 24px;\r\n        }\r\n\r\n        .table-gray .td-1 {\r\n            background-color: #f1f3f7;\r\n            width: 30%;\r\n            border: solid 1px #e7e9ec;\r\n            padding-top: 5px;\r\n            padding-bottom: 5px;\r\n            font-size:16px;\r\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\r\n        }\r\n\r\n        .table-gray .td-2 {\r\n            background-color: #f1f3f7;\r\n            width: 70%;\r\n            border: solid 1px #e7e9ec;\r\n            font-size:16px;\r\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\r\n        }\r\n\r\n        .button, .button:active, .button:visited {\r\n            display: inline-block;\r\n            padding: 16px 36px;\r\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\r\n            font-size: 16px;\r\n            color: #ffffff;\r\n            text-decoration: none;\r\n            border-radius: 6px;\r\n            background-color: #1a82e2;\r\n            border-radius: 6px;\r\n        }\r\n\r\n        .signature {\r\n            padding: 24px;\r\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\r\n            font-size: 16px;\r\n            line-height: 24px;\r\n            border-bottom: 3px solid #d4dadf;\r\n            background-color: #ffffff;\r\n        }\r\n\r\n        .footer {\r\n            max-width: 600px;\r\n        }\r\n\r\n        .footer td {\r\n            padding: 12px 24px;\r\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\r\n            font-size: 14px;\r\n            line-height: 20px;\r\n            color: #666;\r\n        }\r\n\r\n        .td-button {\r\n            padding: 12px;\r\n            background-color: #ffffff;\r\n            text-align: center;\r\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\r\n        }\r\n\r\n        .p-24 {\r\n            padding: 24px;\r\n        }\r\n    </style>\r\n\r\n</head>\r\n\r\n<body>\r\n<!-- start body -->\r\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start hero -->\r\n<tbody>\r\n<tr>\r\n<td align=\"center\">\r\n<table class=\"table-1\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\r\n<tbody>\r\n<tr>\r\n<td align=\"left\">\r\n<h1>New Comment Posted</h1>\r\n</td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n</td>\r\n</tr>\r\n<!-- end hero --> <!-- start hero -->\r\n<tr>\r\n<td align=\"center\">\r\n<table class=\"table-2\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\r\n<tbody>\r\n<tr>\r\n<td align=\"left\">\r\n<h1>Hi {first_name},</h1>\r\n</td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n</td>\r\n</tr>\r\n<!-- end hero --> <!-- start copy block -->\r\n<tr>\r\n<td align=\"center\">\r\n<table class=\"table-3\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start copy -->\r\n<tbody>\r\n<tr>\r\n<td class=\"td-1\">\r\n<p>A new comment has been posted on this lead.</p>\r\n</td>\r\n</tr>\r\n<tr>\r\n<td class=\"td-1\">\r\n<table class=\"table-gray\" cellpadding=\"5\">\r\n<tbody>\r\n<tr>\r\n<td class=\"td-1\"><strong>Lead Title</strong></td>\r\n<td class=\"td-2\">{lead_title}</td>\r\n</tr>\r\n<tr>\r\n<td class=\"td-1\"><strong>Posted By</strong></td>\r\n<td class=\"td-2\">{poster_first_name}</td>\r\n</tr>\r\n<tr>\r\n<td class=\"td-1\" colspan=\"2\">{comment}</td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n<p>You can manage your lead via the dashboard.</p>\r\n</td>\r\n</tr>\r\n<tr>\r\n<td align=\"left\" bgcolor=\"#ffffff\">\r\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\r\n<tbody>\r\n<tr>\r\n<td class=\"td-button\">\r\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\r\n<tbody>\r\n<tr>\r\n<td align=\"center\"><a class=\"button\" href=\"{lead_url}\" target=\"_blank\" rel=\"noopener\">Manage Lead</a></td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n</td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n</td>\r\n</tr>\r\n<tr>\r\n<td class=\"signature\">\r\n<p>{email_signature}</p>\r\n</td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n</td>\r\n</tr>\r\n<!-- end copy block --> <!-- start footer -->\r\n<tr>\r\n<td class=\"p-24\" align=\"center\">\r\n<table class=\"footer\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start permission -->\r\n<tbody>\r\n<tr>\r\n<td align=\"center\">\r\n<p>{email_footer}</p>\r\n</td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n</td>\r\n</tr>\r\n<!-- end footer --></tbody>\r\n</table>\r\n<!-- end body -->\r\n</body>\r\n\r\n</html>', '{first_name}, {last_name}, {lead_id}, {lead_name}, {lead_description}, {comment}, {poster_first_name}, {poster_last_name}, {lead_title}, {lead_created_date}, {lead_value}, {lead_status}, {lead_category}, {lead_url}', '2019-12-08 17:13:10', '2020-11-21 19:22:27', 'enabled', 'english', 'yes', 'yes', 110),
(NULL, NULL, 'Lead Assignment', 'template_lang_lead_assignment', 'team', 'leads', 'New Lead Assignment', '<!DOCTYPE html>\n<html>\n\n<head>\n\n    <meta charset=\"utf-8\">\n    <meta http-equiv=\"x-ua-compatible\" content=\"ie=edge\">\n    <title>Email Confirmation</title>\n    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">\n    <style type=\"text/css\">\n        @media screen {\n            @font-face {\n                font-family: \'Source Sans Pro\';\n                font-style: normal;\n                font-weight: 400;\n                src: local(\'Source Sans Pro Regular\'), local(\'SourceSansPro-Regular\'), url(https://fonts.gstatic.com/s/sourcesanspro/v10/ODelI1aHBYDBqgeIAH2zlBM0YzuT7MdOe03otPbuUS0.woff) format(\'woff\');\n            }\n\n            @font-face {\n                font-family: \'Source Sans Pro\';\n                font-style: normal;\n                font-weight: 700;\n                src: local(\'Source Sans Pro Bold\'), local(\'SourceSansPro-Bold\'), url(https://fonts.gstatic.com/s/sourcesanspro/v10/toadOcfmlt9b38dHJxOBGFkQc6VGVFSmCnC_l7QZG60.woff) format(\'woff\');\n            }\n        }\n\n        body,\n        table,\n        td,\n        a {\n            -ms-text-size-adjust: 100%;\n            /* 1 */\n            -webkit-text-size-adjust: 100%;\n            /* 2 */\n        }\n\n        img {\n            -ms-interpolation-mode: bicubic;\n        }\n\n        a[x-apple-data-detectors] {\n            font-family: inherit !important;\n            font-size: inherit !important;\n            font-weight: inherit !important;\n            line-height: inherit !important;\n            color: inherit !important;\n            text-decoration: none !important;\n        }\n\n        div[style*=\"margin: 16px 0;\"] {\n            margin: 0 !important;\n        }\n\n        body {\n            width: 100% !important;\n            height: 100% !important;\n            padding: 0 !important;\n            margin: 0 !important;\n            padding: 24px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 16px;\n            background-color: #f9fafc;\n            color: #60676d;\n        }\n\n        table {\n            border-collapse: collapse !important;\n        }\n\n        a {\n            color: #1a82e2;\n        }\n\n        img {\n            height: auto;\n            line-height: 100%;\n            text-decoration: none;\n            border: 0;\n            outline: none;\n        }\n\n        .table-1 {\n            max-width: 600px;\n        }\n\n        .table-1 td {\n            padding: 36px 24px 40px;\n            text-align: center;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-1 h1 {\n            margin: 0;\n            font-size: 32px;\n            font-weight: 600;\n            letter-spacing: -1px;\n            line-height: 48px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-2 {\n            max-width: 600px;\n        }\n\n        .table-2 td {\n            padding: 36px 24px 0;\n            border-top: 3px solid #d4dadf;\n            background-color: #ffffff;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-2 h1 {\n            margin: 0;\n            font-size: 20px;\n            font-weight: 600;\n            letter-spacing: -1px;\n            line-height: 48px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-3 {\n            max-width: 600px;\n        }\n\n        .table-2 td {\n\n            background-color: #ffffff;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .td-1 {\n            padding: 24px;\n            font-size: 16px;\n            line-height: 24px;\n            background-color: #ffffff;\n            text-align: left;\n            padding-bottom: 10px;\n            padding-top: 0px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-gray {\n            width: 100%;\n        }\n\n        .table-gray tr {\n            height: 24px;\n        }\n\n        .table-gray .td-1 {\n            background-color: #f1f3f7;\n            width: 30%;\n            border: solid 1px #e7e9ec;\n            padding-top: 5px;\n            padding-bottom: 5px;\n            font-size:16px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-gray .td-2 {\n            background-color: #f1f3f7;\n            width: 70%;\n            border: solid 1px #e7e9ec;\n            font-size:16px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .button, .button:active, .button:visited {\n            display: inline-block;\n            padding: 16px 36px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 16px;\n            color: #ffffff;\n            text-decoration: none;\n            border-radius: 6px;\n            background-color: #1a82e2;\n            border-radius: 6px;\n        }\n\n        .signature {\n            padding: 24px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 16px;\n            line-height: 24px;\n            border-bottom: 3px solid #d4dadf;\n            background-color: #ffffff;\n        }\n\n        .footer {\n            max-width: 600px;\n        }\n\n        .footer td {\n            padding: 12px 24px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 14px;\n            line-height: 20px;\n            color: #666;\n        }\n\n        .td-button {\n            padding: 12px;\n            background-color: #ffffff;\n            text-align: center;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .p-24 {\n            padding: 24px;\n        }\n    </style>\n\n</head>\n\n<body>\n<!-- start body -->\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start hero -->\n<tbody>\n<tr>\n<td align=\"center\">\n<table class=\"table-1\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td align=\"left\">\n<h1>Lead Assignment</h1>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end hero --> <!-- start hero -->\n<tr>\n<td align=\"center\">\n<table class=\"table-2\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td align=\"left\">\n<h1>Hi {first_name},</h1>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end hero --> <!-- start copy block -->\n<tr>\n<td align=\"center\">\n<table class=\"table-3\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start copy -->\n<tbody>\n<tr>\n<td class=\"td-1\">\n<p>You have just been assigned to a lead.</p>\n</td>\n</tr>\n<tr>\n<td class=\"td-1\">\n<table class=\"table-gray\" cellpadding=\"5\">\n<tbody>\n<tr>\n<td class=\"td-1\"><strong>Lead Name</strong></td>\n<td class=\"td-2\">{lead_name}</td>\n</tr>\n<tr>\n<td class=\"td-1\"><strong>Lead Title</strong></td>\n<td class=\"td-2\">{lead_title}</td>\n</tr>\n</tbody>\n</table>\n<p>You can manage your project via the dashboard.</p>\n</td>\n</tr>\n<tr>\n<td align=\"left\" bgcolor=\"#ffffff\">\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td class=\"td-button\">\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td align=\"center\"><a class=\"button\" href=\"{lead_url}\" target=\"_blank\" rel=\"noopener\">Manage Lead</a></td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<tr>\n<td class=\"signature\">\n<p>{email_signature}</p>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end copy block --> <!-- start footer -->\n<tr>\n<td class=\"p-24\" align=\"center\">\n<table class=\"footer\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start permission -->\n<tbody>\n<tr>\n<td align=\"center\">\n<p>{email_footer}</p>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end footer --></tbody>\n</table>\n<!-- end body -->\n</body>\n\n</html>', '{first_name}, {last_name}, {assigned_by_first_name}, {assigned_by_last_name}, {lead_id}, {lead_name}, {lead_description}, {lead_title}, {lead_created_date}, {lead_value}, {lead_status}, {lead_category}, {lead_url}', '2019-12-08 17:13:10', '2020-11-12 12:44:45', 'enabled', 'english', 'yes', 'yes', 111);
INSERT INTO `email_templates` (`emailtemplate_module_unique_id`, `emailtemplate_module_name`, `emailtemplate_name`, `emailtemplate_lang`, `emailtemplate_type`, `emailtemplate_category`, `emailtemplate_subject`, `emailtemplate_body`, `emailtemplate_variables`, `emailtemplate_created`, `emailtemplate_updated`, `emailtemplate_status`, `emailtemplate_language`, `emailtemplate_real_template`, `emailtemplate_show_enabled`, `emailtemplate_id`) VALUES
(NULL, NULL, 'Lead File Uploaded', 'template_lang_lead_file_upload', 'team', 'leads', 'New Lead File Uploaded', '<!DOCTYPE html>\n<html>\n\n<head>\n\n    <meta charset=\"utf-8\">\n    <meta http-equiv=\"x-ua-compatible\" content=\"ie=edge\">\n    <title>Email Confirmation</title>\n    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">\n    <style type=\"text/css\">\n        @media screen {\n            @font-face {\n                font-family: \'Source Sans Pro\';\n                font-style: normal;\n                font-weight: 400;\n                src: local(\'Source Sans Pro Regular\'), local(\'SourceSansPro-Regular\'), url(https://fonts.gstatic.com/s/sourcesanspro/v10/ODelI1aHBYDBqgeIAH2zlBM0YzuT7MdOe03otPbuUS0.woff) format(\'woff\');\n            }\n\n            @font-face {\n                font-family: \'Source Sans Pro\';\n                font-style: normal;\n                font-weight: 700;\n                src: local(\'Source Sans Pro Bold\'), local(\'SourceSansPro-Bold\'), url(https://fonts.gstatic.com/s/sourcesanspro/v10/toadOcfmlt9b38dHJxOBGFkQc6VGVFSmCnC_l7QZG60.woff) format(\'woff\');\n            }\n        }\n\n        body,\n        table,\n        td,\n        a {\n            -ms-text-size-adjust: 100%;\n            /* 1 */\n            -webkit-text-size-adjust: 100%;\n            /* 2 */\n        }\n\n        img {\n            -ms-interpolation-mode: bicubic;\n        }\n\n        a[x-apple-data-detectors] {\n            font-family: inherit !important;\n            font-size: inherit !important;\n            font-weight: inherit !important;\n            line-height: inherit !important;\n            color: inherit !important;\n            text-decoration: none !important;\n        }\n\n        div[style*=\"margin: 16px 0;\"] {\n            margin: 0 !important;\n        }\n\n        body {\n            width: 100% !important;\n            height: 100% !important;\n            padding: 0 !important;\n            margin: 0 !important;\n            padding: 24px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 16px;\n            background-color: #f9fafc;\n            color: #60676d;\n        }\n\n        table {\n            border-collapse: collapse !important;\n        }\n\n        a {\n            color: #1a82e2;\n        }\n\n        img {\n            height: auto;\n            line-height: 100%;\n            text-decoration: none;\n            border: 0;\n            outline: none;\n        }\n\n        .table-1 {\n            max-width: 600px;\n        }\n\n        .table-1 td {\n            padding: 36px 24px 40px;\n            text-align: center;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-1 h1 {\n            margin: 0;\n            font-size: 32px;\n            font-weight: 600;\n            letter-spacing: -1px;\n            line-height: 48px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-2 {\n            max-width: 600px;\n        }\n\n        .table-2 td {\n            padding: 36px 24px 0;\n            border-top: 3px solid #d4dadf;\n            background-color: #ffffff;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-2 h1 {\n            margin: 0;\n            font-size: 20px;\n            font-weight: 600;\n            letter-spacing: -1px;\n            line-height: 48px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-3 {\n            max-width: 600px;\n        }\n\n        .table-2 td {\n\n            background-color: #ffffff;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .td-1 {\n            padding: 24px;\n            font-size: 16px;\n            line-height: 24px;\n            background-color: #ffffff;\n            text-align: left;\n            padding-bottom: 10px;\n            padding-top: 0px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-gray {\n            width: 100%;\n        }\n\n        .table-gray tr {\n            height: 24px;\n        }\n\n        .table-gray .td-1 {\n            background-color: #f1f3f7;\n            width: 30%;\n            border: solid 1px #e7e9ec;\n            padding-top: 5px;\n            padding-bottom: 5px;\n            font-size:16px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-gray .td-2 {\n            background-color: #f1f3f7;\n            width: 70%;\n            border: solid 1px #e7e9ec;\n            font-size:16px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .button, .button:active, .button:visited {\n            display: inline-block;\n            padding: 16px 36px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 16px;\n            color: #ffffff;\n            text-decoration: none;\n            border-radius: 6px;\n            background-color: #1a82e2;\n            border-radius: 6px;\n        }\n\n        .signature {\n            padding: 24px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 16px;\n            line-height: 24px;\n            border-bottom: 3px solid #d4dadf;\n            background-color: #ffffff;\n        }\n\n        .footer {\n            max-width: 600px;\n        }\n\n        .footer td {\n            padding: 12px 24px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 14px;\n            line-height: 20px;\n            color: #666;\n        }\n\n        .td-button {\n            padding: 12px;\n            background-color: #ffffff;\n            text-align: center;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .p-24 {\n            padding: 24px;\n        }\n    </style>\n\n</head>\n\n<body>\n<!-- start body -->\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start hero -->\n<tbody>\n<tr>\n<td align=\"center\">\n<table class=\"table-1\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td align=\"left\">\n<h1>New File Added</h1>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end hero --> <!-- start hero -->\n<tr>\n<td align=\"center\">\n<table class=\"table-2\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td align=\"left\">\n<h1>Hi {first_name},</h1>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end hero --> <!-- start copy block -->\n<tr>\n<td align=\"center\">\n<table class=\"table-3\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start copy -->\n<tbody>\n<tr>\n<td class=\"td-1\">\n<p>A new file has just been attached to this lead.</p>\n</td>\n</tr>\n<tr>\n<td class=\"td-1\">\n<table class=\"table-gray\" cellpadding=\"5\">\n<tbody>\n<tr>\n<td class=\"td-1\"><strong>Lead Name</strong></td>\n<td class=\"td-2\">{lead_name}</td>\n</tr>\n<tr>\n<td class=\"td-1\"><strong>Lead Title</strong></td>\n<td class=\"td-2\">{lead_title}</td>\n</tr>\n<tr>\n<td class=\"td-1\"><strong>File</strong></td>\n<td class=\"td-2\"><a href=\"{file_url}\">{file_name}</a></td>\n</tr>\n<tr>\n<td class=\"td-1\"><strong>Uploaded By</strong></td>\n<td class=\"td-2\">{uploader_first_name}</td>\n</tr>\n</tbody>\n</table>\n<p>You can manage your lead via the dashboard.</p>\n</td>\n</tr>\n<tr>\n<td align=\"left\" bgcolor=\"#ffffff\">\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td class=\"td-button\">\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td align=\"center\"><a class=\"button\" href=\"{lead_url}\" target=\"_blank\" rel=\"noopener\">Manage Lead</a></td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<tr>\n<td class=\"signature\">\n<p>{email_signature}</p>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end copy block --> <!-- start footer -->\n<tr>\n<td class=\"p-24\" align=\"center\">\n<table class=\"footer\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start permission -->\n<tbody>\n<tr>\n<td align=\"center\">\n<p>{email_footer}</p>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end footer --></tbody>\n</table>\n<!-- end body -->\n</body>\n\n</html>', '{first_name}, {last_name}, {file_name}, {file_size}, {file_extension}, {file_url}, {uploader_first_name}, {uploader_last_name}, {lead_id}, {lead_name}, {lead_description}, {lead_title}, {lead_created_date}, {lead_value}, {lead_status}, {lead_category}, {lead_url}', '2019-12-08 17:13:10', '2020-11-12 12:46:56', 'enabled', 'english', 'yes', 'yes', 112),
(NULL, NULL, 'Task Status Change', 'template_lang_task_status_change', 'everyone', 'tasks', 'Task Status Has Changed', '<!DOCTYPE html>\n<html>\n\n<head>\n\n    <meta charset=\"utf-8\">\n    <meta http-equiv=\"x-ua-compatible\" content=\"ie=edge\">\n    <title>Email Confirmation</title>\n    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">\n    <style type=\"text/css\">\n        @media screen {\n            @font-face {\n                font-family: \'Source Sans Pro\';\n                font-style: normal;\n                font-weight: 400;\n                src: local(\'Source Sans Pro Regular\'), local(\'SourceSansPro-Regular\'), url(https://fonts.gstatic.com/s/sourcesanspro/v10/ODelI1aHBYDBqgeIAH2zlBM0YzuT7MdOe03otPbuUS0.woff) format(\'woff\');\n            }\n\n            @font-face {\n                font-family: \'Source Sans Pro\';\n                font-style: normal;\n                font-weight: 700;\n                src: local(\'Source Sans Pro Bold\'), local(\'SourceSansPro-Bold\'), url(https://fonts.gstatic.com/s/sourcesanspro/v10/toadOcfmlt9b38dHJxOBGFkQc6VGVFSmCnC_l7QZG60.woff) format(\'woff\');\n            }\n        }\n\n        body,\n        table,\n        td,\n        a {\n            -ms-text-size-adjust: 100%;\n            /* 1 */\n            -webkit-text-size-adjust: 100%;\n            /* 2 */\n        }\n\n        img {\n            -ms-interpolation-mode: bicubic;\n        }\n\n        a[x-apple-data-detectors] {\n            font-family: inherit !important;\n            font-size: inherit !important;\n            font-weight: inherit !important;\n            line-height: inherit !important;\n            color: inherit !important;\n            text-decoration: none !important;\n        }\n\n        div[style*=\"margin: 16px 0;\"] {\n            margin: 0 !important;\n        }\n\n        body {\n            width: 100% !important;\n            height: 100% !important;\n            padding: 0 !important;\n            margin: 0 !important;\n            padding: 24px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 16px;\n            background-color: #f9fafc;\n            color: #60676d;\n        }\n\n        table {\n            border-collapse: collapse !important;\n        }\n\n        a {\n            color: #1a82e2;\n        }\n\n        img {\n            height: auto;\n            line-height: 100%;\n            text-decoration: none;\n            border: 0;\n            outline: none;\n        }\n\n        .table-1 {\n            max-width: 600px;\n        }\n\n        .table-1 td {\n            padding: 36px 24px 40px;\n            text-align: center;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-1 h1 {\n            margin: 0;\n            font-size: 32px;\n            font-weight: 600;\n            letter-spacing: -1px;\n            line-height: 48px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-2 {\n            max-width: 600px;\n        }\n\n        .table-2 td {\n            padding: 36px 24px 0;\n            border-top: 3px solid #d4dadf;\n            background-color: #ffffff;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-2 h1 {\n            margin: 0;\n            font-size: 20px;\n            font-weight: 600;\n            letter-spacing: -1px;\n            line-height: 48px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-3 {\n            max-width: 600px;\n        }\n\n        .table-2 td {\n\n            background-color: #ffffff;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .td-1 {\n            padding: 24px;\n            font-size: 16px;\n            line-height: 24px;\n            background-color: #ffffff;\n            text-align: left;\n            padding-bottom: 10px;\n            padding-top: 0px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-gray {\n            width: 100%;\n        }\n\n        .table-gray tr {\n            height: 24px;\n        }\n\n        .table-gray .td-1 {\n            background-color: #f1f3f7;\n            width: 30%;\n            border: solid 1px #e7e9ec;\n            padding-top: 5px;\n            padding-bottom: 5px;\n            font-size:16px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-gray .td-2 {\n            background-color: #f1f3f7;\n            width: 70%;\n            border: solid 1px #e7e9ec;\n            font-size:16px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .button, .button:active, .button:visited {\n            display: inline-block;\n            padding: 16px 36px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 16px;\n            color: #ffffff;\n            text-decoration: none;\n            border-radius: 6px;\n            background-color: #1a82e2;\n            border-radius: 6px;\n        }\n\n        .signature {\n            padding: 24px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 16px;\n            line-height: 24px;\n            border-bottom: 3px solid #d4dadf;\n            background-color: #ffffff;\n        }\n\n        .footer {\n            max-width: 600px;\n        }\n\n        .footer td {\n            padding: 12px 24px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 14px;\n            line-height: 20px;\n            color: #666;\n        }\n\n        .td-button {\n            padding: 12px;\n            background-color: #ffffff;\n            text-align: center;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .p-24 {\n            padding: 24px;\n        }\n    </style>\n\n</head>\n\n<body>\n<!-- start body -->\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start hero -->\n<tbody>\n<tr>\n<td align=\"center\">\n<table class=\"table-1\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td align=\"left\">\n<h1>Task Status Update</h1>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end hero --> <!-- start hero -->\n<tr>\n<td align=\"center\">\n<table class=\"table-2\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td align=\"left\">\n<h1>Hi {first_name},</h1>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end hero --> <!-- start copy block -->\n<tr>\n<td align=\"center\">\n<table class=\"table-3\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start copy -->\n<tbody>\n<tr>\n<td class=\"td-1\">\n<p>The status of this task has just been updated. The new status is shown below.</p>\n</td>\n</tr>\n<tr>\n<td class=\"td-1\">\n<table class=\"table-gray\" cellpadding=\"5\">\n<tbody>\n<tr>\n<td class=\"td-1\"><strong>Task Title</strong></td>\n<td class=\"td-2\">{task_title}</td>\n</tr>\n<tr>\n<td class=\"td-1\"><strong>Project Title</strong></td>\n<td class=\"td-2\">{project_title}</td>\n</tr>\n<tr>\n<td class=\"td-1\"><strong>Status</strong></td>\n<td class=\"td-2\">{task_status}</td>\n</tr>\n</tbody>\n</table>\n<p>You can manage your task via the dashboard.</p>\n</td>\n</tr>\n<tr>\n<td align=\"left\" bgcolor=\"#ffffff\">\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td class=\"td-button\">\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td align=\"center\"><a class=\"button\" href=\"{task_url}\" target=\"_blank\" rel=\"noopener\">View Task</a></td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<tr>\n<td class=\"signature\">\n<p>{email_signature}</p>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end copy block --> <!-- start footer -->\n<tr>\n<td class=\"p-24\" align=\"center\">\n<table class=\"footer\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start permission -->\n<tbody>\n<tr>\n<td align=\"center\">\n<p>{email_footer}</p>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end footer --></tbody>\n</table>\n<!-- end body -->\n</body>\n\n</html>', '{first_name}, {last_name}, {task_id}, {task_title}, {task_created_date}, {task_date_start}, {task_description}, {task_date_due}, {project_title}, {project_id}, {client_name}, {client_id}, {task_status}, {task_milestone}, {task_url}', '2019-12-08 17:13:10', '2020-11-13 08:15:19', 'enabled', 'english', 'yes', 'yes', 113),
(NULL, NULL, 'Task Assignment', 'template_lang_task_assignment', 'everyone', 'tasks', 'New Task Assignment', '<!DOCTYPE html>\n<html>\n\n<head>\n\n    <meta charset=\"utf-8\">\n    <meta http-equiv=\"x-ua-compatible\" content=\"ie=edge\">\n    <title>Email Confirmation</title>\n    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">\n    <style type=\"text/css\">\n        @media screen {\n            @font-face {\n                font-family: \'Source Sans Pro\';\n                font-style: normal;\n                font-weight: 400;\n                src: local(\'Source Sans Pro Regular\'), local(\'SourceSansPro-Regular\'), url(https://fonts.gstatic.com/s/sourcesanspro/v10/ODelI1aHBYDBqgeIAH2zlBM0YzuT7MdOe03otPbuUS0.woff) format(\'woff\');\n            }\n\n            @font-face {\n                font-family: \'Source Sans Pro\';\n                font-style: normal;\n                font-weight: 700;\n                src: local(\'Source Sans Pro Bold\'), local(\'SourceSansPro-Bold\'), url(https://fonts.gstatic.com/s/sourcesanspro/v10/toadOcfmlt9b38dHJxOBGFkQc6VGVFSmCnC_l7QZG60.woff) format(\'woff\');\n            }\n        }\n\n        body,\n        table,\n        td,\n        a {\n            -ms-text-size-adjust: 100%;\n            /* 1 */\n            -webkit-text-size-adjust: 100%;\n            /* 2 */\n        }\n\n        img {\n            -ms-interpolation-mode: bicubic;\n        }\n\n        a[x-apple-data-detectors] {\n            font-family: inherit !important;\n            font-size: inherit !important;\n            font-weight: inherit !important;\n            line-height: inherit !important;\n            color: inherit !important;\n            text-decoration: none !important;\n        }\n\n        div[style*=\"margin: 16px 0;\"] {\n            margin: 0 !important;\n        }\n\n        body {\n            width: 100% !important;\n            height: 100% !important;\n            padding: 0 !important;\n            margin: 0 !important;\n            padding: 24px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 16px;\n            background-color: #f9fafc;\n            color: #60676d;\n        }\n\n        table {\n            border-collapse: collapse !important;\n        }\n\n        a {\n            color: #1a82e2;\n        }\n\n        img {\n            height: auto;\n            line-height: 100%;\n            text-decoration: none;\n            border: 0;\n            outline: none;\n        }\n\n        .table-1 {\n            max-width: 600px;\n        }\n\n        .table-1 td {\n            padding: 36px 24px 40px;\n            text-align: center;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-1 h1 {\n            margin: 0;\n            font-size: 32px;\n            font-weight: 600;\n            letter-spacing: -1px;\n            line-height: 48px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-2 {\n            max-width: 600px;\n        }\n\n        .table-2 td {\n            padding: 36px 24px 0;\n            border-top: 3px solid #d4dadf;\n            background-color: #ffffff;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-2 h1 {\n            margin: 0;\n            font-size: 20px;\n            font-weight: 600;\n            letter-spacing: -1px;\n            line-height: 48px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-3 {\n            max-width: 600px;\n        }\n\n        .table-2 td {\n\n            background-color: #ffffff;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .td-1 {\n            padding: 24px;\n            font-size: 16px;\n            line-height: 24px;\n            background-color: #ffffff;\n            text-align: left;\n            padding-bottom: 10px;\n            padding-top: 0px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-gray {\n            width: 100%;\n        }\n\n        .table-gray tr {\n            height: 24px;\n        }\n\n        .table-gray .td-1 {\n            background-color: #f1f3f7;\n            width: 30%;\n            border: solid 1px #e7e9ec;\n            padding-top: 5px;\n            padding-bottom: 5px;\n            font-size:16px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-gray .td-2 {\n            background-color: #f1f3f7;\n            width: 70%;\n            border: solid 1px #e7e9ec;\n            font-size:16px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .button, .button:active, .button:visited {\n            display: inline-block;\n            padding: 16px 36px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 16px;\n            color: #ffffff;\n            text-decoration: none;\n            border-radius: 6px;\n            background-color: #1a82e2;\n            border-radius: 6px;\n        }\n\n        .signature {\n            padding: 24px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 16px;\n            line-height: 24px;\n            border-bottom: 3px solid #d4dadf;\n            background-color: #ffffff;\n        }\n\n        .footer {\n            max-width: 600px;\n        }\n\n        .footer td {\n            padding: 12px 24px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 14px;\n            line-height: 20px;\n            color: #666;\n        }\n\n        .td-button {\n            padding: 12px;\n            background-color: #ffffff;\n            text-align: center;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .p-24 {\n            padding: 24px;\n        }\n    </style>\n\n</head>\n\n<body>\n<!-- start body -->\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start hero -->\n<tbody>\n<tr>\n<td align=\"center\">\n<table class=\"table-1\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td align=\"left\">\n<h1>Task Assignment</h1>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end hero --> <!-- start hero -->\n<tr>\n<td align=\"center\">\n<table class=\"table-2\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td align=\"left\">\n<h1>Hi {first_name},</h1>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end hero --> <!-- start copy block -->\n<tr>\n<td align=\"center\">\n<table class=\"table-3\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start copy -->\n<tbody>\n<tr>\n<td class=\"td-1\">\n<p>You have just been assigned to a task.</p>\n</td>\n</tr>\n<tr>\n<td class=\"td-1\">\n<table class=\"table-gray\" cellpadding=\"5\">\n<tbody>\n<tr>\n<td class=\"td-1\"><strong>Task Title</strong></td>\n<td class=\"td-2\">{task_title}</td>\n</tr>\n<tr>\n<td class=\"td-1\"><strong>Project Title</strong></td>\n<td class=\"td-2\">{project_title}</td>\n</tr>\n<tr>\n<td class=\"td-1\"><strong>Due Date</strong></td>\n<td class=\"td-2\">{task_date_due}</td>\n</tr>\n</tbody>\n</table>\n<p>You can manage your task via the dashboard.</p>\n</td>\n</tr>\n<tr>\n<td align=\"left\" bgcolor=\"#ffffff\">\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td class=\"td-button\">\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td align=\"center\"><a class=\"button\" href=\"{task_url}\" target=\"_blank\" rel=\"noopener\">Manage Task</a></td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<tr>\n<td class=\"signature\">\n<p>{email_signature}</p>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end copy block --> <!-- start footer -->\n<tr>\n<td class=\"p-24\" align=\"center\">\n<table class=\"footer\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start permission -->\n<tbody>\n<tr>\n<td align=\"center\">\n<p>{email_footer}</p>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end footer --></tbody>\n</table>\n<!-- end body -->\n</body>\n\n</html>', '{first_name}, {last_name}, {assigned_by_first_name}, {assigned_by_last_name}, {task_id}, {task_title}, {task_created_date}, {task_date_start}, {task_description}, {task_date_due}, {project_title}, {project_id}, {client_name}, {client_id}, {task_status}, {task_milestone}, {task_url}', '2019-12-08 17:13:10', '2020-11-12 12:50:42', 'enabled', 'english', 'yes', 'yes', 115),
(NULL, NULL, 'Task File Uploaded', 'template_lang_task_file_uploaded', 'everyone', 'tasks', 'New Task File Uploaded', '<!DOCTYPE html>\n<html>\n\n<head>\n\n    <meta charset=\"utf-8\">\n    <meta http-equiv=\"x-ua-compatible\" content=\"ie=edge\">\n    <title>Email Confirmation</title>\n    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">\n    <style type=\"text/css\">\n        @media screen {\n            @font-face {\n                font-family: \'Source Sans Pro\';\n                font-style: normal;\n                font-weight: 400;\n                src: local(\'Source Sans Pro Regular\'), local(\'SourceSansPro-Regular\'), url(https://fonts.gstatic.com/s/sourcesanspro/v10/ODelI1aHBYDBqgeIAH2zlBM0YzuT7MdOe03otPbuUS0.woff) format(\'woff\');\n            }\n\n            @font-face {\n                font-family: \'Source Sans Pro\';\n                font-style: normal;\n                font-weight: 700;\n                src: local(\'Source Sans Pro Bold\'), local(\'SourceSansPro-Bold\'), url(https://fonts.gstatic.com/s/sourcesanspro/v10/toadOcfmlt9b38dHJxOBGFkQc6VGVFSmCnC_l7QZG60.woff) format(\'woff\');\n            }\n        }\n\n        body,\n        table,\n        td,\n        a {\n            -ms-text-size-adjust: 100%;\n            /* 1 */\n            -webkit-text-size-adjust: 100%;\n            /* 2 */\n        }\n\n        img {\n            -ms-interpolation-mode: bicubic;\n        }\n\n        a[x-apple-data-detectors] {\n            font-family: inherit !important;\n            font-size: inherit !important;\n            font-weight: inherit !important;\n            line-height: inherit !important;\n            color: inherit !important;\n            text-decoration: none !important;\n        }\n\n        div[style*=\"margin: 16px 0;\"] {\n            margin: 0 !important;\n        }\n\n        body {\n            width: 100% !important;\n            height: 100% !important;\n            padding: 0 !important;\n            margin: 0 !important;\n            padding: 24px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 16px;\n            background-color: #f9fafc;\n            color: #60676d;\n        }\n\n        table {\n            border-collapse: collapse !important;\n        }\n\n        a {\n            color: #1a82e2;\n        }\n\n        img {\n            height: auto;\n            line-height: 100%;\n            text-decoration: none;\n            border: 0;\n            outline: none;\n        }\n\n        .table-1 {\n            max-width: 600px;\n        }\n\n        .table-1 td {\n            padding: 36px 24px 40px;\n            text-align: center;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-1 h1 {\n            margin: 0;\n            font-size: 32px;\n            font-weight: 600;\n            letter-spacing: -1px;\n            line-height: 48px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-2 {\n            max-width: 600px;\n        }\n\n        .table-2 td {\n            padding: 36px 24px 0;\n            border-top: 3px solid #d4dadf;\n            background-color: #ffffff;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-2 h1 {\n            margin: 0;\n            font-size: 20px;\n            font-weight: 600;\n            letter-spacing: -1px;\n            line-height: 48px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-3 {\n            max-width: 600px;\n        }\n\n        .table-2 td {\n\n            background-color: #ffffff;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .td-1 {\n            padding: 24px;\n            font-size: 16px;\n            line-height: 24px;\n            background-color: #ffffff;\n            text-align: left;\n            padding-bottom: 10px;\n            padding-top: 0px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-gray {\n            width: 100%;\n        }\n\n        .table-gray tr {\n            height: 24px;\n        }\n\n        .table-gray .td-1 {\n            background-color: #f1f3f7;\n            width: 30%;\n            border: solid 1px #e7e9ec;\n            padding-top: 5px;\n            padding-bottom: 5px;\n            font-size:16px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-gray .td-2 {\n            background-color: #f1f3f7;\n            width: 70%;\n            border: solid 1px #e7e9ec;\n            font-size:16px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .button, .button:active, .button:visited {\n            display: inline-block;\n            padding: 16px 36px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 16px;\n            color: #ffffff;\n            text-decoration: none;\n            border-radius: 6px;\n            background-color: #1a82e2;\n            border-radius: 6px;\n        }\n\n        .signature {\n            padding: 24px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 16px;\n            line-height: 24px;\n            border-bottom: 3px solid #d4dadf;\n            background-color: #ffffff;\n        }\n\n        .footer {\n            max-width: 600px;\n        }\n\n        .footer td {\n            padding: 12px 24px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 14px;\n            line-height: 20px;\n            color: #666;\n        }\n\n        .td-button {\n            padding: 12px;\n            background-color: #ffffff;\n            text-align: center;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .p-24 {\n            padding: 24px;\n        }\n    </style>\n\n</head>\n\n<body>\n<!-- start body -->\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start hero -->\n<tbody>\n<tr>\n<td align=\"center\">\n<table class=\"table-1\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td align=\"left\">\n<h1>New File Added</h1>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end hero --> <!-- start hero -->\n<tr>\n<td align=\"center\">\n<table class=\"table-2\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td align=\"left\">\n<h1>Hi {first_name},</h1>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end hero --> <!-- start copy block -->\n<tr>\n<td align=\"center\">\n<table class=\"table-3\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start copy -->\n<tbody>\n<tr>\n<td class=\"td-1\">\n<p>A new file has just been attached to this task.</p>\n</td>\n</tr>\n<tr>\n<td class=\"td-1\">\n<table class=\"table-gray\" cellpadding=\"5\">\n<tbody>\n<tr>\n<td class=\"td-1\"><strong>Task Title</strong></td>\n<td class=\"td-2\">{task_title}</td>\n</tr>\n<tr>\n<td class=\"td-1\"><strong>Project Title</strong></td>\n<td class=\"td-2\">{project_title}</td>\n</tr>\n<tr>\n<td class=\"td-1\"><strong>File</strong></td>\n<td class=\"td-2\"><a href=\"{file_url}\">{file_name}</a></td>\n</tr>\n<tr>\n<td class=\"td-1\"><strong>Uploaded By</strong></td>\n<td class=\"td-2\">{uploader_first_name}</td>\n</tr>\n</tbody>\n</table>\n<p>You can manage your task via the dashboard.</p>\n</td>\n</tr>\n<tr>\n<td align=\"left\" bgcolor=\"#ffffff\">\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td class=\"td-button\">\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td align=\"center\"><a class=\"button\" href=\"{task_url}\" target=\"_blank\" rel=\"noopener\">Manage Task</a></td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<tr>\n<td class=\"signature\">\n<p>{email_signature}</p>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end copy block --> <!-- start footer -->\n<tr>\n<td class=\"p-24\" align=\"center\">\n<table class=\"footer\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start permission -->\n<tbody>\n<tr>\n<td align=\"center\">\n<p>{email_footer}</p>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end footer --></tbody>\n</table>\n<!-- end body -->\n</body>\n\n</html>', '{first_name}, {last_name}, {file_name}, {file_size}, {file_extension}, {file_url}, {uploader_first_name}, {uploader_last_name}, {task_id}, {task_title}, {task_created_date}, {task_date_start}, {task_description}, {task_date_due}, {project_title}, {project_id}, {client_name}, {client_id}, {task_status}, {task_milestone}, {task_url}', '2019-12-08 17:13:10', '2020-11-12 12:53:03', 'enabled', 'english', 'yes', 'yes', 116),
(NULL, NULL, 'New Invoice', 'template_lang_new_invoice', 'client', 'billing', 'New Invoice - #{invoice_id}', '<!DOCTYPE html>\n<html>\n\n<head>\n\n    <meta charset=\"utf-8\">\n    <meta http-equiv=\"x-ua-compatible\" content=\"ie=edge\">\n    <title>Email Confirmation</title>\n    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">\n    <style type=\"text/css\">\n        @media screen {\n            @font-face {\n                font-family: \'Source Sans Pro\';\n                font-style: normal;\n                font-weight: 400;\n                src: local(\'Source Sans Pro Regular\'), local(\'SourceSansPro-Regular\'), url(https://fonts.gstatic.com/s/sourcesanspro/v10/ODelI1aHBYDBqgeIAH2zlBM0YzuT7MdOe03otPbuUS0.woff) format(\'woff\');\n            }\n\n            @font-face {\n                font-family: \'Source Sans Pro\';\n                font-style: normal;\n                font-weight: 700;\n                src: local(\'Source Sans Pro Bold\'), local(\'SourceSansPro-Bold\'), url(https://fonts.gstatic.com/s/sourcesanspro/v10/toadOcfmlt9b38dHJxOBGFkQc6VGVFSmCnC_l7QZG60.woff) format(\'woff\');\n            }\n        }\n\n        body,\n        table,\n        td,\n        a {\n            -ms-text-size-adjust: 100%;\n            /* 1 */\n            -webkit-text-size-adjust: 100%;\n            /* 2 */\n        }\n\n        img {\n            -ms-interpolation-mode: bicubic;\n        }\n\n        a[x-apple-data-detectors] {\n            font-family: inherit !important;\n            font-size: inherit !important;\n            font-weight: inherit !important;\n            line-height: inherit !important;\n            color: inherit !important;\n            text-decoration: none !important;\n        }\n\n        div[style*=\"margin: 16px 0;\"] {\n            margin: 0 !important;\n        }\n\n        body {\n            width: 100% !important;\n            height: 100% !important;\n            padding: 0 !important;\n            margin: 0 !important;\n            padding: 24px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 16px;\n            background-color: #f9fafc;\n            color: #60676d;\n        }\n\n        table {\n            border-collapse: collapse !important;\n        }\n\n        a {\n            color: #1a82e2;\n        }\n\n        img {\n            height: auto;\n            line-height: 100%;\n            text-decoration: none;\n            border: 0;\n            outline: none;\n        }\n\n        .table-1 {\n            max-width: 600px;\n        }\n\n        .table-1 td {\n            padding: 36px 24px 40px;\n            text-align: center;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-1 h1 {\n            margin: 0;\n            font-size: 32px;\n            font-weight: 600;\n            letter-spacing: -1px;\n            line-height: 48px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-2 {\n            max-width: 600px;\n        }\n\n        .table-2 td {\n            padding: 36px 24px 0;\n            border-top: 3px solid #d4dadf;\n            background-color: #ffffff;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-2 h1 {\n            margin: 0;\n            font-size: 20px;\n            font-weight: 600;\n            letter-spacing: -1px;\n            line-height: 48px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-3 {\n            max-width: 600px;\n        }\n\n        .table-2 td {\n\n            background-color: #ffffff;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .td-1 {\n            padding: 24px;\n            font-size: 16px;\n            line-height: 24px;\n            background-color: #ffffff;\n            text-align: left;\n            padding-bottom: 10px;\n            padding-top: 0px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-gray {\n            width: 100%;\n        }\n\n        .table-gray tr {\n            height: 24px;\n        }\n\n        .table-gray .td-1 {\n            background-color: #f1f3f7;\n            width: 30%;\n            border: solid 1px #e7e9ec;\n            padding-top: 5px;\n            padding-bottom: 5px;\n            font-size:16px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-gray .td-2 {\n            background-color: #f1f3f7;\n            width: 70%;\n            border: solid 1px #e7e9ec;\n            font-size:16px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .button, .button:active, .button:visited {\n            display: inline-block;\n            padding: 16px 36px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 16px;\n            color: #ffffff;\n            text-decoration: none;\n            border-radius: 6px;\n            background-color: #1a82e2;\n            border-radius: 6px;\n        }\n\n        .signature {\n            padding: 24px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 16px;\n            line-height: 24px;\n            border-bottom: 3px solid #d4dadf;\n            background-color: #ffffff;\n        }\n\n        .footer {\n            max-width: 600px;\n        }\n\n        .footer td {\n            padding: 12px 24px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 14px;\n            line-height: 20px;\n            color: #666;\n        }\n\n        .td-button {\n            padding: 12px;\n            background-color: #ffffff;\n            text-align: center;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .p-24 {\n            padding: 24px;\n        }\n    </style>\n\n</head>\n\n<body>\n<!-- start body -->\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start hero -->\n<tbody>\n<tr>\n<td align=\"center\">\n<table class=\"table-1\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td align=\"left\">\n<h1>New Invoice</h1>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end hero --> <!-- start hero -->\n<tr>\n<td align=\"center\">\n<table class=\"table-2\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td align=\"left\">\n<h1>Hi {first_name},</h1>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end hero --> <!-- start copy block -->\n<tr>\n<td align=\"center\">\n<table class=\"table-3\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start copy -->\n<tbody>\n<tr>\n<td class=\"td-1\">\n<p>Please find attached your invoice.</p>\n</td>\n</tr>\n<tr>\n<td class=\"td-1\">\n<table class=\"table-gray\" cellpadding=\"5\">\n<tbody>\n<tr>\n<td class=\"td-1\"><strong>Invoice ID</strong></td>\n<td class=\"td-2\">{invoice_id}</td>\n</tr>\n<tr>\n<td class=\"td-1\"><strong>Amount</strong></td>\n<td class=\"td-2\">{invoice_amount}</td>\n</tr>\n<tr>\n<td class=\"td-1\"><strong>Due Date</strong></td>\n<td class=\"td-2\">{invoice_date_due}</td>\n</tr>\n<tr>\n<td class=\"td-1\"><strong>Project</strong></td>\n<td class=\"td-2\">{project_title}</td>\n</tr>\n</tbody>\n</table>\n<p>You can view your invoice and make any payments using the link below.</p>\n<p>Your invoice is attached.</p>\n</td>\n</tr>\n<tr>\n<td align=\"left\" bgcolor=\"#ffffff\">\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td class=\"td-button\">\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td align=\"center\"><a class=\"button\" href=\"{invoice_url}\" target=\"_blank\" rel=\"noopener\">View Invoice</a></td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<tr>\n<td class=\"signature\">\n<p>{email_signature}</p>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end copy block --> <!-- start footer -->\n<tr>\n<td class=\"p-24\" align=\"center\">\n<table class=\"footer\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start permission -->\n<tbody>\n<tr>\n<td align=\"center\">\n<p>{email_footer}</p>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end footer --></tbody>\n</table>\n<!-- end body -->\n</body>\n\n</html>', '{first_name}, {last_name}, {invoice_id}, {invoice_amount}, {invoice_amount_due}, {invoice_date_created}, {invoice_date_due}, {project_title}, {project_id}, {client_name}, {client_id}, {invoice_status}, {invoice_url}', '2019-12-08 17:13:10', '2021-01-25 18:32:01', 'enabled', 'english', 'yes', 'yes', 117);
INSERT INTO `email_templates` (`emailtemplate_module_unique_id`, `emailtemplate_module_name`, `emailtemplate_name`, `emailtemplate_lang`, `emailtemplate_type`, `emailtemplate_category`, `emailtemplate_subject`, `emailtemplate_body`, `emailtemplate_variables`, `emailtemplate_created`, `emailtemplate_updated`, `emailtemplate_status`, `emailtemplate_language`, `emailtemplate_real_template`, `emailtemplate_show_enabled`, `emailtemplate_id`) VALUES
(NULL, NULL, 'Invoice Reminder', 'template_lang_invoice_reminder', 'client', 'billing', 'Invoice Reminder - #{invoice_id}', '<!DOCTYPE html>\n<html>\n\n<head>\n\n    <meta charset=\"utf-8\">\n    <meta http-equiv=\"x-ua-compatible\" content=\"ie=edge\">\n    <title>Email Confirmation</title>\n    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">\n    <style type=\"text/css\">\n        @media screen {\n            @font-face {\n                font-family: \'Source Sans Pro\';\n                font-style: normal;\n                font-weight: 400;\n                src: local(\'Source Sans Pro Regular\'), local(\'SourceSansPro-Regular\'), url(https://fonts.gstatic.com/s/sourcesanspro/v10/ODelI1aHBYDBqgeIAH2zlBM0YzuT7MdOe03otPbuUS0.woff) format(\'woff\');\n            }\n\n            @font-face {\n                font-family: \'Source Sans Pro\';\n                font-style: normal;\n                font-weight: 700;\n                src: local(\'Source Sans Pro Bold\'), local(\'SourceSansPro-Bold\'), url(https://fonts.gstatic.com/s/sourcesanspro/v10/toadOcfmlt9b38dHJxOBGFkQc6VGVFSmCnC_l7QZG60.woff) format(\'woff\');\n            }\n        }\n\n        body,\n        table,\n        td,\n        a {\n            -ms-text-size-adjust: 100%;\n            /* 1 */\n            -webkit-text-size-adjust: 100%;\n            /* 2 */\n        }\n\n        img {\n            -ms-interpolation-mode: bicubic;\n        }\n\n        a[x-apple-data-detectors] {\n            font-family: inherit !important;\n            font-size: inherit !important;\n            font-weight: inherit !important;\n            line-height: inherit !important;\n            color: inherit !important;\n            text-decoration: none !important;\n        }\n\n        div[style*=\"margin: 16px 0;\"] {\n            margin: 0 !important;\n        }\n\n        body {\n            width: 100% !important;\n            height: 100% !important;\n            padding: 0 !important;\n            margin: 0 !important;\n            padding: 24px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 16px;\n            background-color: #f9fafc;\n            color: #60676d;\n        }\n\n        table {\n            border-collapse: collapse !important;\n        }\n\n        a {\n            color: #1a82e2;\n        }\n\n        img {\n            height: auto;\n            line-height: 100%;\n            text-decoration: none;\n            border: 0;\n            outline: none;\n        }\n\n        .table-1 {\n            max-width: 600px;\n        }\n\n        .table-1 td {\n            padding: 36px 24px 40px;\n            text-align: center;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-1 h1 {\n            margin: 0;\n            font-size: 32px;\n            font-weight: 600;\n            letter-spacing: -1px;\n            line-height: 48px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-2 {\n            max-width: 600px;\n        }\n\n        .table-2 td {\n            padding: 36px 24px 0;\n            border-top: 3px solid #d4dadf;\n            background-color: #ffffff;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-2 h1 {\n            margin: 0;\n            font-size: 20px;\n            font-weight: 600;\n            letter-spacing: -1px;\n            line-height: 48px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-3 {\n            max-width: 600px;\n        }\n\n        .table-2 td {\n\n            background-color: #ffffff;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .td-1 {\n            padding: 24px;\n            font-size: 16px;\n            line-height: 24px;\n            background-color: #ffffff;\n            text-align: left;\n            padding-bottom: 10px;\n            padding-top: 0px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-gray {\n            width: 100%;\n        }\n\n        .table-gray tr {\n            height: 24px;\n        }\n\n        .table-gray .td-1 {\n            background-color: #f1f3f7;\n            width: 30%;\n            border: solid 1px #e7e9ec;\n            padding-top: 5px;\n            padding-bottom: 5px;\n            font-size:16px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-gray .td-2 {\n            background-color: #f1f3f7;\n            width: 70%;\n            border: solid 1px #e7e9ec;\n            font-size:16px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .button, .button:active, .button:visited {\n            display: inline-block;\n            padding: 16px 36px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 16px;\n            color: #ffffff;\n            text-decoration: none;\n            border-radius: 6px;\n            background-color: #1a82e2;\n            border-radius: 6px;\n        }\n\n        .signature {\n            padding: 24px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 16px;\n            line-height: 24px;\n            border-bottom: 3px solid #d4dadf;\n            background-color: #ffffff;\n        }\n\n        .footer {\n            max-width: 600px;\n        }\n\n        .footer td {\n            padding: 12px 24px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 14px;\n            line-height: 20px;\n            color: #666;\n        }\n\n        .td-button {\n            padding: 12px;\n            background-color: #ffffff;\n            text-align: center;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .p-24 {\n            padding: 24px;\n        }\n    </style>\n\n</head>\n\n<body>\n<!-- start body -->\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start hero -->\n<tbody>\n<tr>\n<td align=\"center\">\n<table class=\"table-1\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td align=\"left\">\n<h1>Invoice Reminder</h1>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end hero --> <!-- start hero -->\n<tr>\n<td align=\"center\">\n<table class=\"table-2\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td align=\"left\">\n<h1>Hi {first_name},</h1>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end hero --> <!-- start copy block -->\n<tr>\n<td align=\"center\">\n<table class=\"table-3\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start copy -->\n<tbody>\n<tr>\n<td class=\"td-1\">\n<p>This invoice is now overdue.</p>\n</td>\n</tr>\n<tr>\n<td class=\"td-1\">\n<table class=\"table-gray\" cellpadding=\"5\">\n<tbody>\n<tr>\n<td class=\"td-1\"><strong>Invoice ID</strong></td>\n<td class=\"td-2\">{invoice_id}</td>\n</tr>\n<tr>\n<td class=\"td-1\"><strong>Due Date</strong></td>\n<td class=\"td-2\">{invoice_date_due}</td>\n</tr>\n<tr>\n<td class=\"td-1\"><strong>Amount</strong></td>\n<td class=\"td-2\">{invoice_amount}</td>\n</tr>\n<tr>\n<td class=\"td-1\"><strong>Project</strong></td>\n<td class=\"td-2\">{project_title}</td>\n</tr>\n</tbody>\n</table>\n<p>You can view your invoice and make any payments using the link below.</p>\n<p>Your invoice is attached.</p>\n</td>\n</tr>\n<tr>\n<td align=\"left\" bgcolor=\"#ffffff\">\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td class=\"td-button\">\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td align=\"center\"><a class=\"button\" href=\"{invoice_url}\" target=\"_blank\" rel=\"noopener\">View Invoice</a></td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<tr>\n<td class=\"signature\">\n<p>{email_signature}</p>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end copy block --> <!-- start footer -->\n<tr>\n<td class=\"p-24\" align=\"center\">\n<table class=\"footer\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start permission -->\n<tbody>\n<tr>\n<td align=\"center\">\n<p>{email_footer}</p>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end footer --></tbody>\n</table>\n<!-- end body -->\n</body>\n\n</html>', '{first_name}, {last_name}, {invoice_id}, {invoice_amount}, {invoice_amount_due}, {invoice_created_date}, {invoice_date_created}, {invoice_date_due}, {project_title}, {project_id}, {client_name}, {client_id}, {invoice_status}, {client_name}, {client_id},{invoice_url}', '2019-12-08 17:13:10', '2020-11-13 08:23:26', 'enabled', 'english', 'yes', 'yes', 118),
(NULL, NULL, 'Thank You For Payment', 'template_lang_thank_you_payment', 'client', 'billing', 'Thank You For Your Payment', '<!DOCTYPE html>\n<html>\n\n<head>\n\n    <meta charset=\"utf-8\">\n    <meta http-equiv=\"x-ua-compatible\" content=\"ie=edge\">\n    <title>Email Confirmation</title>\n    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">\n    <style type=\"text/css\">\n        @media screen {\n            @font-face {\n                font-family: \'Source Sans Pro\';\n                font-style: normal;\n                font-weight: 400;\n                src: local(\'Source Sans Pro Regular\'), local(\'SourceSansPro-Regular\'), url(https://fonts.gstatic.com/s/sourcesanspro/v10/ODelI1aHBYDBqgeIAH2zlBM0YzuT7MdOe03otPbuUS0.woff) format(\'woff\');\n            }\n\n            @font-face {\n                font-family: \'Source Sans Pro\';\n                font-style: normal;\n                font-weight: 700;\n                src: local(\'Source Sans Pro Bold\'), local(\'SourceSansPro-Bold\'), url(https://fonts.gstatic.com/s/sourcesanspro/v10/toadOcfmlt9b38dHJxOBGFkQc6VGVFSmCnC_l7QZG60.woff) format(\'woff\');\n            }\n        }\n\n        body,\n        table,\n        td,\n        a {\n            -ms-text-size-adjust: 100%;\n            /* 1 */\n            -webkit-text-size-adjust: 100%;\n            /* 2 */\n        }\n\n        img {\n            -ms-interpolation-mode: bicubic;\n        }\n\n        a[x-apple-data-detectors] {\n            font-family: inherit !important;\n            font-size: inherit !important;\n            font-weight: inherit !important;\n            line-height: inherit !important;\n            color: inherit !important;\n            text-decoration: none !important;\n        }\n\n        div[style*=\"margin: 16px 0;\"] {\n            margin: 0 !important;\n        }\n\n        body {\n            width: 100% !important;\n            height: 100% !important;\n            padding: 0 !important;\n            margin: 0 !important;\n            padding: 24px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 16px;\n            background-color: #f9fafc;\n            color: #60676d;\n        }\n\n        table {\n            border-collapse: collapse !important;\n        }\n\n        a {\n            color: #1a82e2;\n        }\n\n        img {\n            height: auto;\n            line-height: 100%;\n            text-decoration: none;\n            border: 0;\n            outline: none;\n        }\n\n        .table-1 {\n            max-width: 600px;\n        }\n\n        .table-1 td {\n            padding: 36px 24px 40px;\n            text-align: center;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-1 h1 {\n            margin: 0;\n            font-size: 32px;\n            font-weight: 600;\n            letter-spacing: -1px;\n            line-height: 48px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-2 {\n            max-width: 600px;\n        }\n\n        .table-2 td {\n            padding: 36px 24px 0;\n            border-top: 3px solid #d4dadf;\n            background-color: #ffffff;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-2 h1 {\n            margin: 0;\n            font-size: 20px;\n            font-weight: 600;\n            letter-spacing: -1px;\n            line-height: 48px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-3 {\n            max-width: 600px;\n        }\n\n        .table-2 td {\n\n            background-color: #ffffff;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .td-1 {\n            padding: 24px;\n            font-size: 16px;\n            line-height: 24px;\n            background-color: #ffffff;\n            text-align: left;\n            padding-bottom: 10px;\n            padding-top: 0px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-gray {\n            width: 100%;\n        }\n\n        .table-gray tr {\n            height: 24px;\n        }\n\n        .table-gray .td-1 {\n            background-color: #f1f3f7;\n            width: 30%;\n            border: solid 1px #e7e9ec;\n            padding-top: 5px;\n            padding-bottom: 5px;\n            font-size:16px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-gray .td-2 {\n            background-color: #f1f3f7;\n            width: 70%;\n            border: solid 1px #e7e9ec;\n            font-size:16px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .button, .button:active, .button:visited {\n            display: inline-block;\n            padding: 16px 36px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 16px;\n            color: #ffffff;\n            text-decoration: none;\n            border-radius: 6px;\n            background-color: #1a82e2;\n            border-radius: 6px;\n        }\n\n        .signature {\n            padding: 24px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 16px;\n            line-height: 24px;\n            border-bottom: 3px solid #d4dadf;\n            background-color: #ffffff;\n        }\n\n        .footer {\n            max-width: 600px;\n        }\n\n        .footer td {\n            padding: 12px 24px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 14px;\n            line-height: 20px;\n            color: #666;\n        }\n\n        .td-button {\n            padding: 12px;\n            background-color: #ffffff;\n            text-align: center;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .p-24 {\n            padding: 24px;\n        }\n    </style>\n\n</head>\n\n<body>\n<!-- start body -->\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start hero -->\n<tbody>\n<tr>\n<td align=\"center\">\n<table class=\"table-1\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td align=\"left\">\n<h1>Thank You!</h1>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end hero --> <!-- start hero -->\n<tr>\n<td align=\"center\">\n<table class=\"table-2\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td align=\"left\">\n<h1>Hi {first_name},</h1>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end hero --> <!-- start copy block -->\n<tr>\n<td align=\"center\">\n<table class=\"table-3\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start copy -->\n<tbody>\n<tr>\n<td class=\"td-1\">\n<p>We have received your payment and it has been applied to your invoice.</p>\n</td>\n</tr>\n<tr>\n<td class=\"td-1\">\n<table class=\"table-gray\" cellpadding=\"5\">\n<tbody>\n<tr>\n<td class=\"td-1\"><strong>Invoice ID</strong></td>\n<td class=\"td-2\">{invoice_id}</td>\n</tr>\n<tr>\n<td class=\"td-1\"><strong>Amount Paid</strong></td>\n<td class=\"td-2\">{payment_amount}</td>\n</tr>\n<tr>\n<td class=\"td-1\"><strong>Transaction ID</strong></td>\n<td class=\"td-2\">{payment_transaction_id}</td>\n</tr>\n</tbody>\n</table>\n<p>You can view your invoice using the link below.</p>\n</td>\n</tr>\n<tr>\n<td align=\"left\" bgcolor=\"#ffffff\">\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td class=\"td-button\">\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td align=\"center\"><a class=\"button\" href=\"{invoice_url}\" target=\"_blank\" rel=\"noopener\">View Invoice</a></td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<tr>\n<td class=\"signature\">\n<p>{email_signature}</p>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end copy block --> <!-- start footer -->\n<tr>\n<td class=\"p-24\" align=\"center\">\n<table class=\"footer\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start permission -->\n<tbody>\n<tr>\n<td align=\"center\">\n<p>{email_footer}</p>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end footer --></tbody>\n</table>\n<!-- end body -->\n</body>\n\n</html>', '{first_name}, {last_name}, {invoice_id}, {invoice_amount}, {invoice_amount_due}, {invoice_date_created}, {invoice_date_due}, {project_title}, {project_id}, {client_name}, {client_id}, {invoice_status}, {payment_gateway}, {payment_amount}, {payment_transaction_id}, {client_id}, {client_name}, {paid_by_name}, {invoice_url}', '2019-12-08 17:13:10', '2020-11-12 13:02:54', 'enabled', 'english', 'yes', 'yes', 119),
(NULL, NULL, 'New Payment', 'template_lang_new_payment', 'team', 'billing', 'New Payment Received', '<!DOCTYPE html>\n<html>\n\n<head>\n\n    <meta charset=\"utf-8\">\n    <meta http-equiv=\"x-ua-compatible\" content=\"ie=edge\">\n    <title>Email Confirmation</title>\n    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">\n    <style type=\"text/css\">\n        @media screen {\n            @font-face {\n                font-family: \'Source Sans Pro\';\n                font-style: normal;\n                font-weight: 400;\n                src: local(\'Source Sans Pro Regular\'), local(\'SourceSansPro-Regular\'), url(https://fonts.gstatic.com/s/sourcesanspro/v10/ODelI1aHBYDBqgeIAH2zlBM0YzuT7MdOe03otPbuUS0.woff) format(\'woff\');\n            }\n\n            @font-face {\n                font-family: \'Source Sans Pro\';\n                font-style: normal;\n                font-weight: 700;\n                src: local(\'Source Sans Pro Bold\'), local(\'SourceSansPro-Bold\'), url(https://fonts.gstatic.com/s/sourcesanspro/v10/toadOcfmlt9b38dHJxOBGFkQc6VGVFSmCnC_l7QZG60.woff) format(\'woff\');\n            }\n        }\n\n        body,\n        table,\n        td,\n        a {\n            -ms-text-size-adjust: 100%;\n            /* 1 */\n            -webkit-text-size-adjust: 100%;\n            /* 2 */\n        }\n\n        img {\n            -ms-interpolation-mode: bicubic;\n        }\n\n        a[x-apple-data-detectors] {\n            font-family: inherit !important;\n            font-size: inherit !important;\n            font-weight: inherit !important;\n            line-height: inherit !important;\n            color: inherit !important;\n            text-decoration: none !important;\n        }\n\n        div[style*=\"margin: 16px 0;\"] {\n            margin: 0 !important;\n        }\n\n        body {\n            width: 100% !important;\n            height: 100% !important;\n            padding: 0 !important;\n            margin: 0 !important;\n            padding: 24px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 16px;\n            background-color: #f9fafc;\n            color: #60676d;\n        }\n\n        table {\n            border-collapse: collapse !important;\n        }\n\n        a {\n            color: #1a82e2;\n        }\n\n        img {\n            height: auto;\n            line-height: 100%;\n            text-decoration: none;\n            border: 0;\n            outline: none;\n        }\n\n        .table-1 {\n            max-width: 600px;\n        }\n\n        .table-1 td {\n            padding: 36px 24px 40px;\n            text-align: center;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-1 h1 {\n            margin: 0;\n            font-size: 32px;\n            font-weight: 600;\n            letter-spacing: -1px;\n            line-height: 48px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-2 {\n            max-width: 600px;\n        }\n\n        .table-2 td {\n            padding: 36px 24px 0;\n            border-top: 3px solid #d4dadf;\n            background-color: #ffffff;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-2 h1 {\n            margin: 0;\n            font-size: 20px;\n            font-weight: 600;\n            letter-spacing: -1px;\n            line-height: 48px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-3 {\n            max-width: 600px;\n        }\n\n        .table-2 td {\n\n            background-color: #ffffff;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .td-1 {\n            padding: 24px;\n            font-size: 16px;\n            line-height: 24px;\n            background-color: #ffffff;\n            text-align: left;\n            padding-bottom: 10px;\n            padding-top: 0px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-gray {\n            width: 100%;\n        }\n\n        .table-gray tr {\n            height: 24px;\n        }\n\n        .table-gray .td-1 {\n            background-color: #f1f3f7;\n            width: 30%;\n            border: solid 1px #e7e9ec;\n            padding-top: 5px;\n            padding-bottom: 5px;\n            font-size:16px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-gray .td-2 {\n            background-color: #f1f3f7;\n            width: 70%;\n            border: solid 1px #e7e9ec;\n            font-size:16px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .button, .button:active, .button:visited {\n            display: inline-block;\n            padding: 16px 36px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 16px;\n            color: #ffffff;\n            text-decoration: none;\n            border-radius: 6px;\n            background-color: #1a82e2;\n            border-radius: 6px;\n        }\n\n        .signature {\n            padding: 24px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 16px;\n            line-height: 24px;\n            border-bottom: 3px solid #d4dadf;\n            background-color: #ffffff;\n        }\n\n        .footer {\n            max-width: 600px;\n        }\n\n        .footer td {\n            padding: 12px 24px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 14px;\n            line-height: 20px;\n            color: #666;\n        }\n\n        .td-button {\n            padding: 12px;\n            background-color: #ffffff;\n            text-align: center;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .p-24 {\n            padding: 24px;\n        }\n    </style>\n\n</head>\n\n<body>\n<!-- start body -->\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start hero -->\n<tbody>\n<tr>\n<td align=\"center\">\n<table class=\"table-1\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td align=\"left\">\n<h1>New Payment</h1>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end hero --> <!-- start hero -->\n<tr>\n<td align=\"center\">\n<table class=\"table-2\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td align=\"left\">\n<h1>Hi {first_name},</h1>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end hero --> <!-- start copy block -->\n<tr>\n<td align=\"center\">\n<table class=\"table-3\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start copy -->\n<tbody>\n<tr>\n<td class=\"td-1\">\n<p>A new payment has just been made.</p>\n</td>\n</tr>\n<tr>\n<td class=\"td-1\">\n<table class=\"table-gray\" cellpadding=\"5\">\n<tbody>\n<tr>\n<td class=\"td-1\"><strong>Invoice ID</strong></td>\n<td class=\"td-2\">{invoice_id}</td>\n</tr>\n<tr>\n<td class=\"td-1\"><strong>Amount Due</strong></td>\n<td class=\"td-2\">{invoice_amount}</td>\n</tr>\n<tr>\n<td class=\"td-1\"><strong>Transaction ID</strong></td>\n<td class=\"td-2\">{payment_transaction_id}</td>\n</tr>\n<tr>\n<td class=\"td-1\"><strong>Client Name</strong></td>\n<td class=\"td-2\">{client_name}</td>\n</tr>\n<tr>\n<td class=\"td-1\"><strong>Paid By</strong></td>\n<td class=\"td-2\">{paid_by_name}</td>\n</tr>\n</tbody>\n</table>\n<p>You can manage payments and invoices via the dashboard.</p>\n</td>\n</tr>\n<tr>\n<td align=\"left\" bgcolor=\"#ffffff\">\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td class=\"td-button\">\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td align=\"center\"><a class=\"button\" href=\"{invoice_url}\" target=\"_blank\" rel=\"noopener\">Manage Invoices</a></td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<tr>\n<td class=\"signature\">\n<p>{email_signature}</p>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end copy block --> <!-- start footer -->\n<tr>\n<td class=\"p-24\" align=\"center\">\n<table class=\"footer\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start permission -->\n<tbody>\n<tr>\n<td align=\"center\">\n<p>{email_footer}</p>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end footer --></tbody>\n</table>\n<!-- end body -->\n</body>\n\n</html>', '{first_name}, {last_name}, {invoice_id}, {invoice_amount}, {invoice_amount_due}, {invoice_date_created}, {invoice_date_due}, {project_title}, {project_id}, {client_name}, {client_id}, {invoice_status}, {payment_gateway}, {payment_amount}, {payment_transaction_id}, {client_id}, {client_name}, {paid_by_name}, {invoice_url}', '2019-12-08 17:13:10', '2020-11-12 13:06:24', 'enabled', 'english', 'yes', 'yes', 120),
(NULL, NULL, 'New Estimate', 'template_lang_new_estimate', 'client', 'estimates', 'New Estimate - #{estimate_id}', '<!DOCTYPE html>\n<html>\n\n<head>\n\n    <meta charset=\"utf-8\">\n    <meta http-equiv=\"x-ua-compatible\" content=\"ie=edge\">\n    <title>Email Confirmation</title>\n    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">\n    <style type=\"text/css\">\n        @media screen {\n            @font-face {\n                font-family: \'Source Sans Pro\';\n                font-style: normal;\n                font-weight: 400;\n                src: local(\'Source Sans Pro Regular\'), local(\'SourceSansPro-Regular\'), url(https://fonts.gstatic.com/s/sourcesanspro/v10/ODelI1aHBYDBqgeIAH2zlBM0YzuT7MdOe03otPbuUS0.woff) format(\'woff\');\n            }\n\n            @font-face {\n                font-family: \'Source Sans Pro\';\n                font-style: normal;\n                font-weight: 700;\n                src: local(\'Source Sans Pro Bold\'), local(\'SourceSansPro-Bold\'), url(https://fonts.gstatic.com/s/sourcesanspro/v10/toadOcfmlt9b38dHJxOBGFkQc6VGVFSmCnC_l7QZG60.woff) format(\'woff\');\n            }\n        }\n\n        body,\n        table,\n        td,\n        a {\n            -ms-text-size-adjust: 100%;\n            /* 1 */\n            -webkit-text-size-adjust: 100%;\n            /* 2 */\n        }\n\n        img {\n            -ms-interpolation-mode: bicubic;\n        }\n\n        a[x-apple-data-detectors] {\n            font-family: inherit !important;\n            font-size: inherit !important;\n            font-weight: inherit !important;\n            line-height: inherit !important;\n            color: inherit !important;\n            text-decoration: none !important;\n        }\n\n        div[style*=\"margin: 16px 0;\"] {\n            margin: 0 !important;\n        }\n\n        body {\n            width: 100% !important;\n            height: 100% !important;\n            padding: 0 !important;\n            margin: 0 !important;\n            padding: 24px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 16px;\n            background-color: #f9fafc;\n            color: #60676d;\n        }\n\n        table {\n            border-collapse: collapse !important;\n        }\n\n        a {\n            color: #1a82e2;\n        }\n\n        img {\n            height: auto;\n            line-height: 100%;\n            text-decoration: none;\n            border: 0;\n            outline: none;\n        }\n\n        .table-1 {\n            max-width: 600px;\n        }\n\n        .table-1 td {\n            padding: 36px 24px 40px;\n            text-align: center;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-1 h1 {\n            margin: 0;\n            font-size: 32px;\n            font-weight: 600;\n            letter-spacing: -1px;\n            line-height: 48px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-2 {\n            max-width: 600px;\n        }\n\n        .table-2 td {\n            padding: 36px 24px 0;\n            border-top: 3px solid #d4dadf;\n            background-color: #ffffff;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-2 h1 {\n            margin: 0;\n            font-size: 20px;\n            font-weight: 600;\n            letter-spacing: -1px;\n            line-height: 48px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-3 {\n            max-width: 600px;\n        }\n\n        .table-2 td {\n\n            background-color: #ffffff;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .td-1 {\n            padding: 24px;\n            font-size: 16px;\n            line-height: 24px;\n            background-color: #ffffff;\n            text-align: left;\n            padding-bottom: 10px;\n            padding-top: 0px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-gray {\n            width: 100%;\n        }\n\n        .table-gray tr {\n            height: 24px;\n        }\n\n        .table-gray .td-1 {\n            background-color: #f1f3f7;\n            width: 30%;\n            border: solid 1px #e7e9ec;\n            padding-top: 5px;\n            padding-bottom: 5px;\n            font-size:16px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-gray .td-2 {\n            background-color: #f1f3f7;\n            width: 70%;\n            border: solid 1px #e7e9ec;\n            font-size:16px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .button, .button:active, .button:visited {\n            display: inline-block;\n            padding: 16px 36px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 16px;\n            color: #ffffff;\n            text-decoration: none;\n            border-radius: 6px;\n            background-color: #1a82e2;\n            border-radius: 6px;\n        }\n\n        .signature {\n            padding: 24px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 16px;\n            line-height: 24px;\n            border-bottom: 3px solid #d4dadf;\n            background-color: #ffffff;\n        }\n\n        .footer {\n            max-width: 600px;\n        }\n\n        .footer td {\n            padding: 12px 24px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 14px;\n            line-height: 20px;\n            color: #666;\n        }\n\n        .td-button {\n            padding: 12px;\n            background-color: #ffffff;\n            text-align: center;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .p-24 {\n            padding: 24px;\n        }\n    </style>\n\n</head>\n\n<body>\n<!-- start body -->\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start hero -->\n<tbody>\n<tr>\n<td align=\"center\">\n<table class=\"table-1\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td align=\"left\">\n<h1>NEW ESTIMATE</h1>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end hero --> <!-- start hero -->\n<tr>\n<td align=\"center\">\n<table class=\"table-2\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td align=\"left\">\n<h1>Hi {first_name},</h1>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end hero --> <!-- start copy block -->\n<tr>\n<td align=\"center\">\n<table class=\"table-3\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start copy -->\n<tbody>\n<tr>\n<td class=\"td-1\">\n<p>We have prepared a new cost estimate for your project.</p>\n</td>\n</tr>\n<tr>\n<td class=\"td-1\">\n<table class=\"table-gray\" cellpadding=\"5\">\n<tbody>\n<tr>\n<td class=\"td-1\"><strong>Project Title</strong></td>\n<td class=\"td-2\">{project_title}</td>\n</tr>\n<tr>\n<td class=\"td-1\"><strong>Estimate Amount</strong></td>\n<td class=\"td-2\">{estimate_amount}</td>\n</tr>\n</tbody>\n</table>\n<p>You can review this estimate via the dashboard.</p>\n</td>\n</tr>\n<tr>\n<td align=\"left\" bgcolor=\"#ffffff\">\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td class=\"td-button\">\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td align=\"center\"><a class=\"button\" href=\"{estimate_url}\" target=\"_blank\" rel=\"noopener\">View Estimate</a></td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<tr>\n<td class=\"signature\">\n<p>{email_signature}</p>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end copy block --> <!-- start footer -->\n<tr>\n<td class=\"p-24\" align=\"center\">\n<table class=\"footer\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start permission -->\n<tbody>\n<tr>\n<td align=\"center\">\n<p>{email_footer}</p>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end footer --></tbody>\n</table>\n<!-- end body -->\n</body>\n\n</html>', '{first_name}, {last_name}, {estimate_id}, {estimate_amount}, {estimate_date_created}, {estimate_expiry_date}, {project_title}, {project_id}, {client_name}, {client_id}, {estimate_status}, {estimate_url}', '2019-12-08 17:13:10', '2020-11-12 20:09:26', 'enabled', 'english', 'yes', 'yes', 121),
(NULL, NULL, 'New Ticket', 'template_lang_new_ticket', 'everyone', 'tickets', 'New Ticket Opened - #{ticket_id}', '<!DOCTYPE html>\n<html>\n\n<head>\n\n    <meta charset=\"utf-8\">\n    <meta http-equiv=\"x-ua-compatible\" content=\"ie=edge\">\n    <title>Email Confirmation</title>\n    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">\n    <style type=\"text/css\">\n        @media screen {\n            @font-face {\n                font-family: \'Source Sans Pro\';\n                font-style: normal;\n                font-weight: 400;\n                src: local(\'Source Sans Pro Regular\'), local(\'SourceSansPro-Regular\'), url(https://fonts.gstatic.com/s/sourcesanspro/v10/ODelI1aHBYDBqgeIAH2zlBM0YzuT7MdOe03otPbuUS0.woff) format(\'woff\');\n            }\n\n            @font-face {\n                font-family: \'Source Sans Pro\';\n                font-style: normal;\n                font-weight: 700;\n                src: local(\'Source Sans Pro Bold\'), local(\'SourceSansPro-Bold\'), url(https://fonts.gstatic.com/s/sourcesanspro/v10/toadOcfmlt9b38dHJxOBGFkQc6VGVFSmCnC_l7QZG60.woff) format(\'woff\');\n            }\n        }\n\n        body,\n        table,\n        td,\n        a {\n            -ms-text-size-adjust: 100%;\n            /* 1 */\n            -webkit-text-size-adjust: 100%;\n            /* 2 */\n        }\n\n        img {\n            -ms-interpolation-mode: bicubic;\n        }\n\n        a[x-apple-data-detectors] {\n            font-family: inherit !important;\n            font-size: inherit !important;\n            font-weight: inherit !important;\n            line-height: inherit !important;\n            color: inherit !important;\n            text-decoration: none !important;\n        }\n\n        div[style*=\"margin: 16px 0;\"] {\n            margin: 0 !important;\n        }\n\n        body {\n            width: 100% !important;\n            height: 100% !important;\n            padding: 0 !important;\n            margin: 0 !important;\n            padding: 24px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 16px;\n            background-color: #f9fafc;\n            color: #60676d;\n        }\n\n        table {\n            border-collapse: collapse !important;\n        }\n\n        a {\n            color: #1a82e2;\n        }\n\n        img {\n            height: auto;\n            line-height: 100%;\n            text-decoration: none;\n            border: 0;\n            outline: none;\n        }\n\n        .table-1 {\n            max-width: 600px;\n        }\n\n        .table-1 td {\n            padding: 36px 24px 40px;\n            text-align: center;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-1 h1 {\n            margin: 0;\n            font-size: 32px;\n            font-weight: 600;\n            letter-spacing: -1px;\n            line-height: 48px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-2 {\n            max-width: 600px;\n        }\n\n        .table-2 td {\n            padding: 36px 24px 0;\n            border-top: 3px solid #d4dadf;\n            background-color: #ffffff;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-2 h1 {\n            margin: 0;\n            font-size: 20px;\n            font-weight: 600;\n            letter-spacing: -1px;\n            line-height: 48px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-3 {\n            max-width: 600px;\n        }\n\n        .table-2 td {\n\n            background-color: #ffffff;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .td-1 {\n            padding: 24px;\n            font-size: 16px;\n            line-height: 24px;\n            background-color: #ffffff;\n            text-align: left;\n            padding-bottom: 10px;\n            padding-top: 0px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-gray {\n            width: 100%;\n        }\n\n        .table-gray tr {\n            height: 24px;\n        }\n\n        .table-gray .td-1 {\n            background-color: #f1f3f7;\n            width: 30%;\n            border: solid 1px #e7e9ec;\n            padding-top: 5px;\n            padding-bottom: 5px;\n            font-size:16px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-gray .td-2 {\n            background-color: #f1f3f7;\n            width: 70%;\n            border: solid 1px #e7e9ec;\n            font-size:16px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .button, .button:active, .button:visited {\n            display: inline-block;\n            padding: 16px 36px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 16px;\n            color: #ffffff;\n            text-decoration: none;\n            border-radius: 6px;\n            background-color: #1a82e2;\n            border-radius: 6px;\n        }\n\n        .signature {\n            padding: 24px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 16px;\n            line-height: 24px;\n            border-bottom: 3px solid #d4dadf;\n            background-color: #ffffff;\n        }\n\n        .footer {\n            max-width: 600px;\n        }\n\n        .footer td {\n            padding: 12px 24px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 14px;\n            line-height: 20px;\n            color: #666;\n        }\n\n        .td-button {\n            padding: 12px;\n            background-color: #ffffff;\n            text-align: center;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .p-24 {\n            padding: 24px;\n        }\n    </style>\n\n</head>\n\n<body>\n<!-- start body -->\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start hero -->\n<tbody>\n<tr>\n<td align=\"center\">\n<table class=\"table-1\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td align=\"left\">\n<h1>New Ticket Opened</h1>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end hero --> <!-- start hero -->\n<tr>\n<td align=\"center\">\n<table class=\"table-2\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td align=\"left\">\n<h1>Hi {first_name},</h1>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end hero --> <!-- start copy block -->\n<tr>\n<td align=\"center\">\n<table class=\"table-3\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start copy -->\n<tbody>\n<tr>\n<td class=\"td-1\">\n<p>A new support ticket has been created.</p>\n</td>\n</tr>\n<tr>\n<td class=\"td-1\">\n<table class=\"table-gray\" cellpadding=\"5\">\n<tbody>\n<tr>\n<td class=\"td-1\"><strong>Title</strong></td>\n<td class=\"td-2\">{ticket_subject}</td>\n</tr>\n<tr>\n<td class=\"td-1\"><strong>Created By</strong></td>\n<td class=\"td-2\">{by_first_name}</td>\n</tr>\n<tr>\n<td class=\"td-2\" colspan=\"2\">{ticket_message}</td>\n</tr>\n</tbody>\n</table>\n<p>You can view and respond to this ticket via the dashboard.</p>\n</td>\n</tr>\n<tr>\n<td align=\"left\" bgcolor=\"#ffffff\">\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td class=\"td-button\">\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td align=\"center\"><a class=\"button\" href=\"{ticket_url}\" target=\"_blank\" rel=\"noopener\">View Ticket</a></td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<tr>\n<td class=\"signature\">\n<p>{email_signature}</p>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end copy block --> <!-- start footer -->\n<tr>\n<td class=\"p-24\" align=\"center\">\n<table class=\"footer\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start permission -->\n<tbody>\n<tr>\n<td align=\"center\">\n<p>{email_footer}</p>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end footer --></tbody>\n</table>\n<!-- end body -->\n</body>\n\n</html>', '{first_name}, {last_name}, {ticket_id}, {by_first_name}, {by_last_name}, {ticket_subject}, {ticket_message}, {ticket_date_created}, {project_id}, {project_title}, {client_name}, {client_id}, {ticket_priority}, {ticket_status}, {ticket_url}', '2019-12-08 17:13:10', '2020-11-12 20:29:16', 'enabled', 'english', 'yes', 'yes', 124);
INSERT INTO `email_templates` (`emailtemplate_module_unique_id`, `emailtemplate_module_name`, `emailtemplate_name`, `emailtemplate_lang`, `emailtemplate_type`, `emailtemplate_category`, `emailtemplate_subject`, `emailtemplate_body`, `emailtemplate_variables`, `emailtemplate_created`, `emailtemplate_updated`, `emailtemplate_status`, `emailtemplate_language`, `emailtemplate_real_template`, `emailtemplate_show_enabled`, `emailtemplate_id`) VALUES
(NULL, NULL, 'New Ticket Reply', 'template_lang_new_ticket_reply', 'everyone', 'tickets', 'New Ticket Reply - #{ticket_id}', '<!DOCTYPE html>\n<html>\n\n<head>\n\n    <meta charset=\"utf-8\">\n    <meta http-equiv=\"x-ua-compatible\" content=\"ie=edge\">\n    <title>Email Confirmation</title>\n    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">\n    <style type=\"text/css\">\n        @media screen {\n            @font-face {\n                font-family: \'Source Sans Pro\';\n                font-style: normal;\n                font-weight: 400;\n                src: local(\'Source Sans Pro Regular\'), local(\'SourceSansPro-Regular\'), url(https://fonts.gstatic.com/s/sourcesanspro/v10/ODelI1aHBYDBqgeIAH2zlBM0YzuT7MdOe03otPbuUS0.woff) format(\'woff\');\n            }\n\n            @font-face {\n                font-family: \'Source Sans Pro\';\n                font-style: normal;\n                font-weight: 700;\n                src: local(\'Source Sans Pro Bold\'), local(\'SourceSansPro-Bold\'), url(https://fonts.gstatic.com/s/sourcesanspro/v10/toadOcfmlt9b38dHJxOBGFkQc6VGVFSmCnC_l7QZG60.woff) format(\'woff\');\n            }\n        }\n\n        body,\n        table,\n        td,\n        a {\n            -ms-text-size-adjust: 100%;\n            /* 1 */\n            -webkit-text-size-adjust: 100%;\n            /* 2 */\n        }\n\n        img {\n            -ms-interpolation-mode: bicubic;\n        }\n\n        a[x-apple-data-detectors] {\n            font-family: inherit !important;\n            font-size: inherit !important;\n            font-weight: inherit !important;\n            line-height: inherit !important;\n            color: inherit !important;\n            text-decoration: none !important;\n        }\n\n        div[style*=\"margin: 16px 0;\"] {\n            margin: 0 !important;\n        }\n\n        body {\n            width: 100% !important;\n            height: 100% !important;\n            padding: 0 !important;\n            margin: 0 !important;\n            padding: 24px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 16px;\n            background-color: #f9fafc;\n            color: #60676d;\n        }\n\n        table {\n            border-collapse: collapse !important;\n        }\n\n        a {\n            color: #1a82e2;\n        }\n\n        img {\n            height: auto;\n            line-height: 100%;\n            text-decoration: none;\n            border: 0;\n            outline: none;\n        }\n\n        .table-1 {\n            max-width: 600px;\n        }\n\n        .table-1 td {\n            padding: 36px 24px 40px;\n            text-align: center;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-1 h1 {\n            margin: 0;\n            font-size: 32px;\n            font-weight: 600;\n            letter-spacing: -1px;\n            line-height: 48px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-2 {\n            max-width: 600px;\n        }\n\n        .table-2 td {\n            padding: 36px 24px 0;\n            border-top: 3px solid #d4dadf;\n            background-color: #ffffff;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-2 h1 {\n            margin: 0;\n            font-size: 20px;\n            font-weight: 600;\n            letter-spacing: -1px;\n            line-height: 48px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-3 {\n            max-width: 600px;\n        }\n\n        .table-2 td {\n\n            background-color: #ffffff;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .td-1 {\n            padding: 24px;\n            font-size: 16px;\n            line-height: 24px;\n            background-color: #ffffff;\n            text-align: left;\n            padding-bottom: 10px;\n            padding-top: 0px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-gray {\n            width: 100%;\n        }\n\n        .table-gray tr {\n            height: 24px;\n        }\n\n        .table-gray .td-1 {\n            background-color: #f1f3f7;\n            width: 30%;\n            border: solid 1px #e7e9ec;\n            padding-top: 5px;\n            padding-bottom: 5px;\n            font-size:16px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-gray .td-2 {\n            background-color: #f1f3f7;\n            width: 70%;\n            border: solid 1px #e7e9ec;\n            font-size:16px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .button, .button:active, .button:visited {\n            display: inline-block;\n            padding: 16px 36px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 16px;\n            color: #ffffff;\n            text-decoration: none;\n            border-radius: 6px;\n            background-color: #1a82e2;\n            border-radius: 6px;\n        }\n\n        .signature {\n            padding: 24px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 16px;\n            line-height: 24px;\n            border-bottom: 3px solid #d4dadf;\n            background-color: #ffffff;\n        }\n\n        .footer {\n            max-width: 600px;\n        }\n\n        .footer td {\n            padding: 12px 24px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 14px;\n            line-height: 20px;\n            color: #666;\n        }\n\n        .td-button {\n            padding: 12px;\n            background-color: #ffffff;\n            text-align: center;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .p-24 {\n            padding: 24px;\n        }\n    </style>\n\n</head>\n\n<body>\n<!-- start body -->\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start hero -->\n<tbody>\n<tr>\n<td align=\"center\">\n<table class=\"table-1\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td align=\"left\">\n<h1>New Ticket Reply</h1>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end hero --> <!-- start hero -->\n<tr>\n<td align=\"center\">\n<table class=\"table-2\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td align=\"left\">\n<h1>Hi {first_name},</h1>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end hero --> <!-- start copy block -->\n<tr>\n<td align=\"center\">\n<table class=\"table-3\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start copy -->\n<tbody>\n<tr>\n<td class=\"td-1\">\n<p>A new reply has just been posted to this ticket.</p>\n</td>\n</tr>\n<tr>\n<td class=\"td-1\">\n<table class=\"table-gray\" cellpadding=\"5\">\n<tbody>\n<tr>\n<td class=\"td-1\"><strong>Title</strong></td>\n<td class=\"td-2\">{ticket_subject}</td>\n</tr>\n<tr>\n<td class=\"td-1\"><strong>Posted By</strong></td>\n<td class=\"td-2\">{by_first_name}</td>\n</tr>\n<tr>\n<td class=\"td-2\" colspan=\"2\">{ticket_reply_message}</td>\n</tr>\n</tbody>\n</table>\n<p>You can view and reply to this ticket via the dashboard.</p>\n</td>\n</tr>\n<tr>\n<td align=\"left\" bgcolor=\"#ffffff\">\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td class=\"td-button\">\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td align=\"center\"><a class=\"button\" href=\"{ticket_url}\" target=\"_blank\" rel=\"noopener\">View Ticket</a></td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<tr>\n<td class=\"signature\">\n<p>{email_signature}</p>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end copy block --> <!-- start footer -->\n<tr>\n<td class=\"p-24\" align=\"center\">\n<table class=\"footer\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start permission -->\n<tbody>\n<tr>\n<td align=\"center\">\n<p>{email_footer}</p>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end footer --></tbody>\n</table>\n<!-- end body -->\n</body>\n\n</html>', '{first_name}, {last_name}, {ticket_id}, {by_first_name}, {by_last_name}, {ticket_subject}, {ticket_message}, {ticket_reply_message}, {ticket_date_created}, {project_id}, {project_title}, {client_name}, {client_id}, {ticket_priority}, {ticket_status}, {ticket_url}', '2019-12-08 17:13:10', '2020-11-12 20:33:27', 'enabled', 'english', 'yes', 'yes', 125),
(NULL, NULL, 'Ticket Closed', 'template_lang_ticket_closed', 'client', 'tickets', 'Ticket Has Been Closed - ID', '<!DOCTYPE html>\n<html>\n\n<head>\n\n    <meta charset=\"utf-8\">\n    <meta http-equiv=\"x-ua-compatible\" content=\"ie=edge\">\n    <title>Email Confirmation</title>\n    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">\n    <style type=\"text/css\">\n        @media screen {\n            @font-face {\n                font-family: \'Source Sans Pro\';\n                font-style: normal;\n                font-weight: 400;\n                src: local(\'Source Sans Pro Regular\'), local(\'SourceSansPro-Regular\'), url(https://fonts.gstatic.com/s/sourcesanspro/v10/ODelI1aHBYDBqgeIAH2zlBM0YzuT7MdOe03otPbuUS0.woff) format(\'woff\');\n            }\n\n            @font-face {\n                font-family: \'Source Sans Pro\';\n                font-style: normal;\n                font-weight: 700;\n                src: local(\'Source Sans Pro Bold\'), local(\'SourceSansPro-Bold\'), url(https://fonts.gstatic.com/s/sourcesanspro/v10/toadOcfmlt9b38dHJxOBGFkQc6VGVFSmCnC_l7QZG60.woff) format(\'woff\');\n            }\n        }\n\n        body,\n        table,\n        td,\n        a {\n            -ms-text-size-adjust: 100%;\n            /* 1 */\n            -webkit-text-size-adjust: 100%;\n            /* 2 */\n        }\n\n        img {\n            -ms-interpolation-mode: bicubic;\n        }\n\n        a[x-apple-data-detectors] {\n            font-family: inherit !important;\n            font-size: inherit !important;\n            font-weight: inherit !important;\n            line-height: inherit !important;\n            color: inherit !important;\n            text-decoration: none !important;\n        }\n\n        div[style*=\"margin: 16px 0;\"] {\n            margin: 0 !important;\n        }\n\n        body {\n            width: 100% !important;\n            height: 100% !important;\n            padding: 0 !important;\n            margin: 0 !important;\n            padding: 24px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 16px;\n            background-color: #f9fafc;\n            color: #60676d;\n        }\n\n        table {\n            border-collapse: collapse !important;\n        }\n\n        a {\n            color: #1a82e2;\n        }\n\n        img {\n            height: auto;\n            line-height: 100%;\n            text-decoration: none;\n            border: 0;\n            outline: none;\n        }\n\n        .table-1 {\n            max-width: 600px;\n        }\n\n        .table-1 td {\n            padding: 36px 24px 40px;\n            text-align: center;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-1 h1 {\n            margin: 0;\n            font-size: 32px;\n            font-weight: 600;\n            letter-spacing: -1px;\n            line-height: 48px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-2 {\n            max-width: 600px;\n        }\n\n        .table-2 td {\n            padding: 36px 24px 0;\n            border-top: 3px solid #d4dadf;\n            background-color: #ffffff;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-2 h1 {\n            margin: 0;\n            font-size: 20px;\n            font-weight: 600;\n            letter-spacing: -1px;\n            line-height: 48px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-3 {\n            max-width: 600px;\n        }\n\n        .table-2 td {\n\n            background-color: #ffffff;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .td-1 {\n            padding: 24px;\n            font-size: 16px;\n            line-height: 24px;\n            background-color: #ffffff;\n            text-align: left;\n            padding-bottom: 10px;\n            padding-top: 0px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-gray {\n            width: 100%;\n        }\n\n        .table-gray tr {\n            height: 24px;\n        }\n\n        .table-gray .td-1 {\n            background-color: #f1f3f7;\n            width: 30%;\n            border: solid 1px #e7e9ec;\n            padding-top: 5px;\n            padding-bottom: 5px;\n            font-size:16px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-gray .td-2 {\n            background-color: #f1f3f7;\n            width: 70%;\n            border: solid 1px #e7e9ec;\n            font-size:16px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .button, .button:active, .button:visited {\n            display: inline-block;\n            padding: 16px 36px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 16px;\n            color: #ffffff;\n            text-decoration: none;\n            border-radius: 6px;\n            background-color: #1a82e2;\n            border-radius: 6px;\n        }\n\n        .signature {\n            padding: 24px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 16px;\n            line-height: 24px;\n            border-bottom: 3px solid #d4dadf;\n            background-color: #ffffff;\n        }\n\n        .footer {\n            max-width: 600px;\n        }\n\n        .footer td {\n            padding: 12px 24px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 14px;\n            line-height: 20px;\n            color: #666;\n        }\n\n        .td-button {\n            padding: 12px;\n            background-color: #ffffff;\n            text-align: center;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .p-24 {\n            padding: 24px;\n        }\n    </style>\n\n</head>\n\n<body>\n<!-- start body -->\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start hero -->\n<tbody>\n<tr>\n<td align=\"center\">\n<table class=\"table-1\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td align=\"left\">\n<h1>Ticket Closed</h1>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end hero --> <!-- start hero -->\n<tr>\n<td align=\"center\">\n<table class=\"table-2\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td align=\"left\">\n<h1>Hi {first_name},</h1>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end hero --> <!-- start copy block -->\n<tr>\n<td align=\"center\">\n<table class=\"table-3\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start copy -->\n<tbody>\n<tr>\n<td class=\"td-1\">\n<p>This ticket has now been closed.</p>\n</td>\n</tr>\n<tr>\n<td class=\"td-1\">\n<table class=\"table-gray\" cellpadding=\"5\">\n<tbody>\n<tr>\n<td class=\"td-1\"><strong>Ticket ID</strong></td>\n<td class=\"td-2\">{ticket_id}</td>\n</tr>\n<tr>\n<td class=\"td-1\"><strong>Ticket Title</strong></td>\n<td class=\"td-2\">{ticket_subject}</td>\n</tr>\n</tbody>\n</table>\n<p>If you require further assistance you can open a new support ticket.</p>\n</td>\n</tr>\n<tr>\n<td align=\"left\" bgcolor=\"#ffffff\">\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td class=\"td-button\">\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td align=\"center\"><a class=\"button\" href=\"{ticket_url}\" target=\"_blank\" rel=\"noopener\">View Ticket</a></td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<tr>\n<td class=\"signature\">\n<p>{email_signature}</p>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end copy block --> <!-- start footer -->\n<tr>\n<td class=\"p-24\" align=\"center\">\n<table class=\"footer\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start permission -->\n<tbody>\n<tr>\n<td align=\"center\">\n<p>{email_footer}</p>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end footer --></tbody>\n</table>\n<!-- end body -->\n</body>\n\n</html>', '{first_name}, {last_name}, {ticket_id}, {by_first_name}, {by_last_name}, {ticket_subject}, {ticket_message}, {ticket_date_created}, {project_id}, {project_title}, {client_name}, {client_id}, {ticket_status}, {ticket_priority}, {ticket_url}', '2019-12-08 17:13:10', '2021-11-04 15:00:31', 'enabled', 'english', 'yes', 'yes', 126),
(NULL, NULL, 'System Notification', 'template_lang_system_notification', 'admin', 'system', '{notification_subject}', '<!DOCTYPE html>\n<html>\n\n<head>\n\n    <meta charset=\"utf-8\">\n    <meta http-equiv=\"x-ua-compatible\" content=\"ie=edge\">\n    <title>Email Confirmation</title>\n    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">\n    <style type=\"text/css\">\n        @media screen {\n            @font-face {\n                font-family: \'Source Sans Pro\';\n                font-style: normal;\n                font-weight: 400;\n                src: local(\'Source Sans Pro Regular\'), local(\'SourceSansPro-Regular\'), url(https://fonts.gstatic.com/s/sourcesanspro/v10/ODelI1aHBYDBqgeIAH2zlBM0YzuT7MdOe03otPbuUS0.woff) format(\'woff\');\n            }\n\n            @font-face {\n                font-family: \'Source Sans Pro\';\n                font-style: normal;\n                font-weight: 700;\n                src: local(\'Source Sans Pro Bold\'), local(\'SourceSansPro-Bold\'), url(https://fonts.gstatic.com/s/sourcesanspro/v10/toadOcfmlt9b38dHJxOBGFkQc6VGVFSmCnC_l7QZG60.woff) format(\'woff\');\n            }\n        }\n\n        body,\n        table,\n        td,\n        a {\n            -ms-text-size-adjust: 100%;\n            /* 1 */\n            -webkit-text-size-adjust: 100%;\n            /* 2 */\n        }\n\n        img {\n            -ms-interpolation-mode: bicubic;\n        }\n\n        a[x-apple-data-detectors] {\n            font-family: inherit !important;\n            font-size: inherit !important;\n            font-weight: inherit !important;\n            line-height: inherit !important;\n            color: inherit !important;\n            text-decoration: none !important;\n        }\n\n        div[style*=\"margin: 16px 0;\"] {\n            margin: 0 !important;\n        }\n\n        body {\n            width: 100% !important;\n            height: 100% !important;\n            padding: 0 !important;\n            margin: 0 !important;\n            padding: 24px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 16px;\n            background-color: #f9fafc;\n            color: #60676d;\n        }\n\n        table {\n            border-collapse: collapse !important;\n        }\n\n        a {\n            color: #1a82e2;\n        }\n\n        img {\n            height: auto;\n            line-height: 100%;\n            text-decoration: none;\n            border: 0;\n            outline: none;\n        }\n\n        .table-1 {\n            max-width: 600px;\n        }\n\n        .table-1 td {\n            padding: 36px 24px 40px;\n            text-align: center;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-1 h1 {\n            margin: 0;\n            font-size: 32px;\n            font-weight: 600;\n            letter-spacing: -1px;\n            line-height: 48px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-2 {\n            max-width: 600px;\n        }\n\n        .table-2 td {\n            padding: 36px 24px 0;\n            border-top: 3px solid #d4dadf;\n            background-color: #ffffff;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-2 h1 {\n            margin: 0;\n            font-size: 20px;\n            font-weight: 600;\n            letter-spacing: -1px;\n            line-height: 48px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-3 {\n            max-width: 600px;\n        }\n\n        .table-2 td {\n\n            background-color: #ffffff;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .td-1 {\n            padding: 24px;\n            font-size: 16px;\n            line-height: 24px;\n            background-color: #ffffff;\n            text-align: left;\n            padding-bottom: 10px;\n            padding-top: 0px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-gray {\n            width: 100%;\n        }\n\n        .table-gray tr {\n            height: 24px;\n        }\n\n        .table-gray .td-1 {\n            background-color: #f1f3f7;\n            width: 30%;\n            border: solid 1px #e7e9ec;\n            padding-top: 5px;\n            padding-bottom: 5px;\n            font-size:16px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-gray .td-2 {\n            background-color: #f1f3f7;\n            width: 70%;\n            border: solid 1px #e7e9ec;\n            font-size:16px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .button, .button:active, .button:visited {\n            display: inline-block;\n            padding: 16px 36px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 16px;\n            color: #ffffff;\n            text-decoration: none;\n            border-radius: 6px;\n            background-color: #1a82e2;\n            border-radius: 6px;\n        }\n\n        .signature {\n            padding: 24px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 16px;\n            line-height: 24px;\n            border-bottom: 3px solid #d4dadf;\n            background-color: #ffffff;\n        }\n\n        .footer {\n            max-width: 600px;\n        }\n\n        .footer td {\n            padding: 12px 24px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 14px;\n            line-height: 20px;\n            color: #666;\n        }\n\n        .td-button {\n            padding: 12px;\n            background-color: #ffffff;\n            text-align: center;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .p-24 {\n            padding: 24px;\n        }\n    </style>\n\n</head>\n\n<body>\n<!-- start body -->\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start hero -->\n<tbody>\n<tr>\n<td align=\"center\">\n<table class=\"table-1\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td align=\"left\">\n<h1>{notification_title}</h1>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end hero --> <!-- start hero -->\n<tr>\n<td align=\"center\">\n<table class=\"table-2\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td align=\"left\">\n<h1>Hi {first_name},</h1>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end hero --> <!-- start copy block -->\n<tr>\n<td align=\"center\">\n<table class=\"table-3\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start copy -->\n<tbody>\n<tr>\n<td class=\"td-1\">\n<p>{notification_message}</p>\n</td>\n</tr>\n<tr>\n<td align=\"left\" bgcolor=\"#ffffff\">&nbsp;</td>\n</tr>\n<tr>\n<td class=\"signature\">\n<p>{email_signature}</p>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end copy block --> <!-- start footer -->\n<tr>\n<td class=\"p-24\" align=\"center\">\n<table class=\"footer\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start permission -->\n<tbody>\n<tr>\n<td align=\"center\">\n<p>{email_footer}</p>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end footer --></tbody>\n</table>\n<!-- end body -->\n</body>\n\n</html>', '{first_name}, {last_name}, {notification_title}, {notification_subject}, {notification_message}', '2019-12-08 17:13:10', '2020-11-12 20:37:25', 'enabled', 'english', 'yes', 'yes', 127),
(NULL, NULL, 'Task Comment', 'template_lang_task_comment', 'everyone', 'tasks', 'New Task Comment', '<!DOCTYPE html>\n<html>\n\n<head>\n\n    <meta charset=\"utf-8\">\n    <meta http-equiv=\"x-ua-compatible\" content=\"ie=edge\">\n    <title>Email Confirmation</title>\n    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">\n    <style type=\"text/css\">\n        @media screen {\n            @font-face {\n                font-family: \'Source Sans Pro\';\n                font-style: normal;\n                font-weight: 400;\n                src: local(\'Source Sans Pro Regular\'), local(\'SourceSansPro-Regular\'), url(https://fonts.gstatic.com/s/sourcesanspro/v10/ODelI1aHBYDBqgeIAH2zlBM0YzuT7MdOe03otPbuUS0.woff) format(\'woff\');\n            }\n\n            @font-face {\n                font-family: \'Source Sans Pro\';\n                font-style: normal;\n                font-weight: 700;\n                src: local(\'Source Sans Pro Bold\'), local(\'SourceSansPro-Bold\'), url(https://fonts.gstatic.com/s/sourcesanspro/v10/toadOcfmlt9b38dHJxOBGFkQc6VGVFSmCnC_l7QZG60.woff) format(\'woff\');\n            }\n        }\n\n        body,\n        table,\n        td,\n        a {\n            -ms-text-size-adjust: 100%;\n            /* 1 */\n            -webkit-text-size-adjust: 100%;\n            /* 2 */\n        }\n\n        img {\n            -ms-interpolation-mode: bicubic;\n        }\n\n        a[x-apple-data-detectors] {\n            font-family: inherit !important;\n            font-size: inherit !important;\n            font-weight: inherit !important;\n            line-height: inherit !important;\n            color: inherit !important;\n            text-decoration: none !important;\n        }\n\n        div[style*=\"margin: 16px 0;\"] {\n            margin: 0 !important;\n        }\n\n        body {\n            width: 100% !important;\n            height: 100% !important;\n            padding: 0 !important;\n            margin: 0 !important;\n            padding: 24px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 16px;\n            background-color: #f9fafc;\n            color: #60676d;\n        }\n\n        table {\n            border-collapse: collapse !important;\n        }\n\n        a {\n            color: #1a82e2;\n        }\n\n        img {\n            height: auto;\n            line-height: 100%;\n            text-decoration: none;\n            border: 0;\n            outline: none;\n        }\n\n        .table-1 {\n            max-width: 600px;\n        }\n\n        .table-1 td {\n            padding: 36px 24px 40px;\n            text-align: center;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-1 h1 {\n            margin: 0;\n            font-size: 32px;\n            font-weight: 600;\n            letter-spacing: -1px;\n            line-height: 48px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-2 {\n            max-width: 600px;\n        }\n\n        .table-2 td {\n            padding: 36px 24px 0;\n            border-top: 3px solid #d4dadf;\n            background-color: #ffffff;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-2 h1 {\n            margin: 0;\n            font-size: 20px;\n            font-weight: 600;\n            letter-spacing: -1px;\n            line-height: 48px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-3 {\n            max-width: 600px;\n        }\n\n        .table-2 td {\n\n            background-color: #ffffff;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .td-1 {\n            padding: 24px;\n            font-size: 16px;\n            line-height: 24px;\n            background-color: #ffffff;\n            text-align: left;\n            padding-bottom: 10px;\n            padding-top: 0px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-gray {\n            width: 100%;\n        }\n\n        .table-gray tr {\n            height: 24px;\n        }\n\n        .table-gray .td-1 {\n            background-color: #f1f3f7;\n            width: 30%;\n            border: solid 1px #e7e9ec;\n            padding-top: 5px;\n            padding-bottom: 5px;\n            font-size:16px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-gray .td-2 {\n            background-color: #f1f3f7;\n            width: 70%;\n            border: solid 1px #e7e9ec;\n            font-size:16px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .button, .button:active, .button:visited {\n            display: inline-block;\n            padding: 16px 36px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 16px;\n            color: #ffffff;\n            text-decoration: none;\n            border-radius: 6px;\n            background-color: #1a82e2;\n            border-radius: 6px;\n        }\n\n        .signature {\n            padding: 24px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 16px;\n            line-height: 24px;\n            border-bottom: 3px solid #d4dadf;\n            background-color: #ffffff;\n        }\n\n        .footer {\n            max-width: 600px;\n        }\n\n        .footer td {\n            padding: 12px 24px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 14px;\n            line-height: 20px;\n            color: #666;\n        }\n\n        .td-button {\n            padding: 12px;\n            background-color: #ffffff;\n            text-align: center;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .p-24 {\n            padding: 24px;\n        }\n    </style>\n\n</head>\n\n<body>\n<!-- start body -->\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start hero -->\n<tbody>\n<tr>\n<td align=\"center\">\n<table class=\"table-1\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td align=\"left\">\n<h1>New Comment</h1>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end hero --> <!-- start hero -->\n<tr>\n<td align=\"center\">\n<table class=\"table-2\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td align=\"left\">\n<h1>Hi {first_name},</h1>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end hero --> <!-- start copy block -->\n<tr>\n<td align=\"center\">\n<table class=\"table-3\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start copy -->\n<tbody>\n<tr>\n<td class=\"td-1\">\n<p>A new comment has just been posted on this project.</p>\n</td>\n</tr>\n<tr>\n<td class=\"td-1\">\n<table class=\"table-gray\" cellpadding=\"5\">\n<tbody>\n<tr>\n<td class=\"td-1\"><strong>Task</strong></td>\n<td class=\"td-2\">{task_title}</td>\n</tr>\n<tr>\n<td class=\"td-1\"><strong>Posted By</strong></td>\n<td class=\"td-2\">{poster_first_name}</td>\n</tr>\n<tr>\n<td class=\"td-2\" colspan=\"2\">{comment}</td>\n</tr>\n</tbody>\n</table>\n<p>You can manage your task via the dashboard.</p>\n</td>\n</tr>\n<tr>\n<td align=\"left\" bgcolor=\"#ffffff\">\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td class=\"td-button\">\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td align=\"center\"><a class=\"button\" href=\"{task_url}\" target=\"_blank\" rel=\"noopener\">View Task</a></td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<tr>\n<td class=\"signature\">\n<p>{email_signature}</p>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end copy block --> <!-- start footer -->\n<tr>\n<td class=\"p-24\" align=\"center\">\n<table class=\"footer\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start permission -->\n<tbody>\n<tr>\n<td align=\"center\">\n<p>{email_footer}</p>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end footer --></tbody>\n</table>\n<!-- end body -->\n</body>\n\n</html>', '{first_name}, {last_name}, {comment}, {poster_first_name}, {poster_last_name}, {task_id}, {task_title}, {task_created_date}, {task_date_start}, {task_description}, {task_date_due}, {project_title}, {project_id}, {client_name}, {client_id}, {task_status}, {task_milestone}, {task_url}', '2019-12-08 17:13:10', '2020-11-13 08:18:31', 'enabled', 'english', 'yes', 'yes', 128),
(NULL, NULL, 'Estimate Accepted', 'template_lang_estimate_accepted', 'team', 'estimates', 'Estimate Accepted - #{estimate_id}', '<!DOCTYPE html>\n<html>\n\n<head>\n\n    <meta charset=\"utf-8\">\n    <meta http-equiv=\"x-ua-compatible\" content=\"ie=edge\">\n    <title>Email Confirmation</title>\n    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">\n    <style type=\"text/css\">\n        @media screen {\n            @font-face {\n                font-family: \'Source Sans Pro\';\n                font-style: normal;\n                font-weight: 400;\n                src: local(\'Source Sans Pro Regular\'), local(\'SourceSansPro-Regular\'), url(https://fonts.gstatic.com/s/sourcesanspro/v10/ODelI1aHBYDBqgeIAH2zlBM0YzuT7MdOe03otPbuUS0.woff) format(\'woff\');\n            }\n\n            @font-face {\n                font-family: \'Source Sans Pro\';\n                font-style: normal;\n                font-weight: 700;\n                src: local(\'Source Sans Pro Bold\'), local(\'SourceSansPro-Bold\'), url(https://fonts.gstatic.com/s/sourcesanspro/v10/toadOcfmlt9b38dHJxOBGFkQc6VGVFSmCnC_l7QZG60.woff) format(\'woff\');\n            }\n        }\n\n        body,\n        table,\n        td,\n        a {\n            -ms-text-size-adjust: 100%;\n            /* 1 */\n            -webkit-text-size-adjust: 100%;\n            /* 2 */\n        }\n\n        img {\n            -ms-interpolation-mode: bicubic;\n        }\n\n        a[x-apple-data-detectors] {\n            font-family: inherit !important;\n            font-size: inherit !important;\n            font-weight: inherit !important;\n            line-height: inherit !important;\n            color: inherit !important;\n            text-decoration: none !important;\n        }\n\n        div[style*=\"margin: 16px 0;\"] {\n            margin: 0 !important;\n        }\n\n        body {\n            width: 100% !important;\n            height: 100% !important;\n            padding: 0 !important;\n            margin: 0 !important;\n            padding: 24px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 16px;\n            background-color: #f9fafc;\n            color: #60676d;\n        }\n\n        table {\n            border-collapse: collapse !important;\n        }\n\n        a {\n            color: #1a82e2;\n        }\n\n        img {\n            height: auto;\n            line-height: 100%;\n            text-decoration: none;\n            border: 0;\n            outline: none;\n        }\n\n        .table-1 {\n            max-width: 600px;\n        }\n\n        .table-1 td {\n            padding: 36px 24px 40px;\n            text-align: center;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-1 h1 {\n            margin: 0;\n            font-size: 32px;\n            font-weight: 600;\n            letter-spacing: -1px;\n            line-height: 48px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-2 {\n            max-width: 600px;\n        }\n\n        .table-2 td {\n            padding: 36px 24px 0;\n            border-top: 3px solid #d4dadf;\n            background-color: #ffffff;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-2 h1 {\n            margin: 0;\n            font-size: 20px;\n            font-weight: 600;\n            letter-spacing: -1px;\n            line-height: 48px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-3 {\n            max-width: 600px;\n        }\n\n        .table-2 td {\n\n            background-color: #ffffff;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .td-1 {\n            padding: 24px;\n            font-size: 16px;\n            line-height: 24px;\n            background-color: #ffffff;\n            text-align: left;\n            padding-bottom: 10px;\n            padding-top: 0px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-gray {\n            width: 100%;\n        }\n\n        .table-gray tr {\n            height: 24px;\n        }\n\n        .table-gray .td-1 {\n            background-color: #f1f3f7;\n            width: 30%;\n            border: solid 1px #e7e9ec;\n            padding-top: 5px;\n            padding-bottom: 5px;\n            font-size:16px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-gray .td-2 {\n            background-color: #f1f3f7;\n            width: 70%;\n            border: solid 1px #e7e9ec;\n            font-size:16px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .button, .button:active, .button:visited {\n            display: inline-block;\n            padding: 16px 36px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 16px;\n            color: #ffffff;\n            text-decoration: none;\n            border-radius: 6px;\n            background-color: #1a82e2;\n            border-radius: 6px;\n        }\n\n        .signature {\n            padding: 24px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 16px;\n            line-height: 24px;\n            border-bottom: 3px solid #d4dadf;\n            background-color: #ffffff;\n        }\n\n        .footer {\n            max-width: 600px;\n        }\n\n        .footer td {\n            padding: 12px 24px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 14px;\n            line-height: 20px;\n            color: #666;\n        }\n\n        .td-button {\n            padding: 12px;\n            background-color: #ffffff;\n            text-align: center;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .p-24 {\n            padding: 24px;\n        }\n    </style>\n\n</head>\n\n<body>\n<!-- start body -->\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start hero -->\n<tbody>\n<tr>\n<td align=\"center\">\n<table class=\"table-1\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td align=\"left\">\n<h1>Estimate Accepted</h1>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end hero --> <!-- start hero -->\n<tr>\n<td align=\"center\">\n<table class=\"table-2\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td align=\"left\">\n<h1>Hi {first_name},</h1>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end hero --> <!-- start copy block -->\n<tr>\n<td align=\"center\">\n<table class=\"table-3\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start copy -->\n<tbody>\n<tr>\n<td class=\"td-1\">\n<p>Great news, {client_name} has just accepted this Estimate.</p>\n</td>\n</tr>\n<tr>\n<td class=\"td-1\">\n<table class=\"table-gray\" cellpadding=\"5\">\n<tbody>\n<tr>\n<td class=\"td-1\"><strong>Estimate ID</strong></td>\n<td class=\"td-2\">{estimate_id}</td>\n</tr>\n<tr>\n<td class=\"td-1\"><strong>Estimate Amount</strong></td>\n<td class=\"td-2\">{estimate_amount}</td>\n</tr>\n<tr>\n<td class=\"td-1\"><strong>Project Title</strong></td>\n<td class=\"td-2\">{project_title}</td>\n</tr>\n</tbody>\n</table>\n<p>You can manage this estimate via the dashboard.</p>\n</td>\n</tr>\n<tr>\n<td align=\"left\" bgcolor=\"#ffffff\">\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td class=\"td-button\">\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td align=\"center\"><a class=\"button\" href=\"{estimate_url}\" target=\"_blank\" rel=\"noopener\">View Estimate</a></td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<tr>\n<td class=\"signature\">\n<p>{email_signature}</p>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end copy block --> <!-- start footer -->\n<tr>\n<td class=\"p-24\" align=\"center\">\n<table class=\"footer\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start permission -->\n<tbody>\n<tr>\n<td align=\"center\">\n<p>{email_footer}</p>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end footer --></tbody>\n</table>\n<!-- end body -->\n</body>\n\n</html>', '{first_name}, {last_name}, {estimate_id}, {estimate_amount}, {estimate_date_created}, {estimate_expiry_date}, {project_id}, {project_title}, {client_name}, {client_id}, {estimate_status}, {estimate_url}', '2019-12-08 17:13:10', '2020-11-12 20:20:09', 'enabled', 'english', 'yes', 'yes', 129);
INSERT INTO `email_templates` (`emailtemplate_module_unique_id`, `emailtemplate_module_name`, `emailtemplate_name`, `emailtemplate_lang`, `emailtemplate_type`, `emailtemplate_category`, `emailtemplate_subject`, `emailtemplate_body`, `emailtemplate_variables`, `emailtemplate_created`, `emailtemplate_updated`, `emailtemplate_status`, `emailtemplate_language`, `emailtemplate_real_template`, `emailtemplate_show_enabled`, `emailtemplate_id`) VALUES
(NULL, NULL, 'Estimate Declined', 'template_lang_estimate_declined', 'team', 'estimates', 'Estimate Declined - #{estimate_id}', '<!DOCTYPE html>\n<html>\n\n<head>\n\n    <meta charset=\"utf-8\">\n    <meta http-equiv=\"x-ua-compatible\" content=\"ie=edge\">\n    <title>Email Confirmation</title>\n    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">\n    <style type=\"text/css\">\n        @media screen {\n            @font-face {\n                font-family: \'Source Sans Pro\';\n                font-style: normal;\n                font-weight: 400;\n                src: local(\'Source Sans Pro Regular\'), local(\'SourceSansPro-Regular\'), url(https://fonts.gstatic.com/s/sourcesanspro/v10/ODelI1aHBYDBqgeIAH2zlBM0YzuT7MdOe03otPbuUS0.woff) format(\'woff\');\n            }\n\n            @font-face {\n                font-family: \'Source Sans Pro\';\n                font-style: normal;\n                font-weight: 700;\n                src: local(\'Source Sans Pro Bold\'), local(\'SourceSansPro-Bold\'), url(https://fonts.gstatic.com/s/sourcesanspro/v10/toadOcfmlt9b38dHJxOBGFkQc6VGVFSmCnC_l7QZG60.woff) format(\'woff\');\n            }\n        }\n\n        body,\n        table,\n        td,\n        a {\n            -ms-text-size-adjust: 100%;\n            /* 1 */\n            -webkit-text-size-adjust: 100%;\n            /* 2 */\n        }\n\n        img {\n            -ms-interpolation-mode: bicubic;\n        }\n\n        a[x-apple-data-detectors] {\n            font-family: inherit !important;\n            font-size: inherit !important;\n            font-weight: inherit !important;\n            line-height: inherit !important;\n            color: inherit !important;\n            text-decoration: none !important;\n        }\n\n        div[style*=\"margin: 16px 0;\"] {\n            margin: 0 !important;\n        }\n\n        body {\n            width: 100% !important;\n            height: 100% !important;\n            padding: 0 !important;\n            margin: 0 !important;\n            padding: 24px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 16px;\n            background-color: #f9fafc;\n            color: #60676d;\n        }\n\n        table {\n            border-collapse: collapse !important;\n        }\n\n        a {\n            color: #1a82e2;\n        }\n\n        img {\n            height: auto;\n            line-height: 100%;\n            text-decoration: none;\n            border: 0;\n            outline: none;\n        }\n\n        .table-1 {\n            max-width: 600px;\n        }\n\n        .table-1 td {\n            padding: 36px 24px 40px;\n            text-align: center;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-1 h1 {\n            margin: 0;\n            font-size: 32px;\n            font-weight: 600;\n            letter-spacing: -1px;\n            line-height: 48px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-2 {\n            max-width: 600px;\n        }\n\n        .table-2 td {\n            padding: 36px 24px 0;\n            border-top: 3px solid #d4dadf;\n            background-color: #ffffff;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-2 h1 {\n            margin: 0;\n            font-size: 20px;\n            font-weight: 600;\n            letter-spacing: -1px;\n            line-height: 48px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-3 {\n            max-width: 600px;\n        }\n\n        .table-2 td {\n\n            background-color: #ffffff;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .td-1 {\n            padding: 24px;\n            font-size: 16px;\n            line-height: 24px;\n            background-color: #ffffff;\n            text-align: left;\n            padding-bottom: 10px;\n            padding-top: 0px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-gray {\n            width: 100%;\n        }\n\n        .table-gray tr {\n            height: 24px;\n        }\n\n        .table-gray .td-1 {\n            background-color: #f1f3f7;\n            width: 30%;\n            border: solid 1px #e7e9ec;\n            padding-top: 5px;\n            padding-bottom: 5px;\n            font-size:16px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-gray .td-2 {\n            background-color: #f1f3f7;\n            width: 70%;\n            border: solid 1px #e7e9ec;\n            font-size:16px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .button, .button:active, .button:visited {\n            display: inline-block;\n            padding: 16px 36px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 16px;\n            color: #ffffff;\n            text-decoration: none;\n            border-radius: 6px;\n            background-color: #1a82e2;\n            border-radius: 6px;\n        }\n\n        .signature {\n            padding: 24px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 16px;\n            line-height: 24px;\n            border-bottom: 3px solid #d4dadf;\n            background-color: #ffffff;\n        }\n\n        .footer {\n            max-width: 600px;\n        }\n\n        .footer td {\n            padding: 12px 24px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 14px;\n            line-height: 20px;\n            color: #666;\n        }\n\n        .td-button {\n            padding: 12px;\n            background-color: #ffffff;\n            text-align: center;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .p-24 {\n            padding: 24px;\n        }\n    </style>\n\n</head>\n\n<body>\n<!-- start body -->\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start hero -->\n<tbody>\n<tr>\n<td align=\"center\">\n<table class=\"table-1\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td align=\"left\">\n<h1>Estimate Declined</h1>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end hero --> <!-- start hero -->\n<tr>\n<td align=\"center\">\n<table class=\"table-2\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td align=\"left\">\n<h1>Hi {first_name},</h1>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end hero --> <!-- start copy block -->\n<tr>\n<td align=\"center\">\n<table class=\"table-3\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start copy -->\n<tbody>\n<tr>\n<td class=\"td-1\">\n<p>Unfortunately,&nbsp;{client_name} has just declined this estimate.</p>\n</td>\n</tr>\n<tr>\n<td class=\"td-1\">\n<table class=\"table-gray\" cellpadding=\"5\">\n<tbody>\n<tr>\n<td class=\"td-1\"><strong>Estimate ID</strong></td>\n<td class=\"td-2\">{estimate_id}</td>\n</tr>\n<tr>\n<td class=\"td-1\"><strong>Estimate Amount</strong></td>\n<td class=\"td-2\">{estimate_amount}</td>\n</tr>\n<tr>\n<td class=\"td-1\"><strong>Project Title</strong></td>\n<td class=\"td-2\">{project_title}</td>\n</tr>\n</tbody>\n</table>\n<p>You can manage your project via the dashboard.</p>\n</td>\n</tr>\n<tr>\n<td align=\"left\" bgcolor=\"#ffffff\">\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td class=\"td-button\">\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td align=\"center\"><a class=\"button\" href=\"{estimate_url}\" target=\"_blank\" rel=\"noopener\">View Estimate</a></td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<tr>\n<td class=\"signature\">\n<p>{email_signature}</p>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end copy block --> <!-- start footer -->\n<tr>\n<td class=\"p-24\" align=\"center\">\n<table class=\"footer\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start permission -->\n<tbody>\n<tr>\n<td align=\"center\">\n<p>{email_footer}</p>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end footer --></tbody>\n</table>\n<!-- end body -->\n</body>\n\n</html>', '{first_name}, {last_name}, {estimate_id}, {estimate_amount}, {estimate_date_created}, {estimate_expiry_date}, {project_id}, {project_title}, {client_name}, {client_id}, {estimate_status}, {estimate_url}', '2019-12-08 17:13:10', '2020-11-13 08:25:00', 'enabled', 'english', 'yes', 'yes', 130),
(NULL, NULL, 'Estimate Revised', 'template_lang_estimate_revised', 'client', 'estimates', 'Estimate Revised - #{estimate_id}', '<!DOCTYPE html>\n<html>\n\n<head>\n\n    <meta charset=\"utf-8\">\n    <meta http-equiv=\"x-ua-compatible\" content=\"ie=edge\">\n    <title>Email Confirmation</title>\n    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">\n    <style type=\"text/css\">\n        @media screen {\n            @font-face {\n                font-family: \'Source Sans Pro\';\n                font-style: normal;\n                font-weight: 400;\n                src: local(\'Source Sans Pro Regular\'), local(\'SourceSansPro-Regular\'), url(https://fonts.gstatic.com/s/sourcesanspro/v10/ODelI1aHBYDBqgeIAH2zlBM0YzuT7MdOe03otPbuUS0.woff) format(\'woff\');\n            }\n\n            @font-face {\n                font-family: \'Source Sans Pro\';\n                font-style: normal;\n                font-weight: 700;\n                src: local(\'Source Sans Pro Bold\'), local(\'SourceSansPro-Bold\'), url(https://fonts.gstatic.com/s/sourcesanspro/v10/toadOcfmlt9b38dHJxOBGFkQc6VGVFSmCnC_l7QZG60.woff) format(\'woff\');\n            }\n        }\n\n        body,\n        table,\n        td,\n        a {\n            -ms-text-size-adjust: 100%;\n            /* 1 */\n            -webkit-text-size-adjust: 100%;\n            /* 2 */\n        }\n\n        img {\n            -ms-interpolation-mode: bicubic;\n        }\n\n        a[x-apple-data-detectors] {\n            font-family: inherit !important;\n            font-size: inherit !important;\n            font-weight: inherit !important;\n            line-height: inherit !important;\n            color: inherit !important;\n            text-decoration: none !important;\n        }\n\n        div[style*=\"margin: 16px 0;\"] {\n            margin: 0 !important;\n        }\n\n        body {\n            width: 100% !important;\n            height: 100% !important;\n            padding: 0 !important;\n            margin: 0 !important;\n            padding: 24px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 16px;\n            background-color: #f9fafc;\n            color: #60676d;\n        }\n\n        table {\n            border-collapse: collapse !important;\n        }\n\n        a {\n            color: #1a82e2;\n        }\n\n        img {\n            height: auto;\n            line-height: 100%;\n            text-decoration: none;\n            border: 0;\n            outline: none;\n        }\n\n        .table-1 {\n            max-width: 600px;\n        }\n\n        .table-1 td {\n            padding: 36px 24px 40px;\n            text-align: center;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-1 h1 {\n            margin: 0;\n            font-size: 32px;\n            font-weight: 600;\n            letter-spacing: -1px;\n            line-height: 48px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-2 {\n            max-width: 600px;\n        }\n\n        .table-2 td {\n            padding: 36px 24px 0;\n            border-top: 3px solid #d4dadf;\n            background-color: #ffffff;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-2 h1 {\n            margin: 0;\n            font-size: 20px;\n            font-weight: 600;\n            letter-spacing: -1px;\n            line-height: 48px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-3 {\n            max-width: 600px;\n        }\n\n        .table-2 td {\n\n            background-color: #ffffff;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .td-1 {\n            padding: 24px;\n            font-size: 16px;\n            line-height: 24px;\n            background-color: #ffffff;\n            text-align: left;\n            padding-bottom: 10px;\n            padding-top: 0px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-gray {\n            width: 100%;\n        }\n\n        .table-gray tr {\n            height: 24px;\n        }\n\n        .table-gray .td-1 {\n            background-color: #f1f3f7;\n            width: 30%;\n            border: solid 1px #e7e9ec;\n            padding-top: 5px;\n            padding-bottom: 5px;\n            font-size:16px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-gray .td-2 {\n            background-color: #f1f3f7;\n            width: 70%;\n            border: solid 1px #e7e9ec;\n            font-size:16px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .button, .button:active, .button:visited {\n            display: inline-block;\n            padding: 16px 36px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 16px;\n            color: #ffffff;\n            text-decoration: none;\n            border-radius: 6px;\n            background-color: #1a82e2;\n            border-radius: 6px;\n        }\n\n        .signature {\n            padding: 24px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 16px;\n            line-height: 24px;\n            border-bottom: 3px solid #d4dadf;\n            background-color: #ffffff;\n        }\n\n        .footer {\n            max-width: 600px;\n        }\n\n        .footer td {\n            padding: 12px 24px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 14px;\n            line-height: 20px;\n            color: #666;\n        }\n\n        .td-button {\n            padding: 12px;\n            background-color: #ffffff;\n            text-align: center;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .p-24 {\n            padding: 24px;\n        }\n    </style>\n\n</head>\n\n<body>\n<!-- start body -->\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start hero -->\n<tbody>\n<tr>\n<td align=\"center\">\n<table class=\"table-1\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td align=\"left\">\n<h1>Estimate Revised</h1>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end hero --> <!-- start hero -->\n<tr>\n<td align=\"center\">\n<table class=\"table-2\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td align=\"left\">\n<h1>Hi {first_name},</h1>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end hero --> <!-- start copy block -->\n<tr>\n<td align=\"center\">\n<table class=\"table-3\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start copy -->\n<tbody>\n<tr>\n<td class=\"td-1\">\n<p>Great news, we have just revised your estimate. The revised estimate is attached to this email.</p>\n</td>\n</tr>\n<tr>\n<td class=\"td-1\">\n<table class=\"table-gray\" cellpadding=\"5\">\n<tbody>\n<tr>\n<td class=\"td-1\"><strong>Estimate ID</strong></td>\n<td class=\"td-2\">{estimate_id}</td>\n</tr>\n<tr>\n<td class=\"td-1\"><strong>Estimate Amount</strong></td>\n<td class=\"td-2\">{estimate_amount}</td>\n</tr>\n<tr>\n<td class=\"td-1\"><strong>Project Title</strong></td>\n<td class=\"td-2\">{project_title}</td>\n</tr>\n</tbody>\n</table>\n<p>You can review this estimate via the dashboard.</p>\n</td>\n</tr>\n<tr>\n<td align=\"left\" bgcolor=\"#ffffff\">\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td class=\"td-button\">\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td align=\"center\"><a class=\"button\" href=\"{estimate_url}\" target=\"_blank\" rel=\"noopener\">View Estimate</a></td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<tr>\n<td class=\"signature\">\n<p>{email_signature}</p>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end copy block --> <!-- start footer -->\n<tr>\n<td class=\"p-24\" align=\"center\">\n<table class=\"footer\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start permission -->\n<tbody>\n<tr>\n<td align=\"center\">\n<p>{email_footer}</p>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end footer --></tbody>\n</table>\n<!-- end body -->\n</body>\n\n</html>', '{first_name}, {last_name}, {estimate_id}, {estimate_amount}, {estimate_date_created}, {estimate_expiry_date}, {project_id}, {project_title}, {client_name}, {client_id}, {estimate_status}, {estimate_url}', '2019-12-08 17:13:10', '2020-11-12 20:26:04', 'enabled', 'english', 'yes', 'yes', 131),
(NULL, NULL, 'New Subscription Created', 'template_lang_new_subscription_created', 'client', 'subscriptions', 'New Subscription Created', '<!DOCTYPE html>\n<html>\n\n<head>\n\n    <meta charset=\"utf-8\">\n    <meta http-equiv=\"x-ua-compatible\" content=\"ie=edge\">\n    <title>Email Confirmation</title>\n    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">\n    <style type=\"text/css\">\n        @media screen {\n            @font-face {\n                font-family: \'Source Sans Pro\';\n                font-style: normal;\n                font-weight: 400;\n                src: local(\'Source Sans Pro Regular\'), local(\'SourceSansPro-Regular\'), url(https://fonts.gstatic.com/s/sourcesanspro/v10/ODelI1aHBYDBqgeIAH2zlBM0YzuT7MdOe03otPbuUS0.woff) format(\'woff\');\n            }\n\n            @font-face {\n                font-family: \'Source Sans Pro\';\n                font-style: normal;\n                font-weight: 700;\n                src: local(\'Source Sans Pro Bold\'), local(\'SourceSansPro-Bold\'), url(https://fonts.gstatic.com/s/sourcesanspro/v10/toadOcfmlt9b38dHJxOBGFkQc6VGVFSmCnC_l7QZG60.woff) format(\'woff\');\n            }\n        }\n\n        body,\n        table,\n        td,\n        a {\n            -ms-text-size-adjust: 100%;\n            /* 1 */\n            -webkit-text-size-adjust: 100%;\n            /* 2 */\n        }\n\n        img {\n            -ms-interpolation-mode: bicubic;\n        }\n\n        a[x-apple-data-detectors] {\n            font-family: inherit !important;\n            font-size: inherit !important;\n            font-weight: inherit !important;\n            line-height: inherit !important;\n            color: inherit !important;\n            text-decoration: none !important;\n        }\n\n        div[style*=\"margin: 16px 0;\"] {\n            margin: 0 !important;\n        }\n\n        body {\n            width: 100% !important;\n            height: 100% !important;\n            padding: 0 !important;\n            margin: 0 !important;\n            padding: 24px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 16px;\n            background-color: #f9fafc;\n            color: #60676d;\n        }\n\n        table {\n            border-collapse: collapse !important;\n        }\n\n        a {\n            color: #1a82e2;\n        }\n\n        img {\n            height: auto;\n            line-height: 100%;\n            text-decoration: none;\n            border: 0;\n            outline: none;\n        }\n\n        .table-1 {\n            max-width: 600px;\n        }\n\n        .table-1 td {\n            padding: 36px 24px 40px;\n            text-align: center;\n        }\n\n        .table-1 h1 {\n            margin: 0;\n            font-size: 32px;\n            font-weight: 600;\n            letter-spacing: -1px;\n            line-height: 48px;\n        }\n\n        .table-2 {\n            max-width: 600px;\n        }\n\n        .table-2 td {\n            padding: 36px 24px 0;\n            border-top: 3px solid #d4dadf;\n            background-color: #ffffff;\n        }\n\n        .table-2 h1 {\n            margin: 0;\n            font-size: 20px;\n            font-weight: 600;\n            letter-spacing: -1px;\n            line-height: 48px;\n        }\n\n        .table-3 {\n            max-width: 600px;\n        }\n\n        .table-2 td {\n\n            background-color: #ffffff;\n        }\n\n        .td-1 {\n            padding: 24px;\n            font-size: 16px;\n            line-height: 24px;\n            background-color: #ffffff;\n            text-align: left;\n            padding-bottom: 10px;\n            padding-top: 0px;\n        }\n\n        .table-gray {\n            width: 100%;\n        }\n\n        .table-gray tr {\n            height: 24px;\n        }\n\n        .table-gray .td-1 {\n            background-color: #f1f3f7;\n            width: 30%;\n            border: solid 1px #e7e9ec;\n            padding-top: 5px;\n            padding-bottom: 5px;\n            font-size:16px;\n        }\n\n        .table-gray .td-2 {\n            background-color: #f1f3f7;\n            width: 70%;\n            border: solid 1px #e7e9ec;\n            font-size:16px;\n        }\n\n        .button, .button:active, .button:visited {\n            display: inline-block;\n            padding: 16px 36px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 16px;\n            color: #ffffff;\n            text-decoration: none;\n            border-radius: 6px;\n            background-color: #1a82e2;\n            border-radius: 6px;\n        }\n\n        .signature {\n            padding: 24px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 16px;\n            line-height: 24px;\n            border-bottom: 3px solid #d4dadf;\n            background-color: #ffffff;\n        }\n\n        .footer {\n            max-width: 600px;\n        }\n\n        .footer td {\n            padding: 12px 24px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 14px;\n            line-height: 20px;\n            color: #666;\n        }\n\n        .td-button {\n            padding: 12px;\n            background-color: #ffffff;\n            text-align: center;\n        }\n\n        .p-24 {\n            padding: 24px;\n        }\n    </style>\n\n</head>\n\n<body>\n<!-- start body -->\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start hero -->\n<tbody>\n<tr>\n<td align=\"center\">\n<table class=\"table-1\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td align=\"left\">\n<h1>New Subscription</h1>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end hero --> <!-- start hero -->\n<tr>\n<td align=\"center\">\n<table class=\"table-2\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td align=\"left\">\n<h1>Hi {first_name},</h1>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end hero --> <!-- start copy block -->\n<tr>\n<td align=\"center\">\n<table class=\"table-3\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start copy -->\n<tbody>\n<tr>\n<td class=\"td-1\">\n<p>Your subscription has just been created. You can now log in and complete the payment.</p>\n</td>\n</tr>\n<tr>\n<td class=\"td-1\">\n<table class=\"table-gray\" style=\"height: 96px;\" cellpadding=\"5\">\n<tbody>\n<tr style=\"height: 24px;\">\n<td class=\"td-1\" style=\"height: 24px; width: 116px;\"><strong>Plan</strong></td>\n<td class=\"td-2\" style=\"height: 24px; width: 373px;\">{subscription_plan}</td>\n</tr>\n<tr style=\"height: 24px;\">\n<td class=\"td-1\" style=\"height: 24px; width: 116px;\"><strong>Amount</strong></td>\n<td class=\"td-2\" style=\"height: 24px; width: 373px;\">{subscription_amount} /&nbsp;{subscription_cycle}</td>\n</tr>\n</tbody>\n</table>\n<p>You can manage your subscription via the dashboard.</p>\n</td>\n</tr>\n<tr>\n<td align=\"left\" bgcolor=\"#ffffff\">\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td class=\"td-button\">\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td align=\"center\"><a class=\"button\" href=\"{subscription_url}\" target=\"_blank\" rel=\"noopener\">Complete Payment</a></td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<tr>\n<td class=\"signature\">\n<p>{email_signature}</p>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end copy block --> <!-- start footer -->\n<tr>\n<td class=\"p-24\" align=\"center\">\n<table class=\"footer\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start permission -->\n<tbody>\n<tr>\n<td align=\"center\">\n<p>{email_footer}</p>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end footer --></tbody>\n</table>\n<!-- end body -->\n</body>\n\n</html>', '{first_name}, {last_name}, {client_company_name},{subscription_id},{subscription_plan},{subscription_url},{subscription_cycle},  {subscription_status},{subscription_amount}, {subscription_url},{subscription_project_title},{subscription_project_id}', '2019-12-08 17:13:10', '2021-01-16 11:07:26', 'enabled', 'english', 'yes', 'yes', 132),
(NULL, NULL, 'Subscription Renewal Failed', 'template_lang_subscription_renewal_failed', 'client', 'subscriptions', 'Subscription Renewal Has Failed', '<!DOCTYPE html>\n<html>\n\n<head>\n\n    <meta charset=\"utf-8\">\n    <meta http-equiv=\"x-ua-compatible\" content=\"ie=edge\">\n    <title>Email Confirmation</title>\n    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">\n    <style type=\"text/css\">\n        @media screen {\n            @font-face {\n                font-family: \'Source Sans Pro\';\n                font-style: normal;\n                font-weight: 400;\n                src: local(\'Source Sans Pro Regular\'), local(\'SourceSansPro-Regular\'), url(https://fonts.gstatic.com/s/sourcesanspro/v10/ODelI1aHBYDBqgeIAH2zlBM0YzuT7MdOe03otPbuUS0.woff) format(\'woff\');\n            }\n\n            @font-face {\n                font-family: \'Source Sans Pro\';\n                font-style: normal;\n                font-weight: 700;\n                src: local(\'Source Sans Pro Bold\'), local(\'SourceSansPro-Bold\'), url(https://fonts.gstatic.com/s/sourcesanspro/v10/toadOcfmlt9b38dHJxOBGFkQc6VGVFSmCnC_l7QZG60.woff) format(\'woff\');\n            }\n        }\n\n        body,\n        table,\n        td,\n        a {\n            -ms-text-size-adjust: 100%;\n            /* 1 */\n            -webkit-text-size-adjust: 100%;\n            /* 2 */\n        }\n\n        img {\n            -ms-interpolation-mode: bicubic;\n        }\n\n        a[x-apple-data-detectors] {\n            font-family: inherit !important;\n            font-size: inherit !important;\n            font-weight: inherit !important;\n            line-height: inherit !important;\n            color: inherit !important;\n            text-decoration: none !important;\n        }\n\n        div[style*=\"margin: 16px 0;\"] {\n            margin: 0 !important;\n        }\n\n        body {\n            width: 100% !important;\n            height: 100% !important;\n            padding: 0 !important;\n            margin: 0 !important;\n            padding: 24px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 16px;\n            background-color: #f9fafc;\n            color: #60676d;\n        }\n\n        table {\n            border-collapse: collapse !important;\n        }\n\n        a {\n            color: #1a82e2;\n        }\n\n        img {\n            height: auto;\n            line-height: 100%;\n            text-decoration: none;\n            border: 0;\n            outline: none;\n        }\n\n        .table-1 {\n            max-width: 600px;\n        }\n\n        .table-1 td {\n            padding: 36px 24px 40px;\n            text-align: center;\n        }\n\n        .table-1 h1 {\n            margin: 0;\n            font-size: 32px;\n            font-weight: 600;\n            letter-spacing: -1px;\n            line-height: 48px;\n        }\n\n        .table-2 {\n            max-width: 600px;\n        }\n\n        .table-2 td {\n            padding: 36px 24px 0;\n            border-top: 3px solid #d4dadf;\n            background-color: #ffffff;\n        }\n\n        .table-2 h1 {\n            margin: 0;\n            font-size: 20px;\n            font-weight: 600;\n            letter-spacing: -1px;\n            line-height: 48px;\n        }\n\n        .table-3 {\n            max-width: 600px;\n        }\n\n        .table-2 td {\n\n            background-color: #ffffff;\n        }\n\n        .td-1 {\n            padding: 24px;\n            font-size: 16px;\n            line-height: 24px;\n            background-color: #ffffff;\n            text-align: left;\n            padding-bottom: 10px;\n            padding-top: 0px;\n        }\n\n        .table-gray {\n            width: 100%;\n        }\n\n        .table-gray tr {\n            height: 24px;\n        }\n\n        .table-gray .td-1 {\n            background-color: #f1f3f7;\n            width: 30%;\n            border: solid 1px #e7e9ec;\n            padding-top: 5px;\n            padding-bottom: 5px;\n            font-size:16px;\n        }\n\n        .table-gray .td-2 {\n            background-color: #f1f3f7;\n            width: 70%;\n            border: solid 1px #e7e9ec;\n            font-size:16px;\n        }\n\n        .button, .button:active, .button:visited {\n            display: inline-block;\n            padding: 16px 36px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 16px;\n            color: #ffffff;\n            text-decoration: none;\n            border-radius: 6px;\n            background-color: #1a82e2;\n            border-radius: 6px;\n        }\n\n        .signature {\n            padding: 24px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 16px;\n            line-height: 24px;\n            border-bottom: 3px solid #d4dadf;\n            background-color: #ffffff;\n        }\n\n        .footer {\n            max-width: 600px;\n        }\n\n        .footer td {\n            padding: 12px 24px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 14px;\n            line-height: 20px;\n            color: #666;\n        }\n\n        .td-button {\n            padding: 12px;\n            background-color: #ffffff;\n            text-align: center;\n        }\n\n        .p-24 {\n            padding: 24px;\n        }\n    </style>\n\n</head>\n\n<body>\n<!-- start body -->\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start hero -->\n<tbody>\n<tr>\n<td align=\"center\">\n<table class=\"table-1\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td align=\"left\">\n<h1>Subscription Has Failed</h1>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end hero --> <!-- start hero -->\n<tr>\n<td align=\"center\">\n<table class=\"table-2\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td align=\"left\">\n<h1>Hi {first_name},</h1>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end hero --> <!-- start copy block -->\n<tr>\n<td align=\"center\">\n<table class=\"table-3\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start copy -->\n<tbody>\n<tr>\n<td class=\"td-1\">\n<p>Your subscription renewal payment has failed. You can add or update your payment method and the payment will be processed again.</p>\n</td>\n</tr>\n<tr>\n<td class=\"td-1\">\n<table class=\"table-gray\" cellpadding=\"5\">\n<tbody>\n<tr>\n<td class=\"td-1\"><strong>Plan</strong></td>\n<td class=\"td-2\">{project_id}</td>\n</tr>\n<tr>\n<td class=\"td-1\"><strong>Amount</strong></td>\n<td class=\"td-2\">{project_title}</td>\n</tr>\n</tbody>\n</table>\n<p>You can manage your project via the dashboard.</p>\n</td>\n</tr>\n<tr>\n<td align=\"left\" bgcolor=\"#ffffff\">\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td class=\"td-button\">\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td align=\"center\"><a class=\"button\" href=\"{subscription_url}\" target=\"_blank\" rel=\"noopener\">Manage Your Subscription</a></td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<tr>\n<td class=\"signature\">\n<p>{email_signature}</p>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end copy block --> <!-- start footer -->\n<tr>\n<td class=\"p-24\" align=\"center\">\n<table class=\"footer\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start permission -->\n<tbody>\n<tr>\n<td align=\"center\">\n<p>{email_footer}</p>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end footer --></tbody>\n</table>\n<!-- end body -->\n</body>\n\n</html>', '{first_name}, {last_name}, {client_company_name},{subscription_id},{subscription_plan},{subscription_url},{subscription_cycle},  {subscription_status},{subscription_amount}, {subscription_url},{subscription_project_title},{subscription_project_id}', '2019-12-08 17:13:10', '2021-01-15 19:58:30', 'enabled', 'english', 'yes', 'yes', 133),
(NULL, NULL, 'Subscription Renewal Failed', 'template_lang_subscription_renewal_failed', 'team', 'subscriptions', 'Subscription Renewal Failed', '<!DOCTYPE html>\n<html>\n\n<head>\n\n    <meta charset=\"utf-8\">\n    <meta http-equiv=\"x-ua-compatible\" content=\"ie=edge\">\n    <title>Email Confirmation</title>\n    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">\n    <style type=\"text/css\">\n        @media screen {\n            @font-face {\n                font-family: \'Source Sans Pro\';\n                font-style: normal;\n                font-weight: 400;\n                src: local(\'Source Sans Pro Regular\'), local(\'SourceSansPro-Regular\'), url(https://fonts.gstatic.com/s/sourcesanspro/v10/ODelI1aHBYDBqgeIAH2zlBM0YzuT7MdOe03otPbuUS0.woff) format(\'woff\');\n            }\n\n            @font-face {\n                font-family: \'Source Sans Pro\';\n                font-style: normal;\n                font-weight: 700;\n                src: local(\'Source Sans Pro Bold\'), local(\'SourceSansPro-Bold\'), url(https://fonts.gstatic.com/s/sourcesanspro/v10/toadOcfmlt9b38dHJxOBGFkQc6VGVFSmCnC_l7QZG60.woff) format(\'woff\');\n            }\n        }\n\n        body,\n        table,\n        td,\n        a {\n            -ms-text-size-adjust: 100%;\n            /* 1 */\n            -webkit-text-size-adjust: 100%;\n            /* 2 */\n        }\n\n        img {\n            -ms-interpolation-mode: bicubic;\n        }\n\n        a[x-apple-data-detectors] {\n            font-family: inherit !important;\n            font-size: inherit !important;\n            font-weight: inherit !important;\n            line-height: inherit !important;\n            color: inherit !important;\n            text-decoration: none !important;\n        }\n\n        div[style*=\"margin: 16px 0;\"] {\n            margin: 0 !important;\n        }\n\n        body {\n            width: 100% !important;\n            height: 100% !important;\n            padding: 0 !important;\n            margin: 0 !important;\n            padding: 24px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 16px;\n            background-color: #f9fafc;\n            color: #60676d;\n        }\n\n        table {\n            border-collapse: collapse !important;\n        }\n\n        a {\n            color: #1a82e2;\n        }\n\n        img {\n            height: auto;\n            line-height: 100%;\n            text-decoration: none;\n            border: 0;\n            outline: none;\n        }\n\n        .table-1 {\n            max-width: 600px;\n        }\n\n        .table-1 td {\n            padding: 36px 24px 40px;\n            text-align: center;\n        }\n\n        .table-1 h1 {\n            margin: 0;\n            font-size: 32px;\n            font-weight: 600;\n            letter-spacing: -1px;\n            line-height: 48px;\n        }\n\n        .table-2 {\n            max-width: 600px;\n        }\n\n        .table-2 td {\n            padding: 36px 24px 0;\n            border-top: 3px solid #d4dadf;\n            background-color: #ffffff;\n        }\n\n        .table-2 h1 {\n            margin: 0;\n            font-size: 20px;\n            font-weight: 600;\n            letter-spacing: -1px;\n            line-height: 48px;\n        }\n\n        .table-3 {\n            max-width: 600px;\n        }\n\n        .table-2 td {\n\n            background-color: #ffffff;\n        }\n\n        .td-1 {\n            padding: 24px;\n            font-size: 16px;\n            line-height: 24px;\n            background-color: #ffffff;\n            text-align: left;\n            padding-bottom: 10px;\n            padding-top: 0px;\n        }\n\n        .table-gray {\n            width: 100%;\n        }\n\n        .table-gray tr {\n            height: 24px;\n        }\n\n        .table-gray .td-1 {\n            background-color: #f1f3f7;\n            width: 40%;\n            border: solid 1px #e7e9ec;\n            padding-top: 5px;\n            padding-bottom: 5px;\n            font-size:16px;\n        }\n\n        .table-gray .td-2 {\n            background-color: #f1f3f7;\n            width: 70%;\n            border: solid 1px #e7e9ec;\n            font-size:16px;\n        }\n\n        .button, .button:active, .button:visited {\n            display: inline-block;\n            padding: 16px 36px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 16px;\n            color: #ffffff;\n            text-decoration: none;\n            border-radius: 6px;\n            background-color: #1a82e2;\n            border-radius: 6px;\n        }\n\n        .signature {\n            padding: 24px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 16px;\n            line-height: 24px;\n            border-bottom: 3px solid #d4dadf;\n            background-color: #ffffff;\n        }\n\n        .footer {\n            max-width: 600px;\n        }\n\n        .footer td {\n            padding: 12px 24px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 14px;\n            line-height: 20px;\n            color: #666;\n        }\n\n        .td-button {\n            padding: 12px;\n            background-color: #ffffff;\n            text-align: center;\n        }\n\n        .p-24 {\n            padding: 24px;\n        }\n    </style>\n\n</head>\n\n<body>\n<!-- start body -->\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start hero -->\n<tbody>\n<tr>\n<td align=\"center\">\n<table class=\"table-1\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td align=\"left\">\n<h1>Subscription Failed</h1>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end hero --> <!-- start hero -->\n<tr>\n<td align=\"center\">\n<table class=\"table-2\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td align=\"left\">\n<h1>Hi {first_name},</h1>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end hero --> <!-- start copy block -->\n<tr>\n<td align=\"center\">\n<table class=\"table-3\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start copy -->\n<tbody>\n<tr>\n<td class=\"td-1\">\n<p>The following subscription\'s renewal payment has failed.</p>\n</td>\n</tr>\n<tr>\n<td class=\"td-1\">\n<table class=\"table-gray\" cellpadding=\"5\">\n<tbody>\n<tr>\n<td class=\"td-1\"><strong>Client</strong></td>\n<td class=\"td-2\">{client_company_name}</td>\n</tr>\n<tr>\n<td class=\"td-1\"><strong>Subscription ID</strong></td>\n<td class=\"td-2\">{subscription_id}</td>\n</tr>\n<tr>\n<td class=\"td-1\"><strong>Plan</strong></td>\n<td class=\"td-2\">{subscription_plan}</td>\n</tr>\n<tr>\n<td class=\"td-1\"><strong>Amount</strong></td>\n<td class=\"td-2\">{subscription_amount}</td>\n</tr>\n</tbody>\n</table>\n<p>&nbsp;</p>\n</td>\n</tr>\n<tr>\n<td align=\"left\" bgcolor=\"#ffffff\">\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td class=\"td-button\">\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td align=\"center\"><a class=\"button\" href=\"{subscription_url}\" target=\"_blank\" rel=\"noopener\">View Subscription</a></td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<tr>\n<td class=\"signature\">\n<p>{email_signature}</p>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end copy block --> <!-- start footer -->\n<tr>\n<td class=\"p-24\" align=\"center\">\n<table class=\"footer\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start permission -->\n<tbody>\n<tr>\n<td align=\"center\">\n<p>{email_footer}</p>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end footer --></tbody>\n</table>\n<!-- end body -->\n</body>\n\n</html>', '{first_name}, {last_name}, {client_company_name},{subscription_id},{subscription_plan},{subscription_url},{subscription_cycle},  {subscription_status},{subscription_amount}, {subscription_url},{subscription_project_title},{subscription_project_id}', '2019-12-08 17:13:10', '2021-01-15 19:53:33', 'enabled', 'english', 'yes', 'yes', 134);
INSERT INTO `email_templates` (`emailtemplate_module_unique_id`, `emailtemplate_module_name`, `emailtemplate_name`, `emailtemplate_lang`, `emailtemplate_type`, `emailtemplate_category`, `emailtemplate_subject`, `emailtemplate_body`, `emailtemplate_variables`, `emailtemplate_created`, `emailtemplate_updated`, `emailtemplate_status`, `emailtemplate_language`, `emailtemplate_real_template`, `emailtemplate_show_enabled`, `emailtemplate_id`) VALUES
(NULL, NULL, 'Subscription Renewed', 'template_lang_subscription_renewed', 'team', 'subscriptions', 'Subscription Was Renewed', '<!DOCTYPE html>\n<html>\n\n<head>\n\n    <meta charset=\"utf-8\">\n    <meta http-equiv=\"x-ua-compatible\" content=\"ie=edge\">\n    <title>Email Confirmation</title>\n    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">\n    <style type=\"text/css\">\n        @media screen {\n            @font-face {\n                font-family: \'Source Sans Pro\';\n                font-style: normal;\n                font-weight: 400;\n                src: local(\'Source Sans Pro Regular\'), local(\'SourceSansPro-Regular\'), url(https://fonts.gstatic.com/s/sourcesanspro/v10/ODelI1aHBYDBqgeIAH2zlBM0YzuT7MdOe03otPbuUS0.woff) format(\'woff\');\n            }\n\n            @font-face {\n                font-family: \'Source Sans Pro\';\n                font-style: normal;\n                font-weight: 700;\n                src: local(\'Source Sans Pro Bold\'), local(\'SourceSansPro-Bold\'), url(https://fonts.gstatic.com/s/sourcesanspro/v10/toadOcfmlt9b38dHJxOBGFkQc6VGVFSmCnC_l7QZG60.woff) format(\'woff\');\n            }\n        }\n\n        body,\n        table,\n        td,\n        a {\n            -ms-text-size-adjust: 100%;\n            /* 1 */\n            -webkit-text-size-adjust: 100%;\n            /* 2 */\n        }\n\n        img {\n            -ms-interpolation-mode: bicubic;\n        }\n\n        a[x-apple-data-detectors] {\n            font-family: inherit !important;\n            font-size: inherit !important;\n            font-weight: inherit !important;\n            line-height: inherit !important;\n            color: inherit !important;\n            text-decoration: none !important;\n        }\n\n        div[style*=\"margin: 16px 0;\"] {\n            margin: 0 !important;\n        }\n\n        body {\n            width: 100% !important;\n            height: 100% !important;\n            padding: 0 !important;\n            margin: 0 !important;\n            padding: 24px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 16px;\n            background-color: #f9fafc;\n            color: #60676d;\n        }\n\n        table {\n            border-collapse: collapse !important;\n        }\n\n        a {\n            color: #1a82e2;\n        }\n\n        img {\n            height: auto;\n            line-height: 100%;\n            text-decoration: none;\n            border: 0;\n            outline: none;\n        }\n\n        .table-1 {\n            max-width: 600px;\n        }\n\n        .table-1 td {\n            padding: 36px 24px 40px;\n            text-align: center;\n        }\n\n        .table-1 h1 {\n            margin: 0;\n            font-size: 32px;\n            font-weight: 600;\n            letter-spacing: -1px;\n            line-height: 48px;\n        }\n\n        .table-2 {\n            max-width: 600px;\n        }\n\n        .table-2 td {\n            padding: 36px 24px 0;\n            border-top: 3px solid #d4dadf;\n            background-color: #ffffff;\n        }\n\n        .table-2 h1 {\n            margin: 0;\n            font-size: 20px;\n            font-weight: 600;\n            letter-spacing: -1px;\n            line-height: 48px;\n        }\n\n        .table-3 {\n            max-width: 600px;\n        }\n\n        .table-2 td {\n\n            background-color: #ffffff;\n        }\n\n        .td-1 {\n            padding: 24px;\n            font-size: 16px;\n            line-height: 24px;\n            background-color: #ffffff;\n            text-align: left;\n            padding-bottom: 10px;\n            padding-top: 0px;\n        }\n\n        .table-gray {\n            width: 100%;\n        }\n\n        .table-gray tr {\n            height: 24px;\n        }\n\n        .table-gray .td-1 {\n            background-color: #f1f3f7;\n            width: 40%;\n            border: solid 1px #e7e9ec;\n            padding-top: 5px;\n            padding-bottom: 5px;\n            font-size:16px;\n        }\n\n        .table-gray .td-2 {\n            background-color: #f1f3f7;\n            width: 70%;\n            border: solid 1px #e7e9ec;\n            font-size:16px;\n        }\n\n        .button, .button:active, .button:visited {\n            display: inline-block;\n            padding: 16px 36px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 16px;\n            color: #ffffff;\n            text-decoration: none;\n            border-radius: 6px;\n            background-color: #1a82e2;\n            border-radius: 6px;\n        }\n\n        .signature {\n            padding: 24px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 16px;\n            line-height: 24px;\n            border-bottom: 3px solid #d4dadf;\n            background-color: #ffffff;\n        }\n\n        .footer {\n            max-width: 600px;\n        }\n\n        .footer td {\n            padding: 12px 24px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 14px;\n            line-height: 20px;\n            color: #666;\n        }\n\n        .td-button {\n            padding: 12px;\n            background-color: #ffffff;\n            text-align: center;\n        }\n\n        .p-24 {\n            padding: 24px;\n        }\n    </style>\n\n</head>\n\n<body>\n<!-- start body -->\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start hero -->\n<tbody>\n<tr>\n<td align=\"center\">\n<table class=\"table-1\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td align=\"left\">\n<h1>Subscription Renewed</h1>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end hero --> <!-- start hero -->\n<tr>\n<td align=\"center\">\n<table class=\"table-2\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td align=\"left\">\n<h1>Hi {first_name},</h1>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end hero --> <!-- start copy block -->\n<tr>\n<td align=\"center\">\n<table class=\"table-3\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start copy -->\n<tbody>\n<tr>\n<td class=\"td-1\">\n<p>The following subscription has been renewed successfully.</p>\n</td>\n</tr>\n<tr>\n<td class=\"td-1\">\n<table class=\"table-gray\" style=\"height: 96px;\" cellpadding=\"5\">\n<tbody>\n<tr style=\"height: 24px;\">\n<td class=\"td-1\" style=\"height: 24px; width: 170px;\"><strong>Client</strong></td>\n<td class=\"td-2\" style=\"height: 24px; width: 319px;\">{client_company_name}</td>\n</tr>\n<tr style=\"height: 24px;\">\n<td class=\"td-1\" style=\"height: 24px; width: 170px;\"><strong>Subscription ID</strong></td>\n<td class=\"td-2\" style=\"height: 24px; width: 319px;\">{subscription_id}</td>\n</tr>\n<tr style=\"height: 24px;\">\n<td class=\"td-1\" style=\"height: 24px; width: 170px;\"><strong>Plan</strong></td>\n<td class=\"td-2\" style=\"height: 24px; width: 319px;\">{subscription_plan}</td>\n</tr>\n<tr style=\"height: 24px;\">\n<td class=\"td-1\" style=\"height: 24px; width: 170px;\"><strong>Amount</strong></td>\n<td class=\"td-2\" style=\"height: 24px; width: 319px;\">{subscription_amount} /&nbsp;{subscription_cycle}</td>\n</tr>\n</tbody>\n</table>\n<p>&nbsp;</p>\n</td>\n</tr>\n<tr>\n<td align=\"left\" bgcolor=\"#ffffff\">\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td class=\"td-button\">\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td align=\"center\"><a class=\"button\" href=\"{subscription_url}\" target=\"_blank\" rel=\"noopener\">View Subscription</a></td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<tr>\n<td class=\"signature\">\n<p>{email_signature}</p>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end copy block --> <!-- start footer -->\n<tr>\n<td class=\"p-24\" align=\"center\">\n<table class=\"footer\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start permission -->\n<tbody>\n<tr>\n<td align=\"center\">\n<p>{email_footer}</p>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end footer --></tbody>\n</table>\n<!-- end body -->\n</body>\n\n</html>', '{first_name}, {last_name}, {client_company_name},{subscription_id},{subscription_plan},{subscription_url},{subscription_cycle},  {subscription_status},{subscription_amount}, {subscription_url},{subscription_project_title},{subscription_project_id}', '2019-12-08 17:13:10', '2021-01-22 15:24:33', 'enabled', 'english', 'yes', 'yes', 135),
(NULL, NULL, 'Subscription Renewed', 'template_lang_subscription_renewed', 'client', 'subscriptions', 'Subscription Was Renewed', '<!DOCTYPE html>\n<html>\n\n<head>\n\n    <meta charset=\"utf-8\">\n    <meta http-equiv=\"x-ua-compatible\" content=\"ie=edge\">\n    <title>Email Confirmation</title>\n    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">\n    <style type=\"text/css\">\n        @media screen {\n            @font-face {\n                font-family: \'Source Sans Pro\';\n                font-style: normal;\n                font-weight: 400;\n                src: local(\'Source Sans Pro Regular\'), local(\'SourceSansPro-Regular\'), url(https://fonts.gstatic.com/s/sourcesanspro/v10/ODelI1aHBYDBqgeIAH2zlBM0YzuT7MdOe03otPbuUS0.woff) format(\'woff\');\n            }\n\n            @font-face {\n                font-family: \'Source Sans Pro\';\n                font-style: normal;\n                font-weight: 700;\n                src: local(\'Source Sans Pro Bold\'), local(\'SourceSansPro-Bold\'), url(https://fonts.gstatic.com/s/sourcesanspro/v10/toadOcfmlt9b38dHJxOBGFkQc6VGVFSmCnC_l7QZG60.woff) format(\'woff\');\n            }\n        }\n\n        body,\n        table,\n        td,\n        a {\n            -ms-text-size-adjust: 100%;\n            /* 1 */\n            -webkit-text-size-adjust: 100%;\n            /* 2 */\n        }\n\n        img {\n            -ms-interpolation-mode: bicubic;\n        }\n\n        a[x-apple-data-detectors] {\n            font-family: inherit !important;\n            font-size: inherit !important;\n            font-weight: inherit !important;\n            line-height: inherit !important;\n            color: inherit !important;\n            text-decoration: none !important;\n        }\n\n        div[style*=\"margin: 16px 0;\"] {\n            margin: 0 !important;\n        }\n\n        body {\n            width: 100% !important;\n            height: 100% !important;\n            padding: 0 !important;\n            margin: 0 !important;\n            padding: 24px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 16px;\n            background-color: #f9fafc;\n            color: #60676d;\n        }\n\n        table {\n            border-collapse: collapse !important;\n        }\n\n        a {\n            color: #1a82e2;\n        }\n\n        img {\n            height: auto;\n            line-height: 100%;\n            text-decoration: none;\n            border: 0;\n            outline: none;\n        }\n\n        .table-1 {\n            max-width: 600px;\n        }\n\n        .table-1 td {\n            padding: 36px 24px 40px;\n            text-align: center;\n        }\n\n        .table-1 h1 {\n            margin: 0;\n            font-size: 32px;\n            font-weight: 600;\n            letter-spacing: -1px;\n            line-height: 48px;\n        }\n\n        .table-2 {\n            max-width: 600px;\n        }\n\n        .table-2 td {\n            padding: 36px 24px 0;\n            border-top: 3px solid #d4dadf;\n            background-color: #ffffff;\n        }\n\n        .table-2 h1 {\n            margin: 0;\n            font-size: 20px;\n            font-weight: 600;\n            letter-spacing: -1px;\n            line-height: 48px;\n        }\n\n        .table-3 {\n            max-width: 600px;\n        }\n\n        .table-2 td {\n\n            background-color: #ffffff;\n        }\n\n        .td-1 {\n            padding: 24px;\n            font-size: 16px;\n            line-height: 24px;\n            background-color: #ffffff;\n            text-align: left;\n            padding-bottom: 10px;\n            padding-top: 0px;\n        }\n\n        .table-gray {\n            width: 100%;\n        }\n\n        .table-gray tr {\n            height: 24px;\n        }\n\n        .table-gray .td-1 {\n            background-color: #f1f3f7;\n            width: 40%;\n            border: solid 1px #e7e9ec;\n            padding-top: 5px;\n            padding-bottom: 5px;\n            font-size:16px;\n        }\n\n        .table-gray .td-2 {\n            background-color: #f1f3f7;\n            width: 70%;\n            border: solid 1px #e7e9ec;\n            font-size:16px;\n        }\n\n        .button, .button:active, .button:visited {\n            display: inline-block;\n            padding: 16px 36px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 16px;\n            color: #ffffff;\n            text-decoration: none;\n            border-radius: 6px;\n            background-color: #1a82e2;\n            border-radius: 6px;\n        }\n\n        .signature {\n            padding: 24px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 16px;\n            line-height: 24px;\n            border-bottom: 3px solid #d4dadf;\n            background-color: #ffffff;\n        }\n\n        .footer {\n            max-width: 600px;\n        }\n\n        .footer td {\n            padding: 12px 24px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 14px;\n            line-height: 20px;\n            color: #666;\n        }\n\n        .td-button {\n            padding: 12px;\n            background-color: #ffffff;\n            text-align: center;\n        }\n\n        .p-24 {\n            padding: 24px;\n        }\n    </style>\n\n</head>\n\n<body>\n<!-- start body -->\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start hero -->\n<tbody>\n<tr>\n<td align=\"center\">\n<table class=\"table-1\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td align=\"left\">\n<h1>Subscription Renewed</h1>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end hero --> <!-- start hero -->\n<tr>\n<td align=\"center\">\n<table class=\"table-2\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td align=\"left\">\n<h1>Hi {first_name},</h1>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end hero --> <!-- start copy block -->\n<tr>\n<td align=\"center\">\n<table class=\"table-3\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start copy -->\n<tbody>\n<tr>\n<td class=\"td-1\">\n<p>Your subscription has renewed successfully.</p>\n</td>\n</tr>\n<tr>\n<td class=\"td-1\">\n<table class=\"table-gray\" style=\"height: 96px;\" cellpadding=\"5\">\n<tbody>\n<tr style=\"height: 24px;\">\n<td class=\"td-1\" style=\"height: 24px; width: 170px;\"><strong>Subscription ID</strong></td>\n<td class=\"td-2\" style=\"height: 24px; width: 319px;\">{subscription_id}</td>\n</tr>\n<tr style=\"height: 24px;\">\n<td class=\"td-1\" style=\"height: 24px; width: 170px;\"><strong>Plan</strong></td>\n<td class=\"td-2\" style=\"height: 24px; width: 319px;\">{subscription_plan}</td>\n</tr>\n<tr style=\"height: 24px;\">\n<td class=\"td-1\" style=\"height: 24px; width: 170px;\"><strong>Amount</strong></td>\n<td class=\"td-2\" style=\"height: 24px; width: 319px;\">{subscription_amount}</td>\n</tr>\n</tbody>\n</table>\n<p>&nbsp;</p>\n</td>\n</tr>\n<tr>\n<td align=\"left\" bgcolor=\"#ffffff\">\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td class=\"td-button\">\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td align=\"center\"><a class=\"button\" href=\"{subscription_url}\" target=\"_blank\" rel=\"noopener\">View Subscription</a></td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<tr>\n<td class=\"signature\">\n<p>{email_signature}</p>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end copy block --> <!-- start footer -->\n<tr>\n<td class=\"p-24\" align=\"center\">\n<table class=\"footer\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start permission -->\n<tbody>\n<tr>\n<td align=\"center\">\n<p>{email_footer}</p>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end footer --></tbody>\n</table>\n<!-- end body -->\n</body>\n\n</html>', '{first_name}, {last_name}, {client_company_name},{subscription_id},{subscription_plan},{subscription_url},{subscription_cycle},  {subscription_status},{subscription_amount}, {subscription_url},{subscription_project_title},{subscription_project_id}', '2019-12-08 17:13:10', '2021-01-22 15:23:50', 'enabled', 'english', 'yes', 'yes', 137),
(NULL, NULL, 'Subscription Started', 'template_lang_subscription_started', 'team', 'subscriptions', 'Subscription Activated', '<!DOCTYPE html>\n<html>\n\n<head>\n\n    <meta charset=\"utf-8\">\n    <meta http-equiv=\"x-ua-compatible\" content=\"ie=edge\">\n    <title>Email Confirmation</title>\n    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">\n    <style type=\"text/css\">\n        @media screen {\n            @font-face {\n                font-family: \'Source Sans Pro\';\n                font-style: normal;\n                font-weight: 400;\n                src: local(\'Source Sans Pro Regular\'), local(\'SourceSansPro-Regular\'), url(https://fonts.gstatic.com/s/sourcesanspro/v10/ODelI1aHBYDBqgeIAH2zlBM0YzuT7MdOe03otPbuUS0.woff) format(\'woff\');\n            }\n\n            @font-face {\n                font-family: \'Source Sans Pro\';\n                font-style: normal;\n                font-weight: 700;\n                src: local(\'Source Sans Pro Bold\'), local(\'SourceSansPro-Bold\'), url(https://fonts.gstatic.com/s/sourcesanspro/v10/toadOcfmlt9b38dHJxOBGFkQc6VGVFSmCnC_l7QZG60.woff) format(\'woff\');\n            }\n        }\n\n        body,\n        table,\n        td,\n        a {\n            -ms-text-size-adjust: 100%;\n            /* 1 */\n            -webkit-text-size-adjust: 100%;\n            /* 2 */\n        }\n\n        img {\n            -ms-interpolation-mode: bicubic;\n        }\n\n        a[x-apple-data-detectors] {\n            font-family: inherit !important;\n            font-size: inherit !important;\n            font-weight: inherit !important;\n            line-height: inherit !important;\n            color: inherit !important;\n            text-decoration: none !important;\n        }\n\n        div[style*=\"margin: 16px 0;\"] {\n            margin: 0 !important;\n        }\n\n        body {\n            width: 100% !important;\n            height: 100% !important;\n            padding: 0 !important;\n            margin: 0 !important;\n            padding: 24px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 16px;\n            background-color: #f9fafc;\n            color: #60676d;\n        }\n\n        table {\n            border-collapse: collapse !important;\n        }\n\n        a {\n            color: #1a82e2;\n        }\n\n        img {\n            height: auto;\n            line-height: 100%;\n            text-decoration: none;\n            border: 0;\n            outline: none;\n        }\n\n        .table-1 {\n            max-width: 600px;\n        }\n\n        .table-1 td {\n            padding: 36px 24px 40px;\n            text-align: center;\n        }\n\n        .table-1 h1 {\n            margin: 0;\n            font-size: 32px;\n            font-weight: 600;\n            letter-spacing: -1px;\n            line-height: 48px;\n        }\n\n        .table-2 {\n            max-width: 600px;\n        }\n\n        .table-2 td {\n            padding: 36px 24px 0;\n            border-top: 3px solid #d4dadf;\n            background-color: #ffffff;\n        }\n\n        .table-2 h1 {\n            margin: 0;\n            font-size: 20px;\n            font-weight: 600;\n            letter-spacing: -1px;\n            line-height: 48px;\n        }\n\n        .table-3 {\n            max-width: 600px;\n        }\n\n        .table-2 td {\n\n            background-color: #ffffff;\n        }\n\n        .td-1 {\n            padding: 24px;\n            font-size: 16px;\n            line-height: 24px;\n            background-color: #ffffff;\n            text-align: left;\n            padding-bottom: 10px;\n            padding-top: 0px;\n        }\n\n        .table-gray {\n            width: 100%;\n        }\n\n        .table-gray tr {\n            height: 24px;\n        }\n\n        .table-gray .td-1 {\n            background-color: #f1f3f7;\n            width: 40%;\n            border: solid 1px #e7e9ec;\n            padding-top: 5px;\n            padding-bottom: 5px;\n            font-size:16px;\n        }\n\n        .table-gray .td-2 {\n            background-color: #f1f3f7;\n            width: 70%;\n            border: solid 1px #e7e9ec;\n            font-size:16px;\n        }\n\n        .button, .button:active, .button:visited {\n            display: inline-block;\n            padding: 16px 36px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 16px;\n            color: #ffffff;\n            text-decoration: none;\n            border-radius: 6px;\n            background-color: #1a82e2;\n            border-radius: 6px;\n        }\n\n        .signature {\n            padding: 24px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 16px;\n            line-height: 24px;\n            border-bottom: 3px solid #d4dadf;\n            background-color: #ffffff;\n        }\n\n        .footer {\n            max-width: 600px;\n        }\n\n        .footer td {\n            padding: 12px 24px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 14px;\n            line-height: 20px;\n            color: #666;\n        }\n\n        .td-button {\n            padding: 12px;\n            background-color: #ffffff;\n            text-align: center;\n        }\n\n        .p-24 {\n            padding: 24px;\n        }\n    </style>\n\n</head>\n\n<body>\n<!-- start body -->\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start hero -->\n<tbody>\n<tr>\n<td align=\"center\">\n<table class=\"table-1\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td align=\"left\">\n<h1>Subscription Activated</h1>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end hero --> <!-- start hero -->\n<tr>\n<td align=\"center\">\n<table class=\"table-2\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td align=\"left\">\n<h1>Hi {first_name},</h1>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end hero --> <!-- start copy block -->\n<tr>\n<td align=\"center\">\n<table class=\"table-3\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start copy -->\n<tbody>\n<tr>\n<td class=\"td-1\">\n<p>The following subscription\'s been paid by the client and has started.</p>\n</td>\n</tr>\n<tr>\n<td class=\"td-1\">\n<table class=\"table-gray\" style=\"height: 96px;\" cellpadding=\"5\">\n<tbody>\n<tr style=\"height: 24px;\">\n<td class=\"td-1\" style=\"height: 24px; width: 170px;\"><strong>Client</strong></td>\n<td class=\"td-2\" style=\"height: 24px; width: 319px;\">{client_company_name}</td>\n</tr>\n<tr style=\"height: 24px;\">\n<td class=\"td-1\" style=\"height: 24px; width: 170px;\"><strong>Subscription ID</strong></td>\n<td class=\"td-2\" style=\"height: 24px; width: 319px;\">{subscription_project_id}</td>\n</tr>\n<tr style=\"height: 24px;\">\n<td class=\"td-1\" style=\"height: 24px; width: 170px;\"><strong>Plan</strong></td>\n<td class=\"td-2\" style=\"height: 24px; width: 319px;\">{subscription_plan}</td>\n</tr>\n<tr style=\"height: 24px;\">\n<td class=\"td-1\" style=\"height: 24px; width: 170px;\"><strong>Amount</strong></td>\n<td class=\"td-2\" style=\"height: 24px; width: 319px;\">{subscription_amount}</td>\n</tr>\n</tbody>\n</table>\n<p>&nbsp;</p>\n</td>\n</tr>\n<tr>\n<td align=\"left\" bgcolor=\"#ffffff\">\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td class=\"td-button\">\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td align=\"center\"><a class=\"button\" href=\"{subscription_url}\" target=\"_blank\" rel=\"noopener\">View Subscription</a></td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<tr>\n<td class=\"signature\">\n<p>{email_signature}</p>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end copy block --> <!-- start footer -->\n<tr>\n<td class=\"p-24\" align=\"center\">\n<table class=\"footer\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start permission -->\n<tbody>\n<tr>\n<td align=\"center\">\n<p>{email_footer}</p>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end footer --></tbody>\n</table>\n<!-- end body -->\n</body>\n\n</html>', '{first_name}, {last_name}, {client_company_name},{subscription_id},{subscription_plan},{subscription_url},{subscription_cycle},  {subscription_status},{subscription_amount}, {subscription_url},{subscription_project_title},{subscription_project_id}', '2019-12-08 17:13:10', '2021-02-04 16:36:12', 'enabled', 'english', 'yes', 'yes', 136),
(NULL, NULL, 'Subscription Cancelled', 'template_lang_subscription_renewed', 'everyone', 'subscriptions', 'Subscription Was Cancelled', '<!DOCTYPE html>\r\n<html>\r\n\r\n<head>\r\n\r\n    <meta charset=\"utf-8\">\r\n    <meta http-equiv=\"x-ua-compatible\" content=\"ie=edge\">\r\n    <title>Email Confirmation</title>\r\n    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">\r\n    <style type=\"text/css\">\r\n        @media screen {\r\n            @font-face {\r\n                font-family: \'Source Sans Pro\';\r\n                font-style: normal;\r\n                font-weight: 400;\r\n                src: local(\'Source Sans Pro Regular\'), local(\'SourceSansPro-Regular\'), url(https://fonts.gstatic.com/s/sourcesanspro/v10/ODelI1aHBYDBqgeIAH2zlBM0YzuT7MdOe03otPbuUS0.woff) format(\'woff\');\r\n            }\r\n\r\n            @font-face {\r\n                font-family: \'Source Sans Pro\';\r\n                font-style: normal;\r\n                font-weight: 700;\r\n                src: local(\'Source Sans Pro Bold\'), local(\'SourceSansPro-Bold\'), url(https://fonts.gstatic.com/s/sourcesanspro/v10/toadOcfmlt9b38dHJxOBGFkQc6VGVFSmCnC_l7QZG60.woff) format(\'woff\');\r\n            }\r\n        }\r\n\r\n        body,\r\n        table,\r\n        td,\r\n        a {\r\n            -ms-text-size-adjust: 100%;\r\n            /* 1 */\r\n            -webkit-text-size-adjust: 100%;\r\n            /* 2 */\r\n        }\r\n\r\n        img {\r\n            -ms-interpolation-mode: bicubic;\r\n        }\r\n\r\n        a[x-apple-data-detectors] {\r\n            font-family: inherit !important;\r\n            font-size: inherit !important;\r\n            font-weight: inherit !important;\r\n            line-height: inherit !important;\r\n            color: inherit !important;\r\n            text-decoration: none !important;\r\n        }\r\n\r\n        div[style*=\"margin: 16px 0;\"] {\r\n            margin: 0 !important;\r\n        }\r\n\r\n        body {\r\n            width: 100% !important;\r\n            height: 100% !important;\r\n            padding: 0 !important;\r\n            margin: 0 !important;\r\n            padding: 24px;\r\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\r\n            font-size: 16px;\r\n            background-color: #f9fafc;\r\n            color: #60676d;\r\n        }\r\n\r\n        table {\r\n            border-collapse: collapse !important;\r\n        }\r\n\r\n        a {\r\n            color: #1a82e2;\r\n        }\r\n\r\n        img {\r\n            height: auto;\r\n            line-height: 100%;\r\n            text-decoration: none;\r\n            border: 0;\r\n            outline: none;\r\n        }\r\n\r\n        .table-1 {\r\n            max-width: 600px;\r\n        }\r\n\r\n        .table-1 td {\r\n            padding: 36px 24px 40px;\r\n            text-align: center;\r\n        }\r\n\r\n        .table-1 h1 {\r\n            margin: 0;\r\n            font-size: 32px;\r\n            font-weight: 600;\r\n            letter-spacing: -1px;\r\n            line-height: 48px;\r\n        }\r\n\r\n        .table-2 {\r\n            max-width: 600px;\r\n        }\r\n\r\n        .table-2 td {\r\n            padding: 36px 24px 0;\r\n            border-top: 3px solid #d4dadf;\r\n            background-color: #ffffff;\r\n        }\r\n\r\n        .table-2 h1 {\r\n            margin: 0;\r\n            font-size: 20px;\r\n            font-weight: 600;\r\n            letter-spacing: -1px;\r\n            line-height: 48px;\r\n        }\r\n\r\n        .table-3 {\r\n            max-width: 600px;\r\n        }\r\n\r\n        .table-2 td {\r\n\r\n            background-color: #ffffff;\r\n        }\r\n\r\n        .td-1 {\r\n            padding: 24px;\r\n            font-size: 16px;\r\n            line-height: 24px;\r\n            background-color: #ffffff;\r\n            text-align: left;\r\n            padding-bottom: 10px;\r\n            padding-top: 0px;\r\n        }\r\n\r\n        .table-gray {\r\n            width: 100%;\r\n        }\r\n\r\n        .table-gray tr {\r\n            height: 24px;\r\n        }\r\n\r\n        .table-gray .td-1 {\r\n            background-color: #f1f3f7;\r\n            width: 40%;\r\n            border: solid 1px #e7e9ec;\r\n            padding-top: 5px;\r\n            padding-bottom: 5px;\r\n            font-size:16px;\r\n        }\r\n\r\n        .table-gray .td-2 {\r\n            background-color: #f1f3f7;\r\n            width: 70%;\r\n            border: solid 1px #e7e9ec;\r\n            font-size:16px;\r\n        }\r\n\r\n        .button, .button:active, .button:visited {\r\n            display: inline-block;\r\n            padding: 16px 36px;\r\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\r\n            font-size: 16px;\r\n            color: #ffffff;\r\n            text-decoration: none;\r\n            border-radius: 6px;\r\n            background-color: #1a82e2;\r\n            border-radius: 6px;\r\n        }\r\n\r\n        .signature {\r\n            padding: 24px;\r\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\r\n            font-size: 16px;\r\n            line-height: 24px;\r\n            border-bottom: 3px solid #d4dadf;\r\n            background-color: #ffffff;\r\n        }\r\n\r\n        .footer {\r\n            max-width: 600px;\r\n        }\r\n\r\n        .footer td {\r\n            padding: 12px 24px;\r\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\r\n            font-size: 14px;\r\n            line-height: 20px;\r\n            color: #666;\r\n        }\r\n\r\n        .td-button {\r\n            padding: 12px;\r\n            background-color: #ffffff;\r\n            text-align: center;\r\n        }\r\n\r\n        .p-24 {\r\n            padding: 24px;\r\n        }\r\n    </style>\r\n\r\n</head>\r\n\r\n<body>\r\n<!-- start body -->\r\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start hero -->\r\n<tbody>\r\n<tr>\r\n<td align=\"center\">\r\n<table class=\"table-1\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\r\n<tbody>\r\n<tr>\r\n<td align=\"left\">\r\n<h1>Subscription Cancelled</h1>\r\n</td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n</td>\r\n</tr>\r\n<!-- end hero --> <!-- start hero -->\r\n<tr>\r\n<td align=\"center\">\r\n<table class=\"table-2\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\r\n<tbody>\r\n<tr>\r\n<td align=\"left\">\r\n<h1>Hi {first_name},</h1>\r\n</td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n</td>\r\n</tr>\r\n<!-- end hero --> <!-- start copy block -->\r\n<tr>\r\n<td align=\"center\">\r\n<table class=\"table-3\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start copy -->\r\n<tbody>\r\n<tr>\r\n<td class=\"td-1\">\r\n<p>The following subscription has been cancelled.</p>\r\n</td>\r\n</tr>\r\n<tr>\r\n<td class=\"td-1\">\r\n<table class=\"table-gray\" style=\"height: 96px;\" cellpadding=\"5\">\r\n<tbody>\r\n<tr style=\"height: 24px;\">\r\n<td class=\"td-1\" style=\"height: 24px; width: 170px;\"><strong>Subscription ID</strong></td>\r\n<td class=\"td-2\" style=\"height: 24px; width: 319px;\">{subscription_id}</td>\r\n</tr>\r\n<tr style=\"height: 24px;\">\r\n<td class=\"td-1\" style=\"height: 24px; width: 170px;\"><strong>Plan</strong></td>\r\n<td class=\"td-2\" style=\"height: 24px; width: 319px;\">{subscription_plan}</td>\r\n</tr>\r\n<tr style=\"height: 24px;\">\r\n<td class=\"td-1\" style=\"height: 24px; width: 170px;\"><strong>Amount</strong></td>\r\n<td class=\"td-2\" style=\"height: 24px; width: 319px;\">{subscription_amount}</td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n<p>&nbsp;</p>\r\n</td>\r\n</tr>\r\n<tr>\r\n<td align=\"left\" bgcolor=\"#ffffff\">\r\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\r\n<tbody>\r\n<tr>\r\n<td class=\"td-button\">\r\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\r\n<tbody>\r\n<tr>\r\n<td align=\"center\"><a class=\"button\" href=\"{subscription_url}\" target=\"_blank\" rel=\"noopener\">View Subscription</a></td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n</td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n</td>\r\n</tr>\r\n<tr>\r\n<td class=\"signature\">\r\n<p>{email_signature}</p>\r\n</td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n</td>\r\n</tr>\r\n<!-- end copy block --> <!-- start footer -->\r\n<tr>\r\n<td class=\"p-24\" align=\"center\">\r\n<table class=\"footer\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start permission -->\r\n<tbody>\r\n<tr>\r\n<td align=\"center\">\r\n<p>{email_footer}</p>\r\n</td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n</td>\r\n</tr>\r\n<!-- end footer --></tbody>\r\n</table>\r\n<!-- end body -->\r\n</body>\r\n\r\n</html>', '{first_name}, {last_name}, {client_company_name},{subscription_id},{subscription_plan},{subscription_url},{subscription_amount},{subscription_project_title},{subscription_project_id}', '2019-12-08 17:13:10', '2021-01-23 19:07:24', 'enabled', 'english', 'yes', 'yes', 138),
(NULL, NULL, 'Subscription Started', 'template_lang_subscription_started', 'client', 'subscriptions', 'Your Subscription Has Started', '<!DOCTYPE html>\n<html>\n\n<head>\n\n    <meta charset=\"utf-8\">\n    <meta http-equiv=\"x-ua-compatible\" content=\"ie=edge\">\n    <title>Email Confirmation</title>\n    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">\n    <style type=\"text/css\">\n        @media screen {\n            @font-face {\n                font-family: \'Source Sans Pro\';\n                font-style: normal;\n                font-weight: 400;\n                src: local(\'Source Sans Pro Regular\'), local(\'SourceSansPro-Regular\'), url(https://fonts.gstatic.com/s/sourcesanspro/v10/ODelI1aHBYDBqgeIAH2zlBM0YzuT7MdOe03otPbuUS0.woff) format(\'woff\');\n            }\n\n            @font-face {\n                font-family: \'Source Sans Pro\';\n                font-style: normal;\n                font-weight: 700;\n                src: local(\'Source Sans Pro Bold\'), local(\'SourceSansPro-Bold\'), url(https://fonts.gstatic.com/s/sourcesanspro/v10/toadOcfmlt9b38dHJxOBGFkQc6VGVFSmCnC_l7QZG60.woff) format(\'woff\');\n            }\n        }\n\n        body,\n        table,\n        td,\n        a {\n            -ms-text-size-adjust: 100%;\n            /* 1 */\n            -webkit-text-size-adjust: 100%;\n            /* 2 */\n        }\n\n        img {\n            -ms-interpolation-mode: bicubic;\n        }\n\n        a[x-apple-data-detectors] {\n            font-family: inherit !important;\n            font-size: inherit !important;\n            font-weight: inherit !important;\n            line-height: inherit !important;\n            color: inherit !important;\n            text-decoration: none !important;\n        }\n\n        div[style*=\"margin: 16px 0;\"] {\n            margin: 0 !important;\n        }\n\n        body {\n            width: 100% !important;\n            height: 100% !important;\n            padding: 0 !important;\n            margin: 0 !important;\n            padding: 24px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 16px;\n            background-color: #f9fafc;\n            color: #60676d;\n        }\n\n        table {\n            border-collapse: collapse !important;\n        }\n\n        a {\n            color: #1a82e2;\n        }\n\n        img {\n            height: auto;\n            line-height: 100%;\n            text-decoration: none;\n            border: 0;\n            outline: none;\n        }\n\n        .table-1 {\n            max-width: 600px;\n        }\n\n        .table-1 td {\n            padding: 36px 24px 40px;\n            text-align: center;\n        }\n\n        .table-1 h1 {\n            margin: 0;\n            font-size: 32px;\n            font-weight: 600;\n            letter-spacing: -1px;\n            line-height: 48px;\n        }\n\n        .table-2 {\n            max-width: 600px;\n        }\n\n        .table-2 td {\n            padding: 36px 24px 0;\n            border-top: 3px solid #d4dadf;\n            background-color: #ffffff;\n        }\n\n        .table-2 h1 {\n            margin: 0;\n            font-size: 20px;\n            font-weight: 600;\n            letter-spacing: -1px;\n            line-height: 48px;\n        }\n\n        .table-3 {\n            max-width: 600px;\n        }\n\n        .table-2 td {\n\n            background-color: #ffffff;\n        }\n\n        .td-1 {\n            padding: 24px;\n            font-size: 16px;\n            line-height: 24px;\n            background-color: #ffffff;\n            text-align: left;\n            padding-bottom: 10px;\n            padding-top: 0px;\n        }\n\n        .table-gray {\n            width: 100%;\n        }\n\n        .table-gray tr {\n            height: 24px;\n        }\n\n        .table-gray .td-1 {\n            background-color: #f1f3f7;\n            width: 40%;\n            border: solid 1px #e7e9ec;\n            padding-top: 5px;\n            padding-bottom: 5px;\n            font-size:16px;\n        }\n\n        .table-gray .td-2 {\n            background-color: #f1f3f7;\n            width: 70%;\n            border: solid 1px #e7e9ec;\n            font-size:16px;\n        }\n\n        .button, .button:active, .button:visited {\n            display: inline-block;\n            padding: 16px 36px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 16px;\n            color: #ffffff;\n            text-decoration: none;\n            border-radius: 6px;\n            background-color: #1a82e2;\n            border-radius: 6px;\n        }\n\n        .signature {\n            padding: 24px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 16px;\n            line-height: 24px;\n            border-bottom: 3px solid #d4dadf;\n            background-color: #ffffff;\n        }\n\n        .footer {\n            max-width: 600px;\n        }\n\n        .footer td {\n            padding: 12px 24px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 14px;\n            line-height: 20px;\n            color: #666;\n        }\n\n        .td-button {\n            padding: 12px;\n            background-color: #ffffff;\n            text-align: center;\n        }\n\n        .p-24 {\n            padding: 24px;\n        }\n    </style>\n\n</head>\n\n<body>\n<!-- start body -->\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start hero -->\n<tbody>\n<tr>\n<td align=\"center\">\n<table class=\"table-1\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td align=\"left\">\n<h1>Subscription Started</h1>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end hero --> <!-- start hero -->\n<tr>\n<td align=\"center\">\n<table class=\"table-2\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td align=\"left\">\n<h1>Hi {first_name},</h1>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end hero --> <!-- start copy block -->\n<tr>\n<td align=\"center\">\n<table class=\"table-3\" style=\"height: 389px; width: 100%;\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start copy -->\n<tbody>\n<tr style=\"height: 56px;\">\n<td class=\"td-1\" style=\"height: 56px;\">\n<p>Your subscription has now started.</p>\n</td>\n</tr>\n<tr style=\"height: 197px;\">\n<td class=\"td-1\" style=\"height: 197px;\">\n<table class=\"table-gray\" style=\"height: 96px;\" cellpadding=\"5\">\n<tbody>\n<tr style=\"height: 24px;\">\n<td class=\"td-1\" style=\"height: 24px; width: 170px;\"><strong>Subscription ID</strong></td>\n<td class=\"td-2\" style=\"height: 24px; width: 319px;\">{subscription_project_id}</td>\n</tr>\n<tr style=\"height: 24px;\">\n<td class=\"td-1\" style=\"height: 24px; width: 170px;\"><strong>Plan</strong></td>\n<td class=\"td-2\" style=\"height: 24px; width: 319px;\">{subscription_plan}</td>\n</tr>\n<tr style=\"height: 24px;\">\n<td class=\"td-1\" style=\"height: 24px; width: 170px;\"><strong>Amount</strong></td>\n<td class=\"td-2\" style=\"height: 24px; width: 319px;\">{subscription_amount}</td>\n</tr>\n</tbody>\n</table>\n<p> </p>\n</td>\n</tr>\n<tr style=\"height: 80px;\">\n<td style=\"height: 80px;\" align=\"left\" bgcolor=\"#ffffff\">\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td class=\"td-button\">\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td align=\"center\"><a class=\"button\" href=\"{subscription_url}\" target=\"_blank\" rel=\"noopener\">View Subscription</a></td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<tr style=\"height: 56px;\">\n<td class=\"signature\" style=\"height: 56px;\">\n<p>{email_signature}</p>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end copy block --> <!-- start footer -->\n<tr>\n<td class=\"p-24\" align=\"center\">\n<table class=\"footer\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start permission -->\n<tbody>\n<tr>\n<td align=\"center\">\n<p>{email_footer}</p>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end footer --></tbody>\n</table>\n<!-- end body -->\n</body>\n\n</html>', '{first_name}, {last_name}, {client_company_name},{subscription_id},{subscription_plan},{subscription_url},{subscription_cycle},  {subscription_status},{subscription_amount}, {subscription_url},{subscription_project_title},{subscription_project_id}', '2019-12-08 17:13:10', '2021-02-04 16:35:42', 'enabled', 'english', 'yes', 'yes', 139);
INSERT INTO `email_templates` (`emailtemplate_module_unique_id`, `emailtemplate_module_name`, `emailtemplate_name`, `emailtemplate_lang`, `emailtemplate_type`, `emailtemplate_category`, `emailtemplate_subject`, `emailtemplate_body`, `emailtemplate_variables`, `emailtemplate_created`, `emailtemplate_updated`, `emailtemplate_status`, `emailtemplate_language`, `emailtemplate_real_template`, `emailtemplate_show_enabled`, `emailtemplate_id`) VALUES
(NULL, NULL, 'Task Overdue', 'template_lang_task_overdue', 'team', 'tasks', 'Task Is Overdue', '<!DOCTYPE html>\n<html>\n\n<head>\n\n    <meta charset=\"utf-8\">\n    <meta http-equiv=\"x-ua-compatible\" content=\"ie=edge\">\n    <title>Email Confirmation</title>\n    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">\n    <style type=\"text/css\">\n        @media screen {\n            @font-face {\n                font-family: \'Source Sans Pro\';\n                font-style: normal;\n                font-weight: 400;\n                src: local(\'Source Sans Pro Regular\'), local(\'SourceSansPro-Regular\'), url(https://fonts.gstatic.com/s/sourcesanspro/v10/ODelI1aHBYDBqgeIAH2zlBM0YzuT7MdOe03otPbuUS0.woff) format(\'woff\');\n            }\n\n            @font-face {\n                font-family: \'Source Sans Pro\';\n                font-style: normal;\n                font-weight: 700;\n                src: local(\'Source Sans Pro Bold\'), local(\'SourceSansPro-Bold\'), url(https://fonts.gstatic.com/s/sourcesanspro/v10/toadOcfmlt9b38dHJxOBGFkQc6VGVFSmCnC_l7QZG60.woff) format(\'woff\');\n            }\n        }\n\n        body,\n        table,\n        td,\n        a {\n            -ms-text-size-adjust: 100%;\n            /* 1 */\n            -webkit-text-size-adjust: 100%;\n            /* 2 */\n        }\n\n        img {\n            -ms-interpolation-mode: bicubic;\n        }\n\n        a[x-apple-data-detectors] {\n            font-family: inherit !important;\n            font-size: inherit !important;\n            font-weight: inherit !important;\n            line-height: inherit !important;\n            color: inherit !important;\n            text-decoration: none !important;\n        }\n\n        div[style*=\"margin: 16px 0;\"] {\n            margin: 0 !important;\n        }\n\n        body {\n            width: 100% !important;\n            height: 100% !important;\n            padding: 0 !important;\n            margin: 0 !important;\n            padding: 24px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 16px;\n            background-color: #f9fafc;\n            color: #60676d;\n        }\n\n        table {\n            border-collapse: collapse !important;\n        }\n\n        a {\n            color: #1a82e2;\n        }\n\n        img {\n            height: auto;\n            line-height: 100%;\n            text-decoration: none;\n            border: 0;\n            outline: none;\n        }\n\n        .table-1 {\n            max-width: 600px;\n        }\n\n        .table-1 td {\n            padding: 36px 24px 40px;\n            text-align: center;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-1 h1 {\n            margin: 0;\n            font-size: 32px;\n            font-weight: 600;\n            letter-spacing: -1px;\n            line-height: 48px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-2 {\n            max-width: 600px;\n        }\n\n        .table-2 td {\n            padding: 36px 24px 0;\n            border-top: 3px solid #d4dadf;\n            background-color: #ffffff;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-2 h1 {\n            margin: 0;\n            font-size: 20px;\n            font-weight: 600;\n            letter-spacing: -1px;\n            line-height: 48px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-3 {\n            max-width: 600px;\n        }\n\n        .table-2 td {\n\n            background-color: #ffffff;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .td-1 {\n            padding: 24px;\n            font-size: 16px;\n            line-height: 24px;\n            background-color: #ffffff;\n            text-align: left;\n            padding-bottom: 10px;\n            padding-top: 0px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-gray {\n            width: 100%;\n        }\n\n        .table-gray tr {\n            height: 24px;\n        }\n\n        .table-gray .td-1 {\n            background-color: #f1f3f7;\n            width: 30%;\n            border: solid 1px #e7e9ec;\n            padding-top: 5px;\n            padding-bottom: 5px;\n            font-size:16px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-gray .td-2 {\n            background-color: #f1f3f7;\n            width: 70%;\n            border: solid 1px #e7e9ec;\n            font-size:16px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .button, .button:active, .button:visited {\n            display: inline-block;\n            padding: 16px 36px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 16px;\n            color: #ffffff;\n            text-decoration: none;\n            border-radius: 6px;\n            background-color: #1a82e2;\n            border-radius: 6px;\n        }\n\n        .signature {\n            padding: 24px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 16px;\n            line-height: 24px;\n            border-bottom: 3px solid #d4dadf;\n            background-color: #ffffff;\n        }\n\n        .footer {\n            max-width: 600px;\n        }\n\n        .footer td {\n            padding: 12px 24px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 14px;\n            line-height: 20px;\n            color: #666;\n        }\n\n        .td-button {\n            padding: 12px;\n            background-color: #ffffff;\n            text-align: center;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .p-24 {\n            padding: 24px;\n        }\n    </style>\n\n</head>\n\n<body>\n<!-- start body -->\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start hero -->\n<tbody>\n<tr>\n<td align=\"center\">\n<table class=\"table-1\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td align=\"left\">\n<h1>Overdue Task</h1>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end hero --> <!-- start hero -->\n<tr>\n<td align=\"center\">\n<table class=\"table-2\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td align=\"left\">\n<h1>Hi {first_name},</h1>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end hero --> <!-- start copy block -->\n<tr>\n<td align=\"center\">\n<table class=\"table-3\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start copy -->\n<tbody>\n<tr>\n<td class=\"td-1\">\n<p>The following task that you are assigned to, is now overdue.</p>\n</td>\n</tr>\n<tr>\n<td class=\"td-1\">\n<table class=\"table-gray\" cellpadding=\"5\">\n<tbody>\n<tr>\n<td class=\"td-1\"><strong>Task</strong></td>\n<td class=\"td-2\">{task_title}</td>\n</tr>\n<tr>\n<td class=\"td-1\"><strong>Due Date</strong></td>\n<td class=\"td-2\">{task_date_due}</td>\n</tr>\n<tr>\n<td class=\"td-2\" colspan=\"2\">{task_description}</td>\n</tr>\n</tbody>\n</table>\n<p>You can manage your task via the dashboard.</p>\n</td>\n</tr>\n<tr>\n<td align=\"left\" bgcolor=\"#ffffff\">\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td class=\"td-button\">\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td align=\"center\"><a class=\"button\" href=\"{task_url}\" target=\"_blank\" rel=\"noopener\">View Task</a></td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<tr>\n<td class=\"signature\">\n<p>{email_signature}</p>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end copy block --> <!-- start footer -->\n<tr>\n<td class=\"p-24\" align=\"center\">\n<table class=\"footer\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start permission -->\n<tbody>\n<tr>\n<td align=\"center\">\n<p>{email_footer}</p>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end footer --></tbody>\n</table>\n<!-- end body -->\n</body>\n\n</html>', '{first_name}, {last_name}, {comment}, {poster_first_name}, {poster_last_name}, {task_id}, {task_title}, {task_created_date}, {task_date_start}, {task_description}, {task_date_due}, {project_title}, {project_id}, {client_name}, {client_id}, {task_status}, {task_milestone}, {task_url}', '2019-12-08 17:13:10', '2021-06-07 19:20:43', 'enabled', 'english', 'yes', 'yes', 140),
(NULL, NULL, 'New Proposal', 'template_lang_new_proposal', 'client', 'proposals', 'New Proposal - #{proposal_id}', '<!DOCTYPE html>\n<html>\n\n<head>\n\n    <meta charset=\"utf-8\">\n    <meta http-equiv=\"x-ua-compatible\" content=\"ie=edge\">\n    <title>Email Confirmation</title>\n    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">\n    <style type=\"text/css\">\n        @media screen {\n            @font-face {\n                font-family: \'Source Sans Pro\';\n                font-style: normal;\n                font-weight: 400;\n                src: local(\'Source Sans Pro Regular\'), local(\'SourceSansPro-Regular\'), url(https://fonts.gstatic.com/s/sourcesanspro/v10/ODelI1aHBYDBqgeIAH2zlBM0YzuT7MdOe03otPbuUS0.woff) format(\'woff\');\n            }\n\n            @font-face {\n                font-family: \'Source Sans Pro\';\n                font-style: normal;\n                font-weight: 700;\n                src: local(\'Source Sans Pro Bold\'), local(\'SourceSansPro-Bold\'), url(https://fonts.gstatic.com/s/sourcesanspro/v10/toadOcfmlt9b38dHJxOBGFkQc6VGVFSmCnC_l7QZG60.woff) format(\'woff\');\n            }\n        }\n\n        body,\n        table,\n        td,\n        a {\n            -ms-text-size-adjust: 100%;\n            /* 1 */\n            -webkit-text-size-adjust: 100%;\n            /* 2 */\n        }\n\n        img {\n            -ms-interpolation-mode: bicubic;\n        }\n\n        a[x-apple-data-detectors] {\n            font-family: inherit !important;\n            font-size: inherit !important;\n            font-weight: inherit !important;\n            line-height: inherit !important;\n            color: inherit !important;\n            text-decoration: none !important;\n        }\n\n        div[style*=\"margin: 16px 0;\"] {\n            margin: 0 !important;\n        }\n\n        body {\n            width: 100% !important;\n            height: 100% !important;\n            padding: 0 !important;\n            margin: 0 !important;\n            padding: 24px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 16px;\n            background-color: #f9fafc;\n            color: #60676d;\n        }\n\n        table {\n            border-collapse: collapse !important;\n        }\n\n        a {\n            color: #1a82e2;\n        }\n\n        img {\n            height: auto;\n            line-height: 100%;\n            text-decoration: none;\n            border: 0;\n            outline: none;\n        }\n\n        .table-1 {\n            max-width: 600px;\n        }\n\n        .table-1 td {\n            padding: 36px 24px 40px;\n            text-align: center;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-1 h1 {\n            margin: 0;\n            font-size: 32px;\n            font-weight: 600;\n            letter-spacing: -1px;\n            line-height: 48px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-2 {\n            max-width: 600px;\n        }\n\n        .table-2 td {\n            padding: 36px 24px 0;\n            border-top: 3px solid #d4dadf;\n            background-color: #ffffff;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-2 h1 {\n            margin: 0;\n            font-size: 20px;\n            font-weight: 600;\n            letter-spacing: -1px;\n            line-height: 48px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-3 {\n            max-width: 600px;\n        }\n\n        .table-2 td {\n\n            background-color: #ffffff;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .td-1 {\n            padding: 24px;\n            font-size: 16px;\n            line-height: 24px;\n            background-color: #ffffff;\n            text-align: left;\n            padding-bottom: 10px;\n            padding-top: 0px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-gray {\n            width: 100%;\n        }\n\n        .table-gray tr {\n            height: 24px;\n        }\n\n        .table-gray .td-1 {\n            background-color: #f1f3f7;\n            width: 30%;\n            border: solid 1px #e7e9ec;\n            padding-top: 5px;\n            padding-bottom: 5px;\n            font-size:16px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-gray .td-2 {\n            background-color: #f1f3f7;\n            width: 70%;\n            border: solid 1px #e7e9ec;\n            font-size:16px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .button, .button:active, .button:visited {\n            display: inline-block;\n            padding: 16px 36px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 16px;\n            color: #ffffff;\n            text-decoration: none;\n            border-radius: 6px;\n            background-color: #1a82e2;\n            border-radius: 6px;\n        }\n\n        .signature {\n            padding: 24px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 16px;\n            line-height: 24px;\n            border-bottom: 3px solid #d4dadf;\n            background-color: #ffffff;\n        }\n\n        .footer {\n            max-width: 600px;\n        }\n\n        .footer td {\n            padding: 12px 24px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 14px;\n            line-height: 20px;\n            color: #666;\n        }\n\n        .td-button {\n            padding: 12px;\n            background-color: #ffffff;\n            text-align: center;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .p-24 {\n            padding: 24px;\n        }\n    </style>\n\n</head>\n\n<body>\n<!-- start body -->\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start hero -->\n<tbody>\n<tr>\n<td align=\"center\">\n<table class=\"table-1\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td align=\"left\">\n<h1>New Proposal</h1>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end hero --> <!-- start hero -->\n<tr>\n<td align=\"center\">\n<table class=\"table-2\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td align=\"left\">\n<h1>Hi {first_name},</h1>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end hero --> <!-- start copy block -->\n<tr>\n<td align=\"center\">\n<table class=\"table-3\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start copy -->\n<tbody>\n<tr>\n<td class=\"td-1\">\n<p>Please find attached our proposal for your project.</p>\n</td>\n</tr>\n<tr>\n<td class=\"td-1\">\n<table class=\"table-gray\" style=\"width: 100%;\" cellpadding=\"5\">\n<tbody>\n<tr>\n<td class=\"td-1\"><strong>Proposal Title</strong></td>\n<td class=\"td-2\">{proposal_title}</td>\n</tr>\n<tr>\n<td class=\"td-1\"><strong>Proposal ID</strong></td>\n<td class=\"td-2\">{proposal_id}</td>\n</tr>\n<tr>\n<td class=\"td-1\"><strong>Proposal Value</strong></td>\n<td class=\"td-2\">{proposal_value}</td>\n</tr>\n<tr>\n<td class=\"td-1\"><strong>Proposal Date</strong></td>\n<td class=\"td-2\">{proposal_date}</td>\n</tr>\n<tr>\n<td class=\"td-1\"><strong>Valid Until Date</strong></td>\n<td class=\"td-2\">{proposal_expiry_date}</td>\n</tr>\n</tbody>\n</table>\n<p>You can view the proposal using the link below</p>\n</td>\n</tr>\n<tr>\n<td align=\"left\" bgcolor=\"#ffffff\">\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td class=\"td-button\">\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td align=\"center\"><a class=\"button\" href=\"{proposal_url}\" target=\"_blank\" rel=\"noopener\">View Proposal</a></td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<tr>\n<td class=\"signature\">\n<p>{email_signature}</p>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end copy block --> <!-- start footer -->\n<tr>\n<td class=\"p-24\" align=\"center\">\n<table class=\"footer\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start permission -->\n<tbody>\n<tr>\n<td align=\"center\">\n<p>{email_footer}</p>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end footer --></tbody>\n</table>\n<!-- end body -->\n</body>\n\n</html>', '{first_name}, {last_name}, {proposal_id}, {proposal_title}, {proposal_value}, {proposal_date}, {proposal_expiry_date}, {proposal_url}', '2019-12-08 17:13:10', '2022-05-20 05:04:09', 'enabled', 'english', 'yes', 'yes', 142),
(NULL, NULL, 'Proposal Accepted', 'template_lang_proposal_accepted', 'team', 'proposals', 'Proposal Had Been Accepted - #{proposal_id}', '<!DOCTYPE html>\n<html>\n\n<head>\n\n    <meta charset=\"utf-8\">\n    <meta http-equiv=\"x-ua-compatible\" content=\"ie=edge\">\n    <title>Email Confirmation</title>\n    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">\n    <style type=\"text/css\">\n        @media screen {\n            @font-face {\n                font-family: \'Source Sans Pro\';\n                font-style: normal;\n                font-weight: 400;\n                src: local(\'Source Sans Pro Regular\'), local(\'SourceSansPro-Regular\'), url(https://fonts.gstatic.com/s/sourcesanspro/v10/ODelI1aHBYDBqgeIAH2zlBM0YzuT7MdOe03otPbuUS0.woff) format(\'woff\');\n            }\n\n            @font-face {\n                font-family: \'Source Sans Pro\';\n                font-style: normal;\n                font-weight: 700;\n                src: local(\'Source Sans Pro Bold\'), local(\'SourceSansPro-Bold\'), url(https://fonts.gstatic.com/s/sourcesanspro/v10/toadOcfmlt9b38dHJxOBGFkQc6VGVFSmCnC_l7QZG60.woff) format(\'woff\');\n            }\n        }\n\n        body,\n        table,\n        td,\n        a {\n            -ms-text-size-adjust: 100%;\n            /* 1 */\n            -webkit-text-size-adjust: 100%;\n            /* 2 */\n        }\n\n        img {\n            -ms-interpolation-mode: bicubic;\n        }\n\n        a[x-apple-data-detectors] {\n            font-family: inherit !important;\n            font-size: inherit !important;\n            font-weight: inherit !important;\n            line-height: inherit !important;\n            color: inherit !important;\n            text-decoration: none !important;\n        }\n\n        div[style*=\"margin: 16px 0;\"] {\n            margin: 0 !important;\n        }\n\n        body {\n            width: 100% !important;\n            height: 100% !important;\n            padding: 0 !important;\n            margin: 0 !important;\n            padding: 24px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 16px;\n            background-color: #f9fafc;\n            color: #60676d;\n        }\n\n        table {\n            border-collapse: collapse !important;\n        }\n\n        a {\n            color: #1a82e2;\n        }\n\n        img {\n            height: auto;\n            line-height: 100%;\n            text-decoration: none;\n            border: 0;\n            outline: none;\n        }\n\n        .table-1 {\n            max-width: 600px;\n        }\n\n        .table-1 td {\n            padding: 36px 24px 40px;\n            text-align: center;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-1 h1 {\n            margin: 0;\n            font-size: 32px;\n            font-weight: 600;\n            letter-spacing: -1px;\n            line-height: 48px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-2 {\n            max-width: 600px;\n        }\n\n        .table-2 td {\n            padding: 36px 24px 0;\n            border-top: 3px solid #d4dadf;\n            background-color: #ffffff;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-2 h1 {\n            margin: 0;\n            font-size: 20px;\n            font-weight: 600;\n            letter-spacing: -1px;\n            line-height: 48px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-3 {\n            max-width: 600px;\n        }\n\n        .table-2 td {\n\n            background-color: #ffffff;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .td-1 {\n            padding: 24px;\n            font-size: 16px;\n            line-height: 24px;\n            background-color: #ffffff;\n            text-align: left;\n            padding-bottom: 10px;\n            padding-top: 0px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-gray {\n            width: 100%;\n        }\n\n        .table-gray tr {\n            height: 24px;\n        }\n\n        .table-gray .td-1 {\n            background-color: #f1f3f7;\n            width: 30%;\n            border: solid 1px #e7e9ec;\n            padding-top: 5px;\n            padding-bottom: 5px;\n            font-size:16px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-gray .td-2 {\n            background-color: #f1f3f7;\n            width: 70%;\n            border: solid 1px #e7e9ec;\n            font-size:16px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .button, .button:active, .button:visited {\n            display: inline-block;\n            padding: 16px 36px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 16px;\n            color: #ffffff;\n            text-decoration: none;\n            border-radius: 6px;\n            background-color: #1a82e2;\n            border-radius: 6px;\n        }\n\n        .signature {\n            padding: 24px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 16px;\n            line-height: 24px;\n            border-bottom: 3px solid #d4dadf;\n            background-color: #ffffff;\n        }\n\n        .footer {\n            max-width: 600px;\n        }\n\n        .footer td {\n            padding: 12px 24px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 14px;\n            line-height: 20px;\n            color: #666;\n        }\n\n        .td-button {\n            padding: 12px;\n            background-color: #ffffff;\n            text-align: center;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .p-24 {\n            padding: 24px;\n        }\n    </style>\n\n</head>\n\n<body>\n<!-- start body -->\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start hero -->\n<tbody>\n<tr>\n<td align=\"center\">\n<table class=\"table-1\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td align=\"left\">\n<h1>Proposal Accepted</h1>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end hero --> <!-- start hero -->\n<tr>\n<td align=\"center\">\n<table class=\"table-2\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td align=\"left\">\n<h1>Hi {first_name},</h1>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end hero --> <!-- start copy block -->\n<tr>\n<td align=\"center\">\n<table class=\"table-3\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start copy -->\n<tbody>\n<tr>\n<td class=\"td-1\">\n<p>The client has accepted the proposal.</p>\n</td>\n</tr>\n<tr>\n<td class=\"td-1\">\n<table class=\"table-gray\" style=\"width: 100%;\" cellpadding=\"5\">\n<tbody>\n<tr>\n<td class=\"td-1\"><strong>Proposal Title</strong></td>\n<td class=\"td-2\">{proposal_title}</td>\n</tr>\n<tr>\n<td class=\"td-1\"><strong>Proposal ID</strong></td>\n<td class=\"td-2\">{proposal_id}</td>\n</tr>\n<tr>\n<td class=\"td-1\"><strong>Proposal Value</strong></td>\n<td class=\"td-2\">{proposal_value}</td>\n</tr>\n<tr>\n<td class=\"td-1\"><strong>Proposal Date</strong></td>\n<td class=\"td-2\">{proposal_date}</td>\n</tr>\n<tr>\n<td class=\"td-1\"><strong>Valid Until Date</strong></td>\n<td class=\"td-2\">{proposal_expiry_date}</td>\n</tr>\n</tbody>\n</table>\n<p>You can view the proposal using the link below</p>\n</td>\n</tr>\n<tr>\n<td align=\"left\" bgcolor=\"#ffffff\">\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td class=\"td-button\">\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td align=\"center\"><a class=\"button\" href=\"{proposal_url}\" target=\"_blank\" rel=\"noopener\">View Proposal</a></td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<tr>\n<td class=\"signature\">\n<p>{email_signature}</p>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end copy block --> <!-- start footer -->\n<tr>\n<td class=\"p-24\" align=\"center\">\n<table class=\"footer\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start permission -->\n<tbody>\n<tr>\n<td align=\"center\">\n<p>{email_footer}</p>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end footer --></tbody>\n</table>\n<!-- end body -->\n</body>\n\n</html>', '{first_name}, {last_name}, {proposal_id}, {proposal_title}, {proposal_value}, {proposal_date}, {proposal_expiry_date}, {proposal_url}', '2019-12-08 17:13:10', '2022-05-20 05:05:09', 'enabled', 'english', 'yes', 'yes', 143),
(NULL, NULL, 'Proposal Declined', 'template_lang_proposal_declined', 'team', 'proposals', 'Proposal Had Been Declined - #{proposal_id}', '<!DOCTYPE html>\n<html>\n\n<head>\n\n    <meta charset=\"utf-8\">\n    <meta http-equiv=\"x-ua-compatible\" content=\"ie=edge\">\n    <title>Email Confirmation</title>\n    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">\n    <style type=\"text/css\">\n        @media screen {\n            @font-face {\n                font-family: \'Source Sans Pro\';\n                font-style: normal;\n                font-weight: 400;\n                src: local(\'Source Sans Pro Regular\'), local(\'SourceSansPro-Regular\'), url(https://fonts.gstatic.com/s/sourcesanspro/v10/ODelI1aHBYDBqgeIAH2zlBM0YzuT7MdOe03otPbuUS0.woff) format(\'woff\');\n            }\n\n            @font-face {\n                font-family: \'Source Sans Pro\';\n                font-style: normal;\n                font-weight: 700;\n                src: local(\'Source Sans Pro Bold\'), local(\'SourceSansPro-Bold\'), url(https://fonts.gstatic.com/s/sourcesanspro/v10/toadOcfmlt9b38dHJxOBGFkQc6VGVFSmCnC_l7QZG60.woff) format(\'woff\');\n            }\n        }\n\n        body,\n        table,\n        td,\n        a {\n            -ms-text-size-adjust: 100%;\n            /* 1 */\n            -webkit-text-size-adjust: 100%;\n            /* 2 */\n        }\n\n        img {\n            -ms-interpolation-mode: bicubic;\n        }\n\n        a[x-apple-data-detectors] {\n            font-family: inherit !important;\n            font-size: inherit !important;\n            font-weight: inherit !important;\n            line-height: inherit !important;\n            color: inherit !important;\n            text-decoration: none !important;\n        }\n\n        div[style*=\"margin: 16px 0;\"] {\n            margin: 0 !important;\n        }\n\n        body {\n            width: 100% !important;\n            height: 100% !important;\n            padding: 0 !important;\n            margin: 0 !important;\n            padding: 24px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 16px;\n            background-color: #f9fafc;\n            color: #60676d;\n        }\n\n        table {\n            border-collapse: collapse !important;\n        }\n\n        a {\n            color: #1a82e2;\n        }\n\n        img {\n            height: auto;\n            line-height: 100%;\n            text-decoration: none;\n            border: 0;\n            outline: none;\n        }\n\n        .table-1 {\n            max-width: 600px;\n        }\n\n        .table-1 td {\n            padding: 36px 24px 40px;\n            text-align: center;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-1 h1 {\n            margin: 0;\n            font-size: 32px;\n            font-weight: 600;\n            letter-spacing: -1px;\n            line-height: 48px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-2 {\n            max-width: 600px;\n        }\n\n        .table-2 td {\n            padding: 36px 24px 0;\n            border-top: 3px solid #d4dadf;\n            background-color: #ffffff;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-2 h1 {\n            margin: 0;\n            font-size: 20px;\n            font-weight: 600;\n            letter-spacing: -1px;\n            line-height: 48px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-3 {\n            max-width: 600px;\n        }\n\n        .table-2 td {\n\n            background-color: #ffffff;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .td-1 {\n            padding: 24px;\n            font-size: 16px;\n            line-height: 24px;\n            background-color: #ffffff;\n            text-align: left;\n            padding-bottom: 10px;\n            padding-top: 0px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-gray {\n            width: 100%;\n        }\n\n        .table-gray tr {\n            height: 24px;\n        }\n\n        .table-gray .td-1 {\n            background-color: #f1f3f7;\n            width: 30%;\n            border: solid 1px #e7e9ec;\n            padding-top: 5px;\n            padding-bottom: 5px;\n            font-size:16px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-gray .td-2 {\n            background-color: #f1f3f7;\n            width: 70%;\n            border: solid 1px #e7e9ec;\n            font-size:16px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .button, .button:active, .button:visited {\n            display: inline-block;\n            padding: 16px 36px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 16px;\n            color: #ffffff;\n            text-decoration: none;\n            border-radius: 6px;\n            background-color: #1a82e2;\n            border-radius: 6px;\n        }\n\n        .signature {\n            padding: 24px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 16px;\n            line-height: 24px;\n            border-bottom: 3px solid #d4dadf;\n            background-color: #ffffff;\n        }\n\n        .footer {\n            max-width: 600px;\n        }\n\n        .footer td {\n            padding: 12px 24px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 14px;\n            line-height: 20px;\n            color: #666;\n        }\n\n        .td-button {\n            padding: 12px;\n            background-color: #ffffff;\n            text-align: center;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .p-24 {\n            padding: 24px;\n        }\n    </style>\n\n</head>\n\n<body>\n<!-- start body -->\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start hero -->\n<tbody>\n<tr>\n<td align=\"center\">\n<table class=\"table-1\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td align=\"left\">\n<h1>Proposal Declined</h1>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end hero --> <!-- start hero -->\n<tr>\n<td align=\"center\">\n<table class=\"table-2\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td align=\"left\">\n<h1>Hi {first_name},</h1>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end hero --> <!-- start copy block -->\n<tr>\n<td align=\"center\">\n<table class=\"table-3\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start copy -->\n<tbody>\n<tr>\n<td class=\"td-1\">\n<p>The client has declined the proposal.</p>\n</td>\n</tr>\n<tr>\n<td class=\"td-1\">\n<table class=\"table-gray\" style=\"width: 100%;\" cellpadding=\"5\">\n<tbody>\n<tr>\n<td class=\"td-1\"><strong>Proposal Title</strong></td>\n<td class=\"td-2\">{proposal_title}</td>\n</tr>\n<tr>\n<td class=\"td-1\"><strong>Proposal ID</strong></td>\n<td class=\"td-2\">{proposal_id}</td>\n</tr>\n<tr>\n<td class=\"td-1\"><strong>Proposal Value</strong></td>\n<td class=\"td-2\">{proposal_value}</td>\n</tr>\n<tr>\n<td class=\"td-1\"><strong>Proposal Date</strong></td>\n<td class=\"td-2\">{proposal_date}</td>\n</tr>\n<tr>\n<td class=\"td-1\"><strong>Valid Until Date</strong></td>\n<td class=\"td-2\">{proposal_expiry_date}</td>\n</tr>\n</tbody>\n</table>\n<p>You can view the proposal using the link below</p>\n</td>\n</tr>\n<tr>\n<td align=\"left\" bgcolor=\"#ffffff\">\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td class=\"td-button\">\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td align=\"center\"><a class=\"button\" href=\"{proposal_url}\" target=\"_blank\" rel=\"noopener\">View Proposal</a></td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<tr>\n<td class=\"signature\">\n<p>{email_signature}</p>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end copy block --> <!-- start footer -->\n<tr>\n<td class=\"p-24\" align=\"center\">\n<table class=\"footer\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start permission -->\n<tbody>\n<tr>\n<td align=\"center\">\n<p>{email_footer}</p>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end footer --></tbody>\n</table>\n<!-- end body -->\n</body>\n\n</html>', '{first_name}, {last_name}, {proposal_id}, {proposal_title}, {proposal_value}, {proposal_date}, {proposal_expiry_date}, {proposal_url}', '2019-12-08 17:13:10', '2022-05-20 05:05:44', 'enabled', 'english', 'yes', 'yes', 144),
(NULL, NULL, 'New Contract', 'template_lang_new_contract', 'client', 'contracts', 'New Contract - #{contract_id}', '<!DOCTYPE html>\n<html>\n\n<head>\n\n    <meta charset=\"utf-8\">\n    <meta http-equiv=\"x-ua-compatible\" content=\"ie=edge\">\n    <title>Email Confirmation</title>\n    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">\n    <style type=\"text/css\">\n        @media screen {\n            @font-face {\n                font-family: \'Source Sans Pro\';\n                font-style: normal;\n                font-weight: 400;\n                src: local(\'Source Sans Pro Regular\'), local(\'SourceSansPro-Regular\'), url(https://fonts.gstatic.com/s/sourcesanspro/v10/ODelI1aHBYDBqgeIAH2zlBM0YzuT7MdOe03otPbuUS0.woff) format(\'woff\');\n            }\n\n            @font-face {\n                font-family: \'Source Sans Pro\';\n                font-style: normal;\n                font-weight: 700;\n                src: local(\'Source Sans Pro Bold\'), local(\'SourceSansPro-Bold\'), url(https://fonts.gstatic.com/s/sourcesanspro/v10/toadOcfmlt9b38dHJxOBGFkQc6VGVFSmCnC_l7QZG60.woff) format(\'woff\');\n            }\n        }\n\n        body,\n        table,\n        td,\n        a {\n            -ms-text-size-adjust: 100%;\n            /* 1 */\n            -webkit-text-size-adjust: 100%;\n            /* 2 */\n        }\n\n        img {\n            -ms-interpolation-mode: bicubic;\n        }\n\n        a[x-apple-data-detectors] {\n            font-family: inherit !important;\n            font-size: inherit !important;\n            font-weight: inherit !important;\n            line-height: inherit !important;\n            color: inherit !important;\n            text-decoration: none !important;\n        }\n\n        div[style*=\"margin: 16px 0;\"] {\n            margin: 0 !important;\n        }\n\n        body {\n            width: 100% !important;\n            height: 100% !important;\n            padding: 0 !important;\n            margin: 0 !important;\n            padding: 24px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 16px;\n            background-color: #f9fafc;\n            color: #60676d;\n        }\n\n        table {\n            border-collapse: collapse !important;\n        }\n\n        a {\n            color: #1a82e2;\n        }\n\n        img {\n            height: auto;\n            line-height: 100%;\n            text-decoration: none;\n            border: 0;\n            outline: none;\n        }\n\n        .table-1 {\n            max-width: 600px;\n        }\n\n        .table-1 td {\n            padding: 36px 24px 40px;\n            text-align: center;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-1 h1 {\n            margin: 0;\n            font-size: 32px;\n            font-weight: 600;\n            letter-spacing: -1px;\n            line-height: 48px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-2 {\n            max-width: 600px;\n        }\n\n        .table-2 td {\n            padding: 36px 24px 0;\n            border-top: 3px solid #d4dadf;\n            background-color: #ffffff;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-2 h1 {\n            margin: 0;\n            font-size: 20px;\n            font-weight: 600;\n            letter-spacing: -1px;\n            line-height: 48px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-3 {\n            max-width: 600px;\n        }\n\n        .table-2 td {\n\n            background-color: #ffffff;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .td-1 {\n            padding: 24px;\n            font-size: 16px;\n            line-height: 24px;\n            background-color: #ffffff;\n            text-align: left;\n            padding-bottom: 10px;\n            padding-top: 0px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-gray {\n            width: 100%;\n        }\n\n        .table-gray tr {\n            height: 24px;\n        }\n\n        .table-gray .td-1 {\n            background-color: #f1f3f7;\n            width: 30%;\n            border: solid 1px #e7e9ec;\n            padding-top: 5px;\n            padding-bottom: 5px;\n            font-size:16px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-gray .td-2 {\n            background-color: #f1f3f7;\n            width: 70%;\n            border: solid 1px #e7e9ec;\n            font-size:16px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .button, .button:active, .button:visited {\n            display: inline-block;\n            padding: 16px 36px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 16px;\n            color: #ffffff;\n            text-decoration: none;\n            border-radius: 6px;\n            background-color: #1a82e2;\n            border-radius: 6px;\n        }\n\n        .signature {\n            padding: 24px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 16px;\n            line-height: 24px;\n            border-bottom: 3px solid #d4dadf;\n            background-color: #ffffff;\n        }\n\n        .footer {\n            max-width: 600px;\n        }\n\n        .footer td {\n            padding: 12px 24px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 14px;\n            line-height: 20px;\n            color: #666;\n        }\n\n        .td-button {\n            padding: 12px;\n            background-color: #ffffff;\n            text-align: center;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .p-24 {\n            padding: 24px;\n        }\n    </style>\n\n</head>\n\n<body>\n<!-- start body -->\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start hero -->\n<tbody>\n<tr>\n<td align=\"center\">\n<table class=\"table-1\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td align=\"left\">\n<h1>New Contract</h1>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end hero --> <!-- start hero -->\n<tr>\n<td align=\"center\">\n<table class=\"table-2\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td align=\"left\">\n<h1>Hi {first_name},</h1>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end hero --> <!-- start copy block -->\n<tr>\n<td align=\"center\">\n<table class=\"table-3\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start copy -->\n<tbody>\n<tr>\n<td class=\"td-1\">\n<p>We have prepared a contract for you to review and sign.</p>\n</td>\n</tr>\n<tr>\n<td class=\"td-1\">\n<table class=\"table-gray\" style=\"width: 100%;\" cellpadding=\"5\">\n<tbody>\n<tr>\n<td class=\"td-1\"><strong>Contract Title</strong></td>\n<td class=\"td-2\">{contract_title}</td>\n</tr>\n<tr>\n<td class=\"td-1\"><strong>Contract ID</strong></td>\n<td class=\"td-2\">{contract_id}</td>\n</tr>\n<tr>\n<td class=\"td-1\"><strong>Value</strong></td>\n<td class=\"td-2\">{contract_value}</td>\n</tr>\n<tr>\n<td class=\"td-1\"><strong>Date</strong></td>\n<td class=\"td-2\">{contract_date}</td>\n</tr>\n<tr>\n<td class=\"td-1\"><strong>End Date</strong></td>\n<td class=\"td-2\">{contract_end_date}</td>\n</tr>\n</tbody>\n</table>\n<p>You can view the contract using the link below</p>\n</td>\n</tr>\n<tr>\n<td align=\"left\" bgcolor=\"#ffffff\">\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td class=\"td-button\">\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td align=\"center\"><a class=\"button\" href=\"{contract_url}\" target=\"_blank\" rel=\"noopener\">View Contract</a></td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<tr>\n<td class=\"signature\">\n<p>{email_signature}</p>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end copy block --> <!-- start footer -->\n<tr>\n<td class=\"p-24\" align=\"center\">\n<table class=\"footer\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start permission -->\n<tbody>\n<tr>\n<td align=\"center\">\n<p>{email_footer}</p>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end footer --></tbody>\n</table>\n<!-- end body -->\n</body>\n\n</html>', '{first_name}, {last_name}, {contract_id}, {contract_title}, {contract_date}, {contract_end_date}, {contract_value}, {contract_url}', '2019-12-08 17:13:10', '2023-03-28 09:12:14', 'enabled', 'english', 'yes', 'yes', 151);
INSERT INTO `email_templates` (`emailtemplate_module_unique_id`, `emailtemplate_module_name`, `emailtemplate_name`, `emailtemplate_lang`, `emailtemplate_type`, `emailtemplate_category`, `emailtemplate_subject`, `emailtemplate_body`, `emailtemplate_variables`, `emailtemplate_created`, `emailtemplate_updated`, `emailtemplate_status`, `emailtemplate_language`, `emailtemplate_real_template`, `emailtemplate_show_enabled`, `emailtemplate_id`) VALUES
(NULL, NULL, 'Contract Signed', 'template_lang_contract_signed', 'team', 'contracts', 'Contract Has Been Signed - #{contract_id}', '<!DOCTYPE html>\r\n<html>\r\n\r\n<head>\r\n\r\n    <meta charset=\"utf-8\">\r\n    <meta http-equiv=\"x-ua-compatible\" content=\"ie=edge\">\r\n    <title>Email Confirmation</title>\r\n    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">\r\n    <style type=\"text/css\">\r\n        @media screen {\r\n            @font-face {\r\n                font-family: \'Source Sans Pro\';\r\n                font-style: normal;\r\n                font-weight: 400;\r\n                src: local(\'Source Sans Pro Regular\'), local(\'SourceSansPro-Regular\'), url(https://fonts.gstatic.com/s/sourcesanspro/v10/ODelI1aHBYDBqgeIAH2zlBM0YzuT7MdOe03otPbuUS0.woff) format(\'woff\');\r\n            }\r\n\r\n            @font-face {\r\n                font-family: \'Source Sans Pro\';\r\n                font-style: normal;\r\n                font-weight: 700;\r\n                src: local(\'Source Sans Pro Bold\'), local(\'SourceSansPro-Bold\'), url(https://fonts.gstatic.com/s/sourcesanspro/v10/toadOcfmlt9b38dHJxOBGFkQc6VGVFSmCnC_l7QZG60.woff) format(\'woff\');\r\n            }\r\n        }\r\n\r\n        body,\r\n        table,\r\n        td,\r\n        a {\r\n            -ms-text-size-adjust: 100%;\r\n            /* 1 */\r\n            -webkit-text-size-adjust: 100%;\r\n            /* 2 */\r\n        }\r\n\r\n        img {\r\n            -ms-interpolation-mode: bicubic;\r\n        }\r\n\r\n        a[x-apple-data-detectors] {\r\n            font-family: inherit !important;\r\n            font-size: inherit !important;\r\n            font-weight: inherit !important;\r\n            line-height: inherit !important;\r\n            color: inherit !important;\r\n            text-decoration: none !important;\r\n        }\r\n\r\n        div[style*=\"margin: 16px 0;\"] {\r\n            margin: 0 !important;\r\n        }\r\n\r\n        body {\r\n            width: 100% !important;\r\n            height: 100% !important;\r\n            padding: 0 !important;\r\n            margin: 0 !important;\r\n            padding: 24px;\r\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\r\n            font-size: 16px;\r\n            background-color: #f9fafc;\r\n            color: #60676d;\r\n        }\r\n\r\n        table {\r\n            border-collapse: collapse !important;\r\n        }\r\n\r\n        a {\r\n            color: #1a82e2;\r\n        }\r\n\r\n        img {\r\n            height: auto;\r\n            line-height: 100%;\r\n            text-decoration: none;\r\n            border: 0;\r\n            outline: none;\r\n        }\r\n\r\n        .table-1 {\r\n            max-width: 600px;\r\n        }\r\n\r\n        .table-1 td {\r\n            padding: 36px 24px 40px;\r\n            text-align: center;\r\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\r\n        }\r\n\r\n        .table-1 h1 {\r\n            margin: 0;\r\n            font-size: 32px;\r\n            font-weight: 600;\r\n            letter-spacing: -1px;\r\n            line-height: 48px;\r\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\r\n        }\r\n\r\n        .table-2 {\r\n            max-width: 600px;\r\n        }\r\n\r\n        .table-2 td {\r\n            padding: 36px 24px 0;\r\n            border-top: 3px solid #d4dadf;\r\n            background-color: #ffffff;\r\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\r\n        }\r\n\r\n        .table-2 h1 {\r\n            margin: 0;\r\n            font-size: 20px;\r\n            font-weight: 600;\r\n            letter-spacing: -1px;\r\n            line-height: 48px;\r\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\r\n        }\r\n\r\n        .table-3 {\r\n            max-width: 600px;\r\n        }\r\n\r\n        .table-2 td {\r\n\r\n            background-color: #ffffff;\r\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\r\n        }\r\n\r\n        .td-1 {\r\n            padding: 24px;\r\n            font-size: 16px;\r\n            line-height: 24px;\r\n            background-color: #ffffff;\r\n            text-align: left;\r\n            padding-bottom: 10px;\r\n            padding-top: 0px;\r\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\r\n        }\r\n\r\n        .table-gray {\r\n            width: 100%;\r\n        }\r\n\r\n        .table-gray tr {\r\n            height: 24px;\r\n        }\r\n\r\n        .table-gray .td-1 {\r\n            background-color: #f1f3f7;\r\n            width: 30%;\r\n            border: solid 1px #e7e9ec;\r\n            padding-top: 5px;\r\n            padding-bottom: 5px;\r\n            font-size:16px;\r\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\r\n        }\r\n\r\n        .table-gray .td-2 {\r\n            background-color: #f1f3f7;\r\n            width: 70%;\r\n            border: solid 1px #e7e9ec;\r\n            font-size:16px;\r\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\r\n        }\r\n\r\n        .button, .button:active, .button:visited {\r\n            display: inline-block;\r\n            padding: 16px 36px;\r\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\r\n            font-size: 16px;\r\n            color: #ffffff;\r\n            text-decoration: none;\r\n            border-radius: 6px;\r\n            background-color: #1a82e2;\r\n            border-radius: 6px;\r\n        }\r\n\r\n        .signature {\r\n            padding: 24px;\r\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\r\n            font-size: 16px;\r\n            line-height: 24px;\r\n            border-bottom: 3px solid #d4dadf;\r\n            background-color: #ffffff;\r\n        }\r\n\r\n        .footer {\r\n            max-width: 600px;\r\n        }\r\n\r\n        .footer td {\r\n            padding: 12px 24px;\r\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\r\n            font-size: 14px;\r\n            line-height: 20px;\r\n            color: #666;\r\n        }\r\n\r\n        .td-button {\r\n            padding: 12px;\r\n            background-color: #ffffff;\r\n            text-align: center;\r\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\r\n        }\r\n\r\n        .p-24 {\r\n            padding: 24px;\r\n        }\r\n    </style>\r\n\r\n</head>\r\n\r\n<body>\r\n<!-- start body -->\r\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start hero -->\r\n<tbody>\r\n<tr>\r\n<td align=\"center\">\r\n<table class=\"table-1\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\r\n<tbody>\r\n<tr>\r\n<td align=\"left\">\r\n<h1>Contract Accepted</h1>\r\n</td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n</td>\r\n</tr>\r\n<!-- end hero --> <!-- start hero -->\r\n<tr>\r\n<td align=\"center\">\r\n<table class=\"table-2\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\r\n<tbody>\r\n<tr>\r\n<td align=\"left\">\r\n<h1>Hi {first_name},</h1>\r\n</td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n</td>\r\n</tr>\r\n<!-- end hero --> <!-- start copy block -->\r\n<tr>\r\n<td align=\"center\">\r\n<table class=\"table-3\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start copy -->\r\n<tbody>\r\n<tr>\r\n<td class=\"td-1\">\r\n<p>The client has signed the contract.</p>\r\n</td>\r\n</tr>\r\n<tr>\r\n<td class=\"td-1\">\r\n<table class=\"table-gray\" style=\"width: 100%;\" cellpadding=\"5\">\r\n<tbody>\r\n<tr>\r\n<td class=\"td-1\"><strong>Contract Title</strong></td>\r\n<td class=\"td-2\">{contract_title}</td>\r\n</tr>\r\n<tr>\r\n<td class=\"td-1\"><strong>Contract ID</strong></td>\r\n<td class=\"td-2\">{contract_id}</td>\r\n</tr>\r\n<tr>\r\n<td class=\"td-1\"><strong>Value</strong></td>\r\n<td class=\"td-2\">{contract_value}</td>\r\n</tr>\r\n<tr>\r\n<td class=\"td-1\"><strong>Date</strong></td>\r\n<td class=\"td-2\">{contract_date}</td>\r\n</tr>\r\n<tr>\r\n<td class=\"td-1\"><strong>End Date</strong></td>\r\n<td class=\"td-2\">{contract_end_date}</td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n<p>You can view the contract using the link below</p>\r\n</td>\r\n</tr>\r\n<tr>\r\n<td align=\"left\" bgcolor=\"#ffffff\">\r\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\r\n<tbody>\r\n<tr>\r\n<td class=\"td-button\">\r\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\r\n<tbody>\r\n<tr>\r\n<td align=\"center\"><a class=\"button\" href=\"{contract_url}\" target=\"_blank\" rel=\"noopener\">View Contract</a></td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n</td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n</td>\r\n</tr>\r\n<tr>\r\n<td class=\"signature\">\r\n<p>{email_signature}</p>\r\n</td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n</td>\r\n</tr>\r\n<!-- end copy block --> <!-- start footer -->\r\n<tr>\r\n<td class=\"p-24\" align=\"center\">\r\n<table class=\"footer\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start permission -->\r\n<tbody>\r\n<tr>\r\n<td align=\"center\">\r\n<p>{email_footer}</p>\r\n</td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n</td>\r\n</tr>\r\n<!-- end footer --></tbody>\r\n</table>\r\n<!-- end body -->\r\n</body>\r\n\r\n</html>', '{first_name}, {last_name}, {contract_id}, {contract_title}, {contract_date}, {contract_end_date}, {contract_value}, {contract_url}', '2019-12-08 17:13:10', '2023-01-06 04:28:52', 'enabled', 'english', 'yes', 'yes', 152),
(NULL, NULL, 'Proposal Revised', 'template_lang_proposal_revised', 'client', 'proposals', 'Proposal Revised - #{proposal_id}', '<!DOCTYPE html>\n<html>\n\n<head>\n\n    <meta charset=\"utf-8\">\n    <meta http-equiv=\"x-ua-compatible\" content=\"ie=edge\">\n    <title>Email Confirmation</title>\n    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">\n    <style type=\"text/css\">\n        @media screen {\n            @font-face {\n                font-family: \'Source Sans Pro\';\n                font-style: normal;\n                font-weight: 400;\n                src: local(\'Source Sans Pro Regular\'), local(\'SourceSansPro-Regular\'), url(https://fonts.gstatic.com/s/sourcesanspro/v10/ODelI1aHBYDBqgeIAH2zlBM0YzuT7MdOe03otPbuUS0.woff) format(\'woff\');\n            }\n\n            @font-face {\n                font-family: \'Source Sans Pro\';\n                font-style: normal;\n                font-weight: 700;\n                src: local(\'Source Sans Pro Bold\'), local(\'SourceSansPro-Bold\'), url(https://fonts.gstatic.com/s/sourcesanspro/v10/toadOcfmlt9b38dHJxOBGFkQc6VGVFSmCnC_l7QZG60.woff) format(\'woff\');\n            }\n        }\n\n        body,\n        table,\n        td,\n        a {\n            -ms-text-size-adjust: 100%;\n            /* 1 */\n            -webkit-text-size-adjust: 100%;\n            /* 2 */\n        }\n\n        img {\n            -ms-interpolation-mode: bicubic;\n        }\n\n        a[x-apple-data-detectors] {\n            font-family: inherit !important;\n            font-size: inherit !important;\n            font-weight: inherit !important;\n            line-height: inherit !important;\n            color: inherit !important;\n            text-decoration: none !important;\n        }\n\n        div[style*=\"margin: 16px 0;\"] {\n            margin: 0 !important;\n        }\n\n        body {\n            width: 100% !important;\n            height: 100% !important;\n            padding: 0 !important;\n            margin: 0 !important;\n            padding: 24px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 16px;\n            background-color: #f9fafc;\n            color: #60676d;\n        }\n\n        table {\n            border-collapse: collapse !important;\n        }\n\n        a {\n            color: #1a82e2;\n        }\n\n        img {\n            height: auto;\n            line-height: 100%;\n            text-decoration: none;\n            border: 0;\n            outline: none;\n        }\n\n        .table-1 {\n            max-width: 600px;\n        }\n\n        .table-1 td {\n            padding: 36px 24px 40px;\n            text-align: center;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-1 h1 {\n            margin: 0;\n            font-size: 32px;\n            font-weight: 600;\n            letter-spacing: -1px;\n            line-height: 48px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-2 {\n            max-width: 600px;\n        }\n\n        .table-2 td {\n            padding: 36px 24px 0;\n            border-top: 3px solid #d4dadf;\n            background-color: #ffffff;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-2 h1 {\n            margin: 0;\n            font-size: 20px;\n            font-weight: 600;\n            letter-spacing: -1px;\n            line-height: 48px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-3 {\n            max-width: 600px;\n        }\n\n        .table-2 td {\n\n            background-color: #ffffff;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .td-1 {\n            padding: 24px;\n            font-size: 16px;\n            line-height: 24px;\n            background-color: #ffffff;\n            text-align: left;\n            padding-bottom: 10px;\n            padding-top: 0px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-gray {\n            width: 100%;\n        }\n\n        .table-gray tr {\n            height: 24px;\n        }\n\n        .table-gray .td-1 {\n            background-color: #f1f3f7;\n            width: 30%;\n            border: solid 1px #e7e9ec;\n            padding-top: 5px;\n            padding-bottom: 5px;\n            font-size:16px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-gray .td-2 {\n            background-color: #f1f3f7;\n            width: 70%;\n            border: solid 1px #e7e9ec;\n            font-size:16px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .button, .button:active, .button:visited {\n            display: inline-block;\n            padding: 16px 36px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 16px;\n            color: #ffffff;\n            text-decoration: none;\n            border-radius: 6px;\n            background-color: #1a82e2;\n            border-radius: 6px;\n        }\n\n        .signature {\n            padding: 24px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 16px;\n            line-height: 24px;\n            border-bottom: 3px solid #d4dadf;\n            background-color: #ffffff;\n        }\n\n        .footer {\n            max-width: 600px;\n        }\n\n        .footer td {\n            padding: 12px 24px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 14px;\n            line-height: 20px;\n            color: #666;\n        }\n\n        .td-button {\n            padding: 12px;\n            background-color: #ffffff;\n            text-align: center;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .p-24 {\n            padding: 24px;\n        }\n    </style>\n\n</head>\n\n<body>\n<!-- start body -->\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start hero -->\n<tbody>\n<tr>\n<td align=\"center\">\n<table class=\"table-1\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td align=\"left\">\n<h1>Revised Proposal</h1>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end hero --> <!-- start hero -->\n<tr>\n<td align=\"center\">\n<table class=\"table-2\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td align=\"left\">\n<h1>Hi {first_name},</h1>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end hero --> <!-- start copy block -->\n<tr>\n<td align=\"center\">\n<table class=\"table-3\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start copy -->\n<tbody>\n<tr>\n<td class=\"td-1\">\n<p>Please find attached our revised proposal for your project.</p>\n</td>\n</tr>\n<tr>\n<td class=\"td-1\">\n<table class=\"table-gray\" style=\"width: 100%;\" cellpadding=\"5\">\n<tbody>\n<tr>\n<td class=\"td-1\"><strong>Proposal Title</strong></td>\n<td class=\"td-2\">{proposal_title}</td>\n</tr>\n<tr>\n<td class=\"td-1\"><strong>Proposal ID</strong></td>\n<td class=\"td-2\">{proposal_id}</td>\n</tr>\n<tr>\n<td class=\"td-1\"><strong>Proposal Value</strong></td>\n<td class=\"td-2\">{proposal_value}</td>\n</tr>\n<tr>\n<td class=\"td-1\"><strong>Proposal Date</strong></td>\n<td class=\"td-2\">{proposal_date}</td>\n</tr>\n<tr>\n<td class=\"td-1\"><strong>Valid Until Date</strong></td>\n<td class=\"td-2\">{proposal_expiry_date}</td>\n</tr>\n</tbody>\n</table>\n<p>You can view the proposal using the link below</p>\n</td>\n</tr>\n<tr>\n<td align=\"left\" bgcolor=\"#ffffff\">\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td class=\"td-button\">\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td align=\"center\"><a class=\"button\" href=\"{proposal_url}\" target=\"_blank\" rel=\"noopener\">View Proposal</a></td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<tr>\n<td class=\"signature\">\n<p>{email_signature}</p>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end copy block --> <!-- start footer -->\n<tr>\n<td class=\"p-24\" align=\"center\">\n<table class=\"footer\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start permission -->\n<tbody>\n<tr>\n<td align=\"center\">\n<p>{email_footer}</p>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end footer --></tbody>\n</table>\n<!-- end body -->\n</body>\n\n</html>', '{first_name}, {last_name}, {proposal_id}, {proposal_title}, {proposal_value}, {proposal_date}, {proposal_expiry_date}, {proposal_url}', '2019-12-08 17:13:10', '2022-05-29 08:05:02', 'enabled', 'english', 'yes', 'yes', 148),
(NULL, NULL, 'Reminder', 'reminder', 'everyone', 'other', 'Due Reminder - {reminder_title}', '<!DOCTYPE html>\n<html>\n\n<head>\n\n    <meta charset=\"utf-8\">\n    <meta http-equiv=\"x-ua-compatible\" content=\"ie=edge\">\n    <title>Email Confirmation</title>\n    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">\n    <style type=\"text/css\">\n        @media screen {\n            @font-face {\n                font-family: \'Source Sans Pro\';\n                font-style: normal;\n                font-weight: 400;\n                src: local(\'Source Sans Pro Regular\'), local(\'SourceSansPro-Regular\'), url(https://fonts.gstatic.com/s/sourcesanspro/v10/ODelI1aHBYDBqgeIAH2zlBM0YzuT7MdOe03otPbuUS0.woff) format(\'woff\');\n            }\n\n            @font-face {\n                font-family: \'Source Sans Pro\';\n                font-style: normal;\n                font-weight: 700;\n                src: local(\'Source Sans Pro Bold\'), local(\'SourceSansPro-Bold\'), url(https://fonts.gstatic.com/s/sourcesanspro/v10/toadOcfmlt9b38dHJxOBGFkQc6VGVFSmCnC_l7QZG60.woff) format(\'woff\');\n            }\n        }\n\n        body,\n        table,\n        td,\n        a {\n            -ms-text-size-adjust: 100%;\n            /* 1 */\n            -webkit-text-size-adjust: 100%;\n            /* 2 */\n        }\n\n        img {\n            -ms-interpolation-mode: bicubic;\n        }\n\n        a[x-apple-data-detectors] {\n            font-family: inherit !important;\n            font-size: inherit !important;\n            font-weight: inherit !important;\n            line-height: inherit !important;\n            color: inherit !important;\n            text-decoration: none !important;\n        }\n\n        div[style*=\"margin: 16px 0;\"] {\n            margin: 0 !important;\n        }\n\n        body {\n            width: 100% !important;\n            height: 100% !important;\n            padding: 0 !important;\n            margin: 0 !important;\n            padding: 24px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 16px;\n            background-color: #f9fafc;\n            color: #60676d;\n        }\n\n        table {\n            border-collapse: collapse !important;\n        }\n\n        a {\n            color: #1a82e2;\n        }\n\n        img {\n            height: auto;\n            line-height: 100%;\n            text-decoration: none;\n            border: 0;\n            outline: none;\n        }\n\n        .table-1 {\n            max-width: 600px;\n        }\n\n        .table-1 td {\n            padding: 36px 24px 40px;\n            text-align: center;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-1 h1 {\n            margin: 0;\n            font-size: 32px;\n            font-weight: 600;\n            letter-spacing: -1px;\n            line-height: 48px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-2 {\n            max-width: 600px;\n        }\n\n        .table-2 td {\n            padding: 36px 24px 0;\n            border-top: 3px solid #d4dadf;\n            background-color: #ffffff;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-2 h1 {\n            margin: 0;\n            font-size: 20px;\n            font-weight: 600;\n            letter-spacing: -1px;\n            line-height: 48px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-3 {\n            max-width: 600px;\n        }\n\n        .table-2 td {\n\n            background-color: #ffffff;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .td-1 {\n            padding: 24px;\n            font-size: 16px;\n            line-height: 24px;\n            background-color: #ffffff;\n            text-align: left;\n            padding-bottom: 10px;\n            padding-top: 0px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-gray {\n            width: 100%;\n        }\n\n        .table-gray tr {\n            height: 24px;\n        }\n\n        .table-gray .td-1 {\n            background-color: #f1f3f7;\n            width: 30%;\n            border: solid 1px #e7e9ec;\n            padding-top: 5px;\n            padding-bottom: 5px;\n            font-size:16px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .table-gray .td-2 {\n            background-color: #f1f3f7;\n            width: 70%;\n            border: solid 1px #e7e9ec;\n            font-size:16px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .button, .button:active, .button:visited {\n            display: inline-block;\n            padding: 16px 36px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 16px;\n            color: #ffffff;\n            text-decoration: none;\n            border-radius: 6px;\n            background-color: #1a82e2;\n            border-radius: 6px;\n        }\n\n        .signature {\n            padding: 24px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 16px;\n            line-height: 24px;\n            border-bottom: 3px solid #d4dadf;\n            background-color: #ffffff;\n        }\n\n        .footer {\n            max-width: 600px;\n        }\n\n        .footer td {\n            padding: 12px 24px;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n            font-size: 14px;\n            line-height: 20px;\n            color: #666;\n        }\n\n        .td-button {\n            padding: 12px;\n            background-color: #ffffff;\n            text-align: center;\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\n        }\n\n        .p-24 {\n            padding: 24px;\n        }\n    </style>\n\n</head>\n\n<body>\n<!-- start body -->\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start hero -->\n<tbody>\n<tr>\n<td align=\"center\">\n<table class=\"table-1\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td align=\"left\">\n<h1>Reminder</h1>\n<h2>({linked_item_type})</h2>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end hero --> <!-- start hero -->\n<tr>\n<td align=\"center\">\n<table class=\"table-2\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td align=\"left\">\n<h1>Hi {first_name},</h1>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end hero --> <!-- start copy block -->\n<tr>\n<td align=\"center\">\n<table class=\"table-3\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start copy -->\n<tbody>\n<tr>\n<td class=\"td-1\">\n<p>The following reminder is now due.</p>\n</td>\n</tr>\n<tr>\n<td class=\"td-1\">\n<table class=\"table-gray\" cellpadding=\"5\">\n<tbody>\n<tr>\n<td class=\"td-1\"><strong>Reminder Title</strong></td>\n<td class=\"td-2\">{reminder_title}</td>\n</tr>\n<tr>\n<td class=\"td-1\"><strong>Reminder Item Title</strong></td>\n<td class=\"td-2\">{linked_item_title}</td>\n</tr>\n<tr>\n<td class=\"td-1\"><strong>Due Date</strong></td>\n<td class=\"td-2\">{reminder_date}&nbsp;{reminder_time}&nbsp;</td>\n</tr>\n</tbody>\n</table>\n<p>&nbsp;</p>\n</td>\n</tr>\n<tr>\n<td align=\"left\" bgcolor=\"#ffffff\">\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td class=\"td-button\">\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td align=\"center\"><a class=\"button\" href=\"{linked_item_url}\" target=\"_blank\" rel=\"noopener\">View Reminder Item</a></td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<tr>\n<td class=\"signature\">\n<p>{email_signature}</p>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end copy block --> <!-- start footer -->\n<tr>\n<td class=\"p-24\" align=\"center\">\n<table class=\"footer\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start permission -->\n<tbody>\n<tr>\n<td align=\"center\">\n<p>{email_footer}</p>\n</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n<!-- end footer --></tbody>\n</table>\n<!-- end body -->\n</body>\n\n</html>', '{first_name}, {last_name}, {reminder_title}, {reminder_date}, {reminder_time}, {reminder_notes}, {linked_item_type}, {linked_item_name}, {linked_item_title}, {linked_item_id}, {linked_item_url}', '2019-12-08 17:13:10', '2022-08-18 15:59:04', 'enabled', 'english', 'yes', 'yes', 150),
(NULL, NULL, 'New Web Form Submitted', 'template_lang_lead_form_submitted', 'team', 'leads', 'New Form Submitted', '<!DOCTYPE html>\r\n<html>\r\n\r\n<head>\r\n\r\n    <meta charset=\"utf-8\">\r\n    <meta http-equiv=\"x-ua-compatible\" content=\"ie=edge\">\r\n    <title>Email Confirmation</title>\r\n    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">\r\n    <style type=\"text/css\">\r\n        @media screen {\r\n            @font-face {\r\n                font-family: \'Source Sans Pro\';\r\n                font-style: normal;\r\n                font-weight: 400;\r\n                src: local(\'Source Sans Pro Regular\'), local(\'SourceSansPro-Regular\'), url(https://fonts.gstatic.com/s/sourcesanspro/v10/ODelI1aHBYDBqgeIAH2zlBM0YzuT7MdOe03otPbuUS0.woff) format(\'woff\');\r\n            }\r\n\r\n            @font-face {\r\n                font-family: \'Source Sans Pro\';\r\n                font-style: normal;\r\n                font-weight: 700;\r\n                src: local(\'Source Sans Pro Bold\'), local(\'SourceSansPro-Bold\'), url(https://fonts.gstatic.com/s/sourcesanspro/v10/toadOcfmlt9b38dHJxOBGFkQc6VGVFSmCnC_l7QZG60.woff) format(\'woff\');\r\n            }\r\n        }\r\n\r\n        body,\r\n        table,\r\n        td,\r\n        a {\r\n            -ms-text-size-adjust: 100%;\r\n            /* 1 */\r\n            -webkit-text-size-adjust: 100%;\r\n            /* 2 */\r\n        }\r\n\r\n        img {\r\n            -ms-interpolation-mode: bicubic;\r\n        }\r\n\r\n        a[x-apple-data-detectors] {\r\n            font-family: inherit !important;\r\n            font-size: inherit !important;\r\n            font-weight: inherit !important;\r\n            line-height: inherit !important;\r\n            color: inherit !important;\r\n            text-decoration: none !important;\r\n        }\r\n\r\n        div[style*=\"margin: 16px 0;\"] {\r\n            margin: 0 !important;\r\n        }\r\n\r\n        body {\r\n            width: 100% !important;\r\n            height: 100% !important;\r\n            padding: 0 !important;\r\n            margin: 0 !important;\r\n            padding: 24px;\r\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\r\n            font-size: 16px;\r\n            background-color: #f9fafc;\r\n            color: #60676d;\r\n        }\r\n\r\n        table {\r\n            border-collapse: collapse !important;\r\n        }\r\n\r\n        a {\r\n            color: #1a82e2;\r\n        }\r\n\r\n        img {\r\n            height: auto;\r\n            line-height: 100%;\r\n            text-decoration: none;\r\n            border: 0;\r\n            outline: none;\r\n        }\r\n\r\n        .table-1 {\r\n            max-width: 600px;\r\n        }\r\n\r\n        .table-1 td {\r\n            padding: 36px 24px 40px;\r\n            text-align: center;\r\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\r\n        }\r\n\r\n        .table-1 h1 {\r\n            margin: 0;\r\n            font-size: 32px;\r\n            font-weight: 600;\r\n            letter-spacing: -1px;\r\n            line-height: 48px;\r\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\r\n        }\r\n\r\n        .table-2 {\r\n            max-width: 600px;\r\n        }\r\n\r\n        .table-2 td {\r\n            padding: 36px 24px 0;\r\n            border-top: 3px solid #d4dadf;\r\n            background-color: #ffffff;\r\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\r\n        }\r\n\r\n        .table-2 h1 {\r\n            margin: 0;\r\n            font-size: 20px;\r\n            font-weight: 600;\r\n            letter-spacing: -1px;\r\n            line-height: 48px;\r\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\r\n        }\r\n\r\n        .table-3 {\r\n            max-width: 600px;\r\n        }\r\n\r\n        .table-2 td {\r\n\r\n            background-color: #ffffff;\r\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\r\n        }\r\n\r\n        .td-1 {\r\n            padding: 24px;\r\n            font-size: 16px;\r\n            line-height: 24px;\r\n            background-color: #ffffff;\r\n            text-align: left;\r\n            padding-bottom: 10px;\r\n            padding-top: 0px;\r\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\r\n        }\r\n\r\n        .table-gray {\r\n            width: 100%;\r\n        }\r\n\r\n        .table-gray tr {\r\n            height: 24px;\r\n        }\r\n\r\n        .table-gray .td-1 {\r\n            background-color: #f1f3f7;\r\n            width: 30%;\r\n            border: solid 1px #e7e9ec;\r\n            padding-top: 5px;\r\n            padding-bottom: 5px;\r\n            font-size:16px;\r\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\r\n        }\r\n\r\n        .table-gray .td-2 {\r\n            background-color: #f1f3f7;\r\n            width: 70%;\r\n            border: solid 1px #e7e9ec;\r\n            font-size:16px;\r\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\r\n        }\r\n\r\n        .button, .button:active, .button:visited {\r\n            display: inline-block;\r\n            padding: 16px 36px;\r\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\r\n            font-size: 16px;\r\n            color: #ffffff;\r\n            text-decoration: none;\r\n            border-radius: 6px;\r\n            background-color: #1a82e2;\r\n            border-radius: 6px;\r\n        }\r\n\r\n        .signature {\r\n            padding: 24px;\r\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\r\n            font-size: 16px;\r\n            line-height: 24px;\r\n            border-bottom: 3px solid #d4dadf;\r\n            background-color: #ffffff;\r\n        }\r\n\r\n        .footer {\r\n            max-width: 600px;\r\n        }\r\n\r\n        .footer td {\r\n            padding: 12px 24px;\r\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\r\n            font-size: 14px;\r\n            line-height: 20px;\r\n            color: #666;\r\n        }\r\n\r\n        .td-button {\r\n            padding: 12px;\r\n            background-color: #ffffff;\r\n            text-align: center;\r\n            font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\r\n        }\r\n\r\n        .p-24 {\r\n            padding: 24px;\r\n        }\r\n    </style>\r\n\r\n</head>\r\n\r\n<body>\r\n<!-- start body -->\r\n<table style=\"height: 744px; width: 100%;\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start hero -->\r\n<tbody>\r\n<tr style=\"height: 75px;\">\r\n<td style=\"height: 75px;\" align=\"center\">\r\n<table class=\"table-1\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\r\n<tbody>\r\n<tr>\r\n<td align=\"left\">\r\n<h1>New Form Submitted</h1>\r\n</td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n</td>\r\n</tr>\r\n<!-- end hero --> <!-- start hero -->\r\n<tr style=\"height: 75px;\">\r\n<td style=\"height: 75px;\" align=\"center\">\r\n<table class=\"table-2\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\r\n<tbody>\r\n<tr>\r\n<td align=\"left\">\r\n<h1>Hi {first_name},</h1>\r\n</td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n</td>\r\n</tr>\r\n<!-- end hero --> <!-- start copy block -->\r\n<tr style=\"height: 519px;\">\r\n<td style=\"height: 519px;\" align=\"center\">\r\n<table class=\"table-3\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start copy -->\r\n<tbody>\r\n<tr>\r\n<td class=\"td-1\">\r\n<p>A new lead form has been submitted.</p>\r\n</td>\r\n</tr>\r\n<tr>\r\n<td class=\"td-1\">\r\n<table class=\"table-gray\" cellpadding=\"5\">\r\n<tbody>\r\n<tr>\r\n<td class=\"td-1\" style=\"width: 204.3px;\"><strong>Form Name</strong></td>\r\n<td class=\"td-2\" style=\"width: 479.7px;\">{form_name}</td>\r\n</tr>\r\n<tr>\r\n<td class=\"td-1\" style=\"width: 204.3px;\"><strong>From Name</strong></td>\r\n<td class=\"td-2\" style=\"width: 479.7px;\">{submitted_by_name}</td>\r\n</tr>\r\n<tr>\r\n<td class=\"td-1\" style=\"width: 204.3px;\"><strong>From Email</strong></td>\r\n<td class=\"td-2\" style=\"width: 479.7px;\">{submitted_by_email}</td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n<p>{form_content}<br /><br />You can manage your lead via the dashboard.</p>\r\n</td>\r\n</tr>\r\n<tr>\r\n<td align=\"left\" bgcolor=\"#ffffff\">\r\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\r\n<tbody>\r\n<tr>\r\n<td class=\"td-button\">\r\n<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\r\n<tbody>\r\n<tr>\r\n<td align=\"center\"><a class=\"button\" href=\"{lead_url}\" target=\"_blank\" rel=\"noopener\">Manage Lead</a></td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n</td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n</td>\r\n</tr>\r\n<tr>\r\n<td class=\"signature\">\r\n<p>{email_signature}</p>\r\n</td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n</td>\r\n</tr>\r\n<!-- end copy block --> <!-- start footer -->\r\n<tr style=\"height: 75px;\">\r\n<td class=\"p-24\" style=\"height: 75px;\" align=\"center\">\r\n<table class=\"footer\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><!-- start permission -->\r\n<tbody>\r\n<tr>\r\n<td align=\"center\">\r\n<p>{email_footer}</p>\r\n</td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n</td>\r\n</tr>\r\n<!-- end footer --></tbody>\r\n</table>\r\n<!-- end body -->\r\n</body>\r\n\r\n</html>', '{first_name}, {form_name}, {submitted_by_name}, {submitted_by_email}, {form_content}, {lead_url}', '2024-01-27 15:08:11', '2024-01-27 15:08:11', 'enabled', 'english', 'yes', 'yes', 155);

-- --------------------------------------------------------

--
-- Table structure for table `estimates`
--

CREATE TABLE `estimates` (
  `bill_estimateid` int(11) NOT NULL,
  `bill_uniqueid` varchar(100) DEFAULT NULL,
  `bill_created` datetime DEFAULT NULL,
  `bill_updated` datetime DEFAULT NULL,
  `bill_date_sent_to_customer` datetime DEFAULT NULL,
  `bill_date_status_change` datetime DEFAULT NULL,
  `bill_clientid` int(11) DEFAULT NULL,
  `bill_projectid` int(11) DEFAULT NULL,
  `bill_proposalid` int(11) DEFAULT NULL,
  `bill_contractid` int(11) DEFAULT NULL,
  `bill_creatorid` int(11) NOT NULL,
  `bill_categoryid` int(11) NOT NULL DEFAULT 4,
  `bill_date` date NOT NULL,
  `bill_expiry_date` date DEFAULT NULL,
  `bill_subtotal` decimal(15,2) NOT NULL DEFAULT 0.00,
  `bill_discount_type` varchar(30) DEFAULT 'none' COMMENT 'amount | percentage | none',
  `bill_discount_percentage` decimal(15,2) DEFAULT 0.00 COMMENT 'actual amount or percentage',
  `bill_discount_amount` decimal(15,2) DEFAULT 0.00,
  `bill_amount_before_tax` decimal(15,2) DEFAULT 0.00,
  `bill_tax_type` varchar(20) DEFAULT 'summary' COMMENT 'summary|inline|none',
  `bill_tax_total_percentage` decimal(15,2) DEFAULT 0.00 COMMENT 'percentage',
  `bill_tax_total_amount` decimal(15,2) DEFAULT 0.00 COMMENT 'amount',
  `bill_adjustment_description` varchar(250) DEFAULT NULL,
  `bill_adjustment_amount` decimal(15,2) DEFAULT 0.00,
  `bill_final_amount` decimal(15,2) DEFAULT 0.00,
  `bill_notes` text DEFAULT NULL,
  `bill_terms` text DEFAULT NULL,
  `bill_status` varchar(50) NOT NULL DEFAULT 'draft' COMMENT 'draft | new | accepted | revised | declined | expired',
  `bill_type` varchar(150) NOT NULL DEFAULT 'estimate' COMMENT 'estimate|invoice',
  `bill_estimate_type` varchar(150) NOT NULL DEFAULT 'estimate' COMMENT 'estimate|document',
  `bill_visibility` varchar(150) NOT NULL DEFAULT 'visible' COMMENT 'visible|hidden (used to prevent estimates that are still being cloned from showing in estimates list)',
  `bill_viewed_by_client` varchar(20) DEFAULT 'no' COMMENT 'yes|no',
  `bill_system` varchar(20) DEFAULT 'no' COMMENT 'yes|no',
  `bill_converted_to_invoice` varchar(20) DEFAULT 'no' COMMENT 'Added as of V1.10',
  `bill_converted_to_invoice_invoiceid` int(11) DEFAULT NULL COMMENT 'Added as of V1.10',
  `estimate_automation_status` varchar(100) DEFAULT 'disabled' COMMENT 'disabled|enabled',
  `estimate_automation_create_project` varchar(50) DEFAULT 'no' COMMENT 'yes|no',
  `estimate_automation_project_title` varchar(250) DEFAULT NULL,
  `estimate_automation_project_status` varchar(100) DEFAULT 'in_progress' COMMENT 'not_started | in_progress | on_hold',
  `estimate_automation_create_tasks` varchar(50) DEFAULT 'no' COMMENT 'yes|no',
  `estimate_automation_project_email_client` varchar(50) DEFAULT 'no' COMMENT 'yes|no',
  `estimate_automation_create_invoice` varchar(50) DEFAULT 'no' COMMENT 'yes|no',
  `estimate_automation_invoice_due_date` int(11) DEFAULT 7,
  `estimate_automation_invoice_email_client` varchar(50) DEFAULT 'no',
  `estimate_automation_copy_attachments` varchar(50) DEFAULT 'no' COMMENT 'yes|no',
  `estimate_automation_log_created_project_id` int(11) DEFAULT NULL,
  `estimate_automation_log_created_invoice_id` int(11) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='[truncate]' ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `estimates`
--

INSERT INTO `estimates` (`bill_estimateid`, `bill_uniqueid`, `bill_created`, `bill_updated`, `bill_date_sent_to_customer`, `bill_date_status_change`, `bill_clientid`, `bill_projectid`, `bill_proposalid`, `bill_contractid`, `bill_creatorid`, `bill_categoryid`, `bill_date`, `bill_expiry_date`, `bill_subtotal`, `bill_discount_type`, `bill_discount_percentage`, `bill_discount_amount`, `bill_amount_before_tax`, `bill_tax_type`, `bill_tax_total_percentage`, `bill_tax_total_amount`, `bill_adjustment_description`, `bill_adjustment_amount`, `bill_final_amount`, `bill_notes`, `bill_terms`, `bill_status`, `bill_type`, `bill_estimate_type`, `bill_visibility`, `bill_viewed_by_client`, `bill_system`, `bill_converted_to_invoice`, `bill_converted_to_invoice_invoiceid`, `estimate_automation_status`, `estimate_automation_create_project`, `estimate_automation_project_title`, `estimate_automation_project_status`, `estimate_automation_create_tasks`, `estimate_automation_project_email_client`, `estimate_automation_create_invoice`, `estimate_automation_invoice_due_date`, `estimate_automation_invoice_email_client`, `estimate_automation_copy_attachments`, `estimate_automation_log_created_project_id`, `estimate_automation_log_created_invoice_id`) VALUES
(-100, '84612794.02318210', '2022-05-22 11:46:15', '2022-05-22 11:46:15', NULL, '2022-05-22 11:46:15', 0, 0, NULL, NULL, 0, 5, '2022-05-22', NULL, 0.00, 'none', 0.00, 0.00, 0.00, 'summary', 0.00, 0.00, NULL, 0.00, 0.00, NULL, '<p>Thank you for your business. We look forward to working with you on this project.</p>', 'draft', 'estimate', 'document', 'visible', 'no', 'yes', 'no', NULL, 'disabled', 'no', NULL, 'in_progress', 'no', 'no', 'no', 7, 'no', 'no', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `events`
--

CREATE TABLE `events` (
  `event_id` int(11) NOT NULL,
  `event_created` datetime DEFAULT NULL COMMENT '[notes] Events record the event, whilst timelines determine where the event is displayed',
  `event_updated` datetime DEFAULT NULL,
  `event_creatorid` int(11) NOT NULL COMMENT 'use ( -1 ) for logged out user.',
  `event_clientid` int(11) DEFAULT NULL COMMENT 'for client type resources',
  `event_creator_name` varchar(150) DEFAULT NULL COMMENT 'for events created by users who are not registered (e.g. accepting a proposal)',
  `event_item` varchar(150) DEFAULT NULL COMMENT 'status | project | task | lead | expense | estimate| comment | attachment | file | invoice | payment | assigned',
  `event_item_id` int(11) DEFAULT NULL COMMENT 'e.g. invoice_id (used in the link shown in the even)',
  `event_item_content` text DEFAULT NULL COMMENT 'e.g. #INV-029200 (used in the text if the event, also in the link text)',
  `event_item_content2` text DEFAULT NULL COMMENT 'extra content',
  `event_item_content3` text DEFAULT NULL COMMENT 'extra content',
  `event_item_content4` text DEFAULT NULL COMMENT 'extra content',
  `event_item_lang` varchar(150) DEFAULT NULL COMMENT '(e.g. - event_created_invoice found in the lang file )',
  `event_item_lang_alt` varchar(150) DEFAULT NULL COMMENT 'Example: Fred posted a comment (as opposed to) You posed a comment',
  `event_parent_type` varchar(150) DEFAULT NULL COMMENT 'used to identify the parent up the tree (e.g. for a task, parent is project) (.e.g. for a task comment, parent is task)',
  `event_parent_id` varchar(150) DEFAULT NULL COMMENT 'id of the parent item (e.g project_id)',
  `event_parent_title` varchar(150) DEFAULT NULL COMMENT 'e.g. task title',
  `event_show_item` varchar(150) DEFAULT 'yes' COMMENT 'yes|no (if the item should be shown in the notifications dopdown)',
  `event_show_in_timeline` varchar(150) DEFAULT 'yes' COMMENT 'yes|no (if this should show the project timeline)',
  `event_notification_category` varchar(150) DEFAULT NULL COMMENT '(e.g. notifications_new_invoice) This determins if a user will get a web notification, an email, both, or none. As per the settings in the [user] table and the login in the [eventTrackingRepo)',
  `eventresource_type` varchar(50) DEFAULT NULL COMMENT '[polymorph] project | ticket | lead (e.g. if you want the event to show in the project timeline, then eventresource_type  must be set to project)',
  `eventresource_id` int(11) DEFAULT NULL COMMENT '[polymorph] e.g project_id'
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='[truncate]' ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `events`
--

INSERT INTO `events` (`event_id`, `event_created`, `event_updated`, `event_creatorid`, `event_clientid`, `event_creator_name`, `event_item`, `event_item_id`, `event_item_content`, `event_item_content2`, `event_item_content3`, `event_item_content4`, `event_item_lang`, `event_item_lang_alt`, `event_parent_type`, `event_parent_id`, `event_parent_title`, `event_show_item`, `event_show_in_timeline`, `event_notification_category`, `eventresource_type`, `eventresource_id`) VALUES
(1, '2024-02-16 22:36:53', '2024-02-16 22:36:53', 1, 0, '', 'status', 0, '5', '', '', '', 'event_changed_lead_status', '', 'lead', '1', 'jjj', 'yes', 'yes', 'notifications_leads_activity', 'lead', 1),
(2, '2024-02-16 22:39:26', '2024-02-16 22:39:26', 1, 0, '', 'status', 0, '3', '', '', '', 'event_changed_lead_status', '', 'lead', '1', 'jjj', 'yes', 'yes', 'notifications_leads_activity', 'lead', 1),
(3, '2024-02-16 22:44:32', '2024-02-16 22:44:32', 1, 0, '', 'status', 0, '1', '', '', '', 'event_changed_lead_status', '', 'lead', '3', 'jjj', 'yes', 'yes', 'notifications_leads_activity', 'lead', 3),
(4, '2024-02-17 18:43:57', '2024-02-17 18:43:57', 1, 0, '', 'assigned', 0, 'Assigned', '1', 'Lamtans', '', 'event_assigned_user_to_a_lead', 'event_assigned_user_to_a_lead_alt', 'lead', '4', 'eco', 'yes', 'no', 'notifications_new_assignement', 'lead', 4),
(5, '2024-02-17 19:22:05', '2024-02-17 19:22:05', 1, 0, '', 'status', 0, '5', '', '', '', 'event_changed_lead_status', '', 'lead', '4', 'eco', 'yes', 'yes', 'notifications_leads_activity', 'lead', 4),
(6, '2024-02-17 19:22:06', '2024-02-17 19:22:06', 1, 0, '', 'status', 0, '1', '', '', '', 'event_changed_lead_status', '', 'lead', '4', 'eco', 'yes', 'yes', 'notifications_leads_activity', 'lead', 4),
(7, '2024-02-17 19:23:39', '2024-02-17 19:23:39', 1, 0, '', 'status', 0, '3', '', '', '', 'event_changed_lead_status', '', 'lead', '5', 'eco', 'yes', 'yes', 'notifications_leads_activity', 'lead', 5),
(8, '2024-02-17 19:23:42', '2024-02-17 19:23:42', 1, 0, '', 'status', 0, '5', '', '', '', 'event_changed_lead_status', '', 'lead', '1', 'jjj', 'yes', 'yes', 'notifications_leads_activity', 'lead', 1),
(9, '2024-02-17 19:23:42', '2024-02-17 19:23:42', 1, 0, '', 'status', 0, '5', '', '', '', 'event_changed_lead_status', '', 'lead', '1', 'jjj', 'yes', 'yes', 'notifications_leads_activity', 'lead', 1),
(10, '2024-02-17 19:23:42', '2024-02-17 19:23:42', 1, 0, '', 'status', 0, '5', '', '', '', 'event_changed_lead_status', '', 'lead', '1', 'jjj', 'yes', 'yes', 'notifications_leads_activity', 'lead', 1),
(11, '2024-02-17 19:23:48', '2024-02-17 19:23:48', 1, 0, '', 'status', 0, '7', '', '', '', 'event_changed_lead_status', '', 'lead', '5', 'eco', 'yes', 'yes', 'notifications_leads_activity', 'lead', 5),
(12, '2024-02-17 19:23:48', '2024-02-17 19:23:48', 1, 0, '', 'status', 0, '7', '', '', '', 'event_changed_lead_status', '', 'lead', '5', 'eco', 'yes', 'yes', 'notifications_leads_activity', 'lead', 5),
(13, '2024-02-17 19:23:49', '2024-02-17 19:23:49', 1, 0, '', 'status', 0, '7', '', '', '', 'event_changed_lead_status', '', 'lead', '1', 'jjj', 'yes', 'yes', 'notifications_leads_activity', 'lead', 1),
(14, '2024-02-17 19:23:51', '2024-02-17 19:23:51', 1, 0, '', 'status', 0, '1', '', '', '', 'event_changed_lead_status', '', 'lead', '1', 'jjj', 'yes', 'yes', 'notifications_leads_activity', 'lead', 1),
(15, '2024-02-17 19:23:51', '2024-02-17 19:23:51', 1, 0, '', 'status', 0, '1', '', '', '', 'event_changed_lead_status', '', 'lead', '1', 'jjj', 'yes', 'yes', 'notifications_leads_activity', 'lead', 1),
(16, '2024-02-17 19:23:51', '2024-02-17 19:23:51', 1, 0, '', 'status', 0, '1', '', '', '', 'event_changed_lead_status', '', 'lead', '1', 'jjj', 'yes', 'yes', 'notifications_leads_activity', 'lead', 1),
(17, '2024-02-17 19:23:55', '2024-02-17 19:23:55', 1, 0, '', 'status', 0, '1', '', '', '', 'event_changed_lead_status', '', 'lead', '5', 'eco', 'yes', 'yes', 'notifications_leads_activity', 'lead', 5),
(18, '2024-02-17 19:23:57', '2024-02-17 19:23:57', 1, 0, '', 'status', 0, '5', '', '', '', 'event_changed_lead_status', '', 'lead', '5', 'eco', 'yes', 'yes', 'notifications_leads_activity', 'lead', 5),
(19, '2024-02-17 19:23:57', '2024-02-17 19:23:57', 1, 0, '', 'status', 0, '5', '', '', '', 'event_changed_lead_status', '', 'lead', '5', 'eco', 'yes', 'yes', 'notifications_leads_activity', 'lead', 5),
(20, '2024-02-17 19:23:57', '2024-02-17 19:23:57', 1, 0, '', 'status', 0, '5', '', '', '', 'event_changed_lead_status', '', 'lead', '5', 'eco', 'yes', 'yes', 'notifications_leads_activity', 'lead', 5),
(21, '2024-02-17 19:23:59', '2024-02-17 19:23:59', 1, 0, '', 'status', 0, '7', '', '', '', 'event_changed_lead_status', '', 'lead', '5', 'eco', 'yes', 'yes', 'notifications_leads_activity', 'lead', 5),
(22, '2024-02-17 19:23:59', '2024-02-17 19:23:59', 1, 0, '', 'status', 0, '7', '', '', '', 'event_changed_lead_status', '', 'lead', '5', 'eco', 'yes', 'yes', 'notifications_leads_activity', 'lead', 5),
(23, '2024-02-17 19:24:10', '2024-02-17 19:24:10', 1, 0, '', 'status', 0, '2', '', '', '', 'event_changed_lead_status', '', 'lead', '5', 'eco', 'yes', 'yes', 'notifications_leads_activity', 'lead', 5),
(24, '2024-02-17 19:24:10', '2024-02-17 19:24:10', 1, 0, '', 'status', 0, '2', '', '', '', 'event_changed_lead_status', '', 'lead', '5', 'eco', 'yes', 'yes', 'notifications_leads_activity', 'lead', 5),
(25, '2024-02-17 19:24:10', '2024-02-17 19:24:10', 1, 0, '', 'status', 0, '2', '', '', '', 'event_changed_lead_status', '', 'lead', '5', 'eco', 'yes', 'yes', 'notifications_leads_activity', 'lead', 5),
(26, '2024-02-17 19:24:12', '2024-02-17 19:24:12', 1, 0, '', 'status', 0, '7', '', '', '', 'event_changed_lead_status', '', 'lead', '5', 'eco', 'yes', 'yes', 'notifications_leads_activity', 'lead', 5),
(27, '2024-02-17 19:24:13', '2024-02-17 19:24:13', 1, 0, '', 'status', 0, '4', '', '', '', 'event_changed_lead_status', '', 'lead', '5', 'eco', 'yes', 'yes', 'notifications_leads_activity', 'lead', 5),
(28, '2024-02-17 19:24:13', '2024-02-17 19:24:13', 1, 0, '', 'status', 0, '4', '', '', '', 'event_changed_lead_status', '', 'lead', '5', 'eco', 'yes', 'yes', 'notifications_leads_activity', 'lead', 5),
(29, '2024-02-17 19:24:13', '2024-02-17 19:24:13', 1, 0, '', 'status', 0, '4', '', '', '', 'event_changed_lead_status', '', 'lead', '5', 'eco', 'yes', 'yes', 'notifications_leads_activity', 'lead', 5),
(30, '2024-02-17 19:24:13', '2024-02-17 19:24:13', 1, 0, '', 'status', 0, '4', '', '', '', 'event_changed_lead_status', '', 'lead', '5', 'eco', 'yes', 'yes', 'notifications_leads_activity', 'lead', 5),
(31, '2024-02-17 19:57:37', '2024-02-17 19:57:37', 1, 0, '', 'status', 0, '5', '', '', '', 'event_changed_lead_status', '', 'lead', '1', 'jjj', 'yes', 'yes', 'notifications_leads_activity', 'lead', 1),
(32, '2024-02-17 19:57:39', '2024-02-17 19:57:39', 1, 0, '', 'status', 0, '3', '', '', '', 'event_changed_lead_status', '', 'lead', '1', 'jjj', 'yes', 'yes', 'notifications_leads_activity', 'lead', 1),
(33, '2024-02-17 19:57:41', '2024-02-17 19:57:41', 1, 0, '', 'status', 0, '7', '', '', '', 'event_changed_lead_status', '', 'lead', '1', 'jjj', 'yes', 'yes', 'notifications_leads_activity', 'lead', 1),
(34, '2024-02-17 19:57:42', '2024-02-17 19:57:42', 1, 0, '', 'status', 0, '1', '', '', '', 'event_changed_lead_status', '', 'lead', '1', 'jjj', 'yes', 'yes', 'notifications_leads_activity', 'lead', 1),
(35, '2024-02-17 19:57:44', '2024-02-17 19:57:44', 1, 0, '', 'status', 0, '4', '', '', '', 'event_changed_lead_status', '', 'lead', '1', 'jjj', 'yes', 'yes', 'notifications_leads_activity', 'lead', 1),
(36, '2024-02-17 19:57:46', '2024-02-17 19:57:46', 1, 0, '', 'status', 0, '5', '', '', '', 'event_changed_lead_status', '', 'lead', '1', 'jjj', 'yes', 'yes', 'notifications_leads_activity', 'lead', 1),
(37, '2024-02-17 19:57:47', '2024-02-17 19:57:47', 1, 0, '', 'status', 0, '1', '', '', '', 'event_changed_lead_status', '', 'lead', '1', 'jjj', 'yes', 'yes', 'notifications_leads_activity', 'lead', 1),
(38, '2024-02-17 19:58:59', '2024-02-17 19:58:59', 1, 0, '', 'status', 0, 'Disqualified', '', '', '', 'event_changed_lead_status', '', 'lead', '1', 'jjj', 'yes', 'yes', 'notifications_leads_activity', 'lead', 1),
(39, '2024-02-17 19:59:17', '2024-02-17 19:59:17', 1, 0, '', 'status', 0, '1', '', '', '', 'event_changed_lead_status', '', 'lead', '1', 'jjj', 'yes', 'yes', 'notifications_leads_activity', 'lead', 1),
(40, '2024-02-17 20:01:48', '2024-02-17 20:01:48', 1, 0, '', 'assigned', 0, 'Assigned', '1', 'Lamtans', '', 'event_assigned_user_to_a_lead', 'event_assigned_user_to_a_lead_alt', 'lead', '1', 'jjj', 'yes', 'no', 'notifications_new_assignement', 'lead', 1),
(41, '2024-02-17 20:01:48', '2024-02-17 20:01:48', 1, 0, '', 'assigned', 0, 'Assigned', '4', 'lamtans01', '', 'event_assigned_user_to_a_lead', 'event_assigned_user_to_a_lead_alt', 'lead', '1', 'jjj', 'yes', 'no', 'notifications_new_assignement', 'lead', 1),
(42, '2024-02-19 21:25:38', '2024-02-19 21:25:38', 1, 0, '', 'assigned', 0, 'Assigned', '4', 'lamtans01', '', 'event_assigned_user_to_a_lead', 'event_assigned_user_to_a_lead_alt', 'lead', '6', 'Testing Lead Title', 'yes', 'no', 'notifications_new_assignement', 'lead', 6),
(43, '2024-02-20 18:55:57', '2024-02-20 18:55:57', 1, 0, '', 'status', 0, 'Voice Mail', '', '', '', 'event_changed_lead_status', '', 'lead', '6', 'Testing Lead Title', 'yes', 'yes', 'notifications_leads_activity', 'lead', 6),
(44, '2024-02-20 18:57:54', '2024-02-20 18:57:54', 1, 0, '', 'status', 0, 'Follow up', '', '', '', 'event_changed_lead_status', '', 'lead', '1', 'jjj', 'yes', 'yes', 'notifications_leads_activity', 'lead', 1),
(45, '2024-02-20 18:57:58', '2024-02-20 18:57:58', 1, 0, '', 'status', 0, 'Awaiting Photos', '', '', '', 'event_changed_lead_status', '', 'lead', '1', 'jjj', 'yes', 'yes', 'notifications_leads_activity', 'lead', 1),
(46, '2024-02-20 18:58:02', '2024-02-20 18:58:02', 1, 0, '', 'status', 0, 'Voice Mail', '', '', '', 'event_changed_lead_status', '', 'lead', '1', 'jjj', 'yes', 'yes', 'notifications_leads_activity', 'lead', 1),
(47, '2024-02-24 17:49:45', '2024-02-24 17:49:45', 1, 0, '', 'assigned', 0, 'Assigned', '4', 'lamtans01', '', 'event_assigned_user_to_a_lead', 'event_assigned_user_to_a_lead_alt', 'lead', '7', 'Lead', 'yes', 'no', 'notifications_new_assignement', 'lead', 7),
(48, '2024-02-24 17:52:19', '2024-02-24 17:52:19', 1, 0, '', 'assigned', 0, 'Assigned', '1', 'Lamtans', '', 'event_assigned_user_to_a_lead', 'event_assigned_user_to_a_lead_alt', 'lead', '8', 'Lead', 'yes', 'no', 'notifications_new_assignement', 'lead', 8);

-- --------------------------------------------------------

--
-- Table structure for table `events_tracking`
--

CREATE TABLE `events_tracking` (
  `eventtracking_id` int(11) NOT NULL,
  `eventtracking_created` datetime NOT NULL,
  `eventtracking_updated` datetime NOT NULL,
  `eventtracking_eventid` int(11) NOT NULL,
  `eventtracking_userid` int(11) NOT NULL,
  `eventtracking_status` varchar(30) DEFAULT 'unread' COMMENT 'read|unread',
  `eventtracking_email` varchar(50) DEFAULT 'no' COMMENT 'yes|no',
  `eventtracking_source` varchar(50) DEFAULT NULL COMMENT 'the actual item (e.g. file | comment | invoice)',
  `eventtracking_source_id` varchar(50) DEFAULT NULL COMMENT 'the id of the actual item',
  `parent_type` varchar(50) DEFAULT NULL COMMENT 'used to locate the main event in the events table. Also used for marking the event as read, once the parent has been viewed. (e.g. for invoice, parent is invoice. For comment task, parent is task)',
  `parent_id` int(11) DEFAULT NULL,
  `resource_type` varchar(50) DEFAULT NULL COMMENT 'Also used for marking events as read, for ancillary items like (project comments, project file) where just viewing a project is enough',
  `resource_id` int(11) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='[truncate]' ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `events_tracking`
--

INSERT INTO `events_tracking` (`eventtracking_id`, `eventtracking_created`, `eventtracking_updated`, `eventtracking_eventid`, `eventtracking_userid`, `eventtracking_status`, `eventtracking_email`, `eventtracking_source`, `eventtracking_source_id`, `parent_type`, `parent_id`, `resource_type`, `resource_id`) VALUES
(1, '2024-02-17 20:01:48', '2024-02-17 20:01:48', 41, 4, 'unread', 'no', 'assigned', '', 'lead', 1, 'lead', 1),
(2, '2024-02-19 21:25:38', '2024-02-19 21:25:38', 42, 4, 'unread', 'no', 'assigned', '', 'lead', 6, 'lead', 6),
(3, '2024-02-20 18:55:57', '2024-02-20 18:55:57', 43, 4, 'unread', 'no', 'status', '', 'lead', 6, 'lead', 6),
(4, '2024-02-20 18:57:54', '2024-02-20 18:57:54', 44, 4, 'unread', 'no', 'status', '', 'lead', 1, 'lead', 1),
(5, '2024-02-20 18:57:58', '2024-02-20 18:57:58', 45, 4, 'unread', 'no', 'status', '', 'lead', 1, 'lead', 1),
(6, '2024-02-20 18:58:02', '2024-02-20 18:58:02', 46, 4, 'unread', 'no', 'status', '', 'lead', 1, 'lead', 1),
(7, '2024-02-24 17:49:45', '2024-02-24 17:49:45', 47, 4, 'unread', 'no', 'assigned', '', 'lead', 7, 'lead', 7);

-- --------------------------------------------------------

--
-- Table structure for table `expenses`
--

CREATE TABLE `expenses` (
  `expense_id` int(11) NOT NULL,
  `expense_importid` varchar(100) DEFAULT NULL,
  `expense_created` date DEFAULT NULL,
  `expense_updated` date DEFAULT NULL,
  `expense_date` date DEFAULT NULL,
  `expense_clientid` int(11) DEFAULT NULL,
  `expense_projectid` int(11) DEFAULT NULL,
  `expense_creatorid` int(11) NOT NULL,
  `expense_categoryid` int(11) NOT NULL DEFAULT 7,
  `expense_amount` decimal(10,2) NOT NULL,
  `expense_description` text DEFAULT NULL,
  `expense_type` text DEFAULT NULL COMMENT 'business|client',
  `expense_billable` varchar(30) DEFAULT 'not_billable' COMMENT 'billable | not_billable',
  `expense_billing_status` varchar(30) DEFAULT 'not_invoiced' COMMENT 'invoiced | not_invoiced',
  `expense_billable_invoiceid` int(11) DEFAULT NULL COMMENT 'id of the invoice that it has been billed to'
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='[truncate]' ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `connection` text NOT NULL,
  `queue` text NOT NULL,
  `payload` longtext NOT NULL,
  `exception` longtext NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='[truncate]' ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `files`
--

CREATE TABLE `files` (
  `file_id` int(11) NOT NULL,
  `file_uniqueid` varchar(100) DEFAULT NULL,
  `file_upload_unique_key` varchar(100) DEFAULT NULL COMMENT 'used to idetify files that were uploaded in one go',
  `file_created` datetime DEFAULT NULL,
  `file_updated` datetime DEFAULT NULL,
  `file_creatorid` int(11) DEFAULT NULL,
  `file_clientid` int(11) DEFAULT NULL COMMENT 'optional',
  `file_folderid` int(11) DEFAULT NULL,
  `file_filename` varchar(250) DEFAULT NULL,
  `file_directory` varchar(100) DEFAULT NULL,
  `file_extension` varchar(10) DEFAULT NULL,
  `file_size` varchar(40) DEFAULT NULL COMMENT 'human readable file size',
  `file_type` varchar(20) DEFAULT NULL COMMENT 'image|file',
  `file_thumbname` varchar(250) DEFAULT NULL COMMENT 'optional',
  `file_visibility_client` varchar(5) DEFAULT 'yes' COMMENT 'yes | no',
  `fileresource_type` varchar(50) DEFAULT NULL COMMENT '[polymorph] project',
  `fileresource_id` int(11) DEFAULT NULL COMMENT '[polymorph] e.g project_id'
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='[truncate]' ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `file_folders`
--

CREATE TABLE `file_folders` (
  `filefolder_id` int(11) NOT NULL,
  `filefolder_created` datetime NOT NULL,
  `filefolder_updated` datetime NOT NULL,
  `filefolder_creatorid` int(11) DEFAULT NULL,
  `filefolder_projectid` int(11) DEFAULT NULL,
  `filefolder_name` varchar(250) DEFAULT NULL,
  `filefolder_default` varchar(100) DEFAULT 'no' COMMENT 'yes|no',
  `filefolder_system` varchar(100) DEFAULT 'no' COMMENT 'yes|no'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `file_folders`
--

INSERT INTO `file_folders` (`filefolder_id`, `filefolder_created`, `filefolder_updated`, `filefolder_creatorid`, `filefolder_projectid`, `filefolder_name`, `filefolder_default`, `filefolder_system`) VALUES
(1, '2024-01-30 15:58:58', '2024-01-30 15:58:58', 0, NULL, 'Default', 'yes', 'yes');

-- --------------------------------------------------------

--
-- Table structure for table `invoices`
--

CREATE TABLE `invoices` (
  `bill_invoiceid` int(11) NOT NULL,
  `bill_uniqueid` varchar(100) DEFAULT NULL,
  `bill_created` datetime DEFAULT NULL,
  `bill_updated` datetime DEFAULT NULL,
  `bill_date_sent_to_customer` date DEFAULT NULL COMMENT 'the date an invoice was published or lasts emailed to the customer',
  `bill_date_status_change` datetime DEFAULT NULL,
  `bill_clientid` int(11) NOT NULL,
  `bill_projectid` int(11) DEFAULT NULL COMMENT 'optional',
  `bill_subscriptionid` int(11) DEFAULT NULL COMMENT 'optional',
  `bill_creatorid` int(11) NOT NULL,
  `bill_categoryid` int(11) NOT NULL DEFAULT 4,
  `bill_date` date NOT NULL,
  `bill_due_date` date DEFAULT NULL,
  `bill_subtotal` decimal(15,2) NOT NULL DEFAULT 0.00,
  `bill_discount_type` varchar(30) DEFAULT 'none' COMMENT 'amount | percentage | none',
  `bill_discount_percentage` decimal(15,2) DEFAULT 0.00 COMMENT 'actual amount or percentage',
  `bill_discount_amount` decimal(15,2) DEFAULT 0.00,
  `bill_amount_before_tax` decimal(15,2) DEFAULT 0.00,
  `bill_tax_type` varchar(20) DEFAULT 'summary' COMMENT 'summary|inline|none',
  `bill_tax_total_percentage` decimal(15,2) DEFAULT 0.00 COMMENT 'percentage',
  `bill_tax_total_amount` decimal(15,2) DEFAULT 0.00 COMMENT 'amount',
  `bill_adjustment_description` varchar(250) DEFAULT NULL,
  `bill_adjustment_amount` decimal(15,2) DEFAULT 0.00,
  `bill_final_amount` decimal(15,2) DEFAULT 0.00,
  `bill_notes` text DEFAULT NULL,
  `bill_terms` text DEFAULT NULL,
  `bill_status` varchar(50) NOT NULL DEFAULT 'draft' COMMENT 'draft | due | overdue | paid | part_paid',
  `bill_recurring` varchar(50) DEFAULT 'no' COMMENT 'yes|no',
  `bill_recurring_duration` int(11) DEFAULT NULL COMMENT 'e.g. 20 (for 20 days)',
  `bill_recurring_period` varchar(30) DEFAULT NULL COMMENT 'day | week | month | year',
  `bill_recurring_cycles` int(11) DEFAULT NULL COMMENT '0 for infinity',
  `bill_recurring_cycles_counter` int(11) DEFAULT NULL COMMENT 'number of times it has been renewed',
  `bill_recurring_last` date DEFAULT NULL COMMENT 'date when it was last renewed',
  `bill_recurring_next` date DEFAULT NULL COMMENT 'date when it will next be renewed',
  `bill_recurring_child` varchar(5) DEFAULT 'no' COMMENT 'yes|no',
  `bill_recurring_parent_id` int(11) DEFAULT NULL COMMENT 'if it was generated from a recurring invoice, the id of parent invoice',
  `bill_overdue_reminder_sent` varchar(5) DEFAULT 'no' COMMENT 'yes | no',
  `bill_invoice_type` varchar(30) DEFAULT 'onetime' COMMENT 'onetime | subscription',
  `bill_type` varchar(20) DEFAULT 'invoice' COMMENT 'invoice|estimate',
  `bill_visibility` varchar(20) DEFAULT 'visible' COMMENT 'visible|hidden (used to prevent invoices that are still being cloned from showing in invoices list)',
  `bill_cron_status` varchar(20) DEFAULT 'none' COMMENT 'none|processing|completed|error  (used to prevent collisions when recurring invoiced)',
  `bill_cron_date` datetime DEFAULT NULL COMMENT 'date when cron was run',
  `bill_viewed_by_client` varchar(20) DEFAULT 'no' COMMENT 'yes|no',
  `bill_system` varchar(20) DEFAULT 'no' COMMENT 'yes|no'
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='[truncate]' ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `items`
--

CREATE TABLE `items` (
  `item_id` int(11) NOT NULL,
  `item_created` datetime DEFAULT NULL,
  `item_updated` datetime DEFAULT NULL,
  `item_categoryid` int(11) NOT NULL DEFAULT 8,
  `item_creatorid` int(11) NOT NULL,
  `item_type` varchar(100) NOT NULL DEFAULT 'standard' COMMENT 'standard|dimensions',
  `item_description` text DEFAULT NULL,
  `item_unit` varchar(50) DEFAULT NULL,
  `item_rate` decimal(15,2) NOT NULL,
  `item_tax_status` varchar(100) NOT NULL DEFAULT 'taxable' COMMENT 'taxable|exempt',
  `item_dimensions_length` decimal(15,2) DEFAULT NULL,
  `item_dimensions_width` decimal(15,2) DEFAULT NULL,
  `item_notes_estimatation` text DEFAULT NULL,
  `item_notes_production` text DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='[truncate]' ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `jobs`
--

CREATE TABLE `jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `queue` varchar(255) NOT NULL,
  `payload` longtext NOT NULL,
  `attempts` tinyint(3) UNSIGNED NOT NULL,
  `reserved_at` int(10) UNSIGNED DEFAULT NULL,
  `available_at` int(10) UNSIGNED NOT NULL,
  `created_at` int(10) UNSIGNED NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='[truncate]' ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `kb_categories`
--

CREATE TABLE `kb_categories` (
  `kbcategory_id` int(11) NOT NULL,
  `kbcategory_created` datetime NOT NULL,
  `kbcategory_updated` datetime NOT NULL,
  `kbcategory_creatorid` int(11) NOT NULL,
  `kbcategory_title` varchar(250) NOT NULL,
  `kbcategory_description` text DEFAULT NULL,
  `kbcategory_position` int(11) DEFAULT NULL,
  `kbcategory_visibility` varchar(50) DEFAULT 'everyone' COMMENT 'everyone | team | client',
  `kbcategory_slug` varchar(250) DEFAULT NULL,
  `kbcategory_icon` varchar(250) DEFAULT NULL,
  `kbcategory_type` varchar(50) DEFAULT 'text' COMMENT 'text|video',
  `kbcategory_system_default` varchar(250) DEFAULT 'no' COMMENT 'yes | no'
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='[truncate]' ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `kb_categories`
--

INSERT INTO `kb_categories` (`kbcategory_id`, `kbcategory_created`, `kbcategory_updated`, `kbcategory_creatorid`, `kbcategory_title`, `kbcategory_description`, `kbcategory_position`, `kbcategory_visibility`, `kbcategory_slug`, `kbcategory_icon`, `kbcategory_type`, `kbcategory_system_default`) VALUES
(1, '2024-02-15 21:57:55', '2024-02-15 21:57:55', 0, 'Frequently Asked Questions', 'Answers to some of the most frequently asked questions', 1, 'everyone', '1-frequently-asked-questions', 'sl-icon-call-out', 'text', 'yes');

-- --------------------------------------------------------

--
-- Table structure for table `knowledgebase`
--

CREATE TABLE `knowledgebase` (
  `knowledgebase_id` int(11) NOT NULL,
  `knowledgebase_created` datetime NOT NULL,
  `knowledgebase_updated` datetime NOT NULL,
  `knowledgebase_creatorid` int(11) NOT NULL,
  `knowledgebase_categoryid` int(11) NOT NULL,
  `knowledgebase_title` varchar(250) NOT NULL,
  `knowledgebase_slug` varchar(250) DEFAULT NULL,
  `knowledgebase_text` text DEFAULT NULL,
  `knowledgebase_embed_video_id` varchar(50) DEFAULT NULL,
  `knowledgebase_embed_code` text DEFAULT NULL,
  `knowledgebase_embed_thumb` varchar(150) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='[truncate]' ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `leads`
--

CREATE TABLE `leads` (
  `lead_id` int(11) NOT NULL,
  `lead_importid` varchar(100) DEFAULT NULL,
  `lead_position` double NOT NULL,
  `lead_created` datetime DEFAULT NULL,
  `lead_updated` datetime DEFAULT NULL,
  `lead_date_status_change` datetime DEFAULT NULL,
  `lead_creatorid` int(11) DEFAULT NULL,
  `lead_updatorid` int(11) DEFAULT NULL,
  `lead_categoryid` int(11) DEFAULT 3,
  `lead_firstname` varchar(100) DEFAULT NULL,
  `lead_lastname` varchar(100) DEFAULT NULL,
  `lead_email` varchar(150) DEFAULT NULL,
  `lead_phone` varchar(150) DEFAULT NULL,
  `lead_job_position` varchar(150) DEFAULT NULL,
  `lead_company_name` varchar(150) DEFAULT NULL,
  `lead_website` varchar(150) DEFAULT NULL,
  `lead_street` varchar(150) DEFAULT NULL,
  `lead_city` varchar(150) DEFAULT NULL,
  `lead_state` varchar(150) DEFAULT NULL,
  `lead_zip` varchar(150) DEFAULT NULL,
  `lead_country` varchar(150) DEFAULT NULL,
  `lead_source` varchar(150) DEFAULT NULL,
  `lead_title` varchar(250) DEFAULT NULL,
  `lead_description` text DEFAULT NULL,
  `lead_value` decimal(10,2) DEFAULT NULL,
  `lead_last_contacted` date DEFAULT NULL,
  `lead_converted` varchar(10) DEFAULT 'no' COMMENT 'yes|no',
  `lead_converted_by_userid` int(11) DEFAULT NULL COMMENT 'id of user who converted',
  `lead_converted_date` datetime DEFAULT NULL COMMENT 'date lead converted',
  `lead_converted_clientid` int(11) DEFAULT NULL COMMENT 'if the lead has previously been converted to a client',
  `lead_status` tinyint(4) DEFAULT 1 COMMENT 'Deafult is id: 1 (leads_status) table',
  `lead_active_state` varchar(10) DEFAULT 'active' COMMENT 'active|archived',
  `lead_visibility` varchar(40) DEFAULT 'visible' COMMENT 'visible|hidden (used to prevent tasks that are still being cloned from showing in tasks list)',
  `lead_custom_field_1` tinytext DEFAULT NULL,
  `lead_custom_field_2` tinytext DEFAULT NULL,
  `lead_custom_field_3` tinytext DEFAULT NULL,
  `lead_custom_field_4` tinytext DEFAULT NULL,
  `lead_custom_field_5` tinytext DEFAULT NULL,
  `lead_custom_field_6` tinytext DEFAULT NULL,
  `lead_custom_field_7` tinytext DEFAULT NULL,
  `lead_custom_field_8` tinytext DEFAULT NULL,
  `lead_custom_field_9` tinytext DEFAULT NULL,
  `lead_custom_field_10` tinytext DEFAULT NULL,
  `lead_custom_field_11` tinytext DEFAULT NULL,
  `lead_custom_field_12` tinytext DEFAULT NULL,
  `lead_custom_field_13` tinytext DEFAULT NULL,
  `lead_custom_field_14` tinytext DEFAULT NULL,
  `lead_custom_field_15` tinytext DEFAULT NULL,
  `lead_custom_field_16` tinytext DEFAULT NULL,
  `lead_custom_field_17` tinytext DEFAULT NULL,
  `lead_custom_field_18` tinytext DEFAULT NULL,
  `lead_custom_field_19` tinytext DEFAULT NULL,
  `lead_custom_field_20` tinytext DEFAULT NULL,
  `lead_custom_field_21` tinytext DEFAULT NULL,
  `lead_custom_field_22` tinytext DEFAULT NULL,
  `lead_custom_field_23` tinytext DEFAULT NULL,
  `lead_custom_field_24` tinytext DEFAULT NULL,
  `lead_custom_field_25` tinytext DEFAULT NULL,
  `lead_custom_field_26` tinytext DEFAULT NULL,
  `lead_custom_field_27` tinytext DEFAULT NULL,
  `lead_custom_field_28` tinytext DEFAULT NULL,
  `lead_custom_field_29` tinytext DEFAULT NULL,
  `lead_custom_field_30` tinytext DEFAULT NULL,
  `lead_custom_field_31` datetime DEFAULT NULL,
  `lead_custom_field_32` datetime DEFAULT NULL,
  `lead_custom_field_33` datetime DEFAULT NULL,
  `lead_custom_field_34` datetime DEFAULT NULL,
  `lead_custom_field_35` datetime DEFAULT NULL,
  `lead_custom_field_36` datetime DEFAULT NULL,
  `lead_custom_field_37` datetime DEFAULT NULL,
  `lead_custom_field_38` datetime DEFAULT NULL,
  `lead_custom_field_39` datetime DEFAULT NULL,
  `lead_custom_field_40` datetime DEFAULT NULL,
  `lead_custom_field_41` text DEFAULT NULL,
  `lead_custom_field_42` text DEFAULT NULL,
  `lead_custom_field_43` text DEFAULT NULL,
  `lead_custom_field_44` text DEFAULT NULL,
  `lead_custom_field_45` text DEFAULT NULL,
  `lead_custom_field_46` text DEFAULT NULL,
  `lead_custom_field_47` text DEFAULT NULL,
  `lead_custom_field_48` text DEFAULT NULL,
  `lead_custom_field_49` text DEFAULT NULL,
  `lead_custom_field_50` text DEFAULT NULL,
  `lead_custom_field_51` text DEFAULT NULL,
  `lead_custom_field_52` text DEFAULT NULL,
  `lead_custom_field_53` text DEFAULT NULL,
  `lead_custom_field_54` text DEFAULT NULL,
  `lead_custom_field_55` text DEFAULT NULL,
  `lead_custom_field_56` text DEFAULT NULL,
  `lead_custom_field_57` text DEFAULT NULL,
  `lead_custom_field_58` text DEFAULT NULL,
  `lead_custom_field_59` text DEFAULT NULL,
  `lead_custom_field_60` text DEFAULT NULL,
  `lead_custom_field_61` varchar(20) DEFAULT NULL,
  `lead_custom_field_62` varchar(20) DEFAULT NULL,
  `lead_custom_field_63` varchar(20) DEFAULT NULL,
  `lead_custom_field_64` varchar(20) DEFAULT NULL,
  `lead_custom_field_65` varchar(20) DEFAULT NULL,
  `lead_custom_field_66` varchar(20) DEFAULT NULL,
  `lead_custom_field_67` varchar(20) DEFAULT NULL,
  `lead_custom_field_68` varchar(20) DEFAULT NULL,
  `lead_custom_field_69` varchar(20) DEFAULT NULL,
  `lead_custom_field_70` varchar(20) DEFAULT NULL,
  `lead_custom_field_71` varchar(20) DEFAULT NULL,
  `lead_custom_field_72` varchar(20) DEFAULT NULL,
  `lead_custom_field_73` varchar(20) DEFAULT NULL,
  `lead_custom_field_74` varchar(20) DEFAULT NULL,
  `lead_custom_field_75` varchar(20) DEFAULT NULL,
  `lead_custom_field_76` varchar(20) DEFAULT NULL,
  `lead_custom_field_77` varchar(20) DEFAULT NULL,
  `lead_custom_field_78` varchar(20) DEFAULT NULL,
  `lead_custom_field_79` varchar(20) DEFAULT NULL,
  `lead_custom_field_80` varchar(20) DEFAULT NULL,
  `lead_custom_field_81` varchar(150) DEFAULT NULL,
  `lead_custom_field_82` varchar(150) DEFAULT NULL,
  `lead_custom_field_83` varchar(150) DEFAULT NULL,
  `lead_custom_field_84` varchar(150) DEFAULT NULL,
  `lead_custom_field_85` varchar(150) DEFAULT NULL,
  `lead_custom_field_86` varchar(150) DEFAULT NULL,
  `lead_custom_field_87` varchar(150) DEFAULT NULL,
  `lead_custom_field_88` varchar(150) DEFAULT NULL,
  `lead_custom_field_89` varchar(150) DEFAULT NULL,
  `lead_custom_field_90` varchar(150) DEFAULT NULL,
  `lead_custom_field_91` varchar(150) DEFAULT NULL,
  `lead_custom_field_92` varchar(150) DEFAULT NULL,
  `lead_custom_field_93` varchar(150) DEFAULT NULL,
  `lead_custom_field_94` varchar(150) DEFAULT NULL,
  `lead_custom_field_95` varchar(150) DEFAULT NULL,
  `lead_custom_field_96` varchar(150) DEFAULT NULL,
  `lead_custom_field_97` varchar(150) DEFAULT NULL,
  `lead_custom_field_98` varchar(150) DEFAULT NULL,
  `lead_custom_field_99` varchar(150) DEFAULT NULL,
  `lead_custom_field_100` varchar(150) DEFAULT NULL,
  `lead_custom_field_101` varchar(150) DEFAULT NULL,
  `lead_custom_field_102` varchar(150) DEFAULT NULL,
  `lead_custom_field_103` varchar(150) DEFAULT NULL,
  `lead_custom_field_104` varchar(150) DEFAULT NULL,
  `lead_custom_field_105` varchar(150) DEFAULT NULL,
  `lead_custom_field_106` varchar(150) DEFAULT NULL,
  `lead_custom_field_107` varchar(150) DEFAULT NULL,
  `lead_custom_field_108` varchar(150) DEFAULT NULL,
  `lead_custom_field_109` varchar(150) DEFAULT NULL,
  `lead_custom_field_110` varchar(150) DEFAULT NULL,
  `lead_custom_field_111` int(11) DEFAULT NULL,
  `lead_custom_field_112` int(11) DEFAULT NULL,
  `lead_custom_field_113` int(11) DEFAULT NULL,
  `lead_custom_field_114` int(11) DEFAULT NULL,
  `lead_custom_field_115` int(11) DEFAULT NULL,
  `lead_custom_field_116` int(11) DEFAULT NULL,
  `lead_custom_field_117` int(11) DEFAULT NULL,
  `lead_custom_field_118` int(11) DEFAULT NULL,
  `lead_custom_field_119` int(11) DEFAULT NULL,
  `lead_custom_field_120` int(11) DEFAULT NULL,
  `lead_custom_field_121` int(11) DEFAULT NULL,
  `lead_custom_field_122` int(11) DEFAULT NULL,
  `lead_custom_field_123` int(11) DEFAULT NULL,
  `lead_custom_field_124` int(11) DEFAULT NULL,
  `lead_custom_field_125` int(11) DEFAULT NULL,
  `lead_custom_field_126` int(11) DEFAULT NULL,
  `lead_custom_field_127` int(11) DEFAULT NULL,
  `lead_custom_field_128` int(11) DEFAULT NULL,
  `lead_custom_field_129` int(11) DEFAULT NULL,
  `lead_custom_field_130` int(11) DEFAULT NULL,
  `lead_custom_field_131` decimal(10,2) DEFAULT NULL,
  `lead_custom_field_132` decimal(10,2) DEFAULT NULL,
  `lead_custom_field_133` decimal(10,2) DEFAULT NULL,
  `lead_custom_field_134` decimal(10,2) DEFAULT NULL,
  `lead_custom_field_135` decimal(10,2) DEFAULT NULL,
  `lead_custom_field_136` decimal(10,2) DEFAULT NULL,
  `lead_custom_field_137` decimal(10,2) DEFAULT NULL,
  `lead_custom_field_138` decimal(10,2) DEFAULT NULL,
  `lead_custom_field_139` decimal(10,2) DEFAULT NULL,
  `lead_custom_field_140` decimal(10,2) DEFAULT NULL,
  `lead_custom_field_141` decimal(10,2) DEFAULT NULL,
  `lead_custom_field_142` decimal(10,2) DEFAULT NULL,
  `lead_custom_field_143` decimal(10,2) DEFAULT NULL,
  `lead_custom_field_144` decimal(10,2) DEFAULT NULL,
  `lead_custom_field_145` decimal(10,2) DEFAULT NULL,
  `lead_custom_field_146` decimal(10,2) DEFAULT NULL,
  `lead_custom_field_147` decimal(10,2) DEFAULT NULL,
  `lead_custom_field_148` decimal(10,2) DEFAULT NULL,
  `lead_custom_field_149` decimal(10,2) DEFAULT NULL,
  `lead_custom_field_150` decimal(10,2) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='[truncate]' ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `leads`
--

INSERT INTO `leads` (`lead_id`, `lead_importid`, `lead_position`, `lead_created`, `lead_updated`, `lead_date_status_change`, `lead_creatorid`, `lead_updatorid`, `lead_categoryid`, `lead_firstname`, `lead_lastname`, `lead_email`, `lead_phone`, `lead_job_position`, `lead_company_name`, `lead_website`, `lead_street`, `lead_city`, `lead_state`, `lead_zip`, `lead_country`, `lead_source`, `lead_title`, `lead_description`, `lead_value`, `lead_last_contacted`, `lead_converted`, `lead_converted_by_userid`, `lead_converted_date`, `lead_converted_clientid`, `lead_status`, `lead_active_state`, `lead_visibility`, `lead_custom_field_1`, `lead_custom_field_2`, `lead_custom_field_3`, `lead_custom_field_4`, `lead_custom_field_5`, `lead_custom_field_6`, `lead_custom_field_7`, `lead_custom_field_8`, `lead_custom_field_9`, `lead_custom_field_10`, `lead_custom_field_11`, `lead_custom_field_12`, `lead_custom_field_13`, `lead_custom_field_14`, `lead_custom_field_15`, `lead_custom_field_16`, `lead_custom_field_17`, `lead_custom_field_18`, `lead_custom_field_19`, `lead_custom_field_20`, `lead_custom_field_21`, `lead_custom_field_22`, `lead_custom_field_23`, `lead_custom_field_24`, `lead_custom_field_25`, `lead_custom_field_26`, `lead_custom_field_27`, `lead_custom_field_28`, `lead_custom_field_29`, `lead_custom_field_30`, `lead_custom_field_31`, `lead_custom_field_32`, `lead_custom_field_33`, `lead_custom_field_34`, `lead_custom_field_35`, `lead_custom_field_36`, `lead_custom_field_37`, `lead_custom_field_38`, `lead_custom_field_39`, `lead_custom_field_40`, `lead_custom_field_41`, `lead_custom_field_42`, `lead_custom_field_43`, `lead_custom_field_44`, `lead_custom_field_45`, `lead_custom_field_46`, `lead_custom_field_47`, `lead_custom_field_48`, `lead_custom_field_49`, `lead_custom_field_50`, `lead_custom_field_51`, `lead_custom_field_52`, `lead_custom_field_53`, `lead_custom_field_54`, `lead_custom_field_55`, `lead_custom_field_56`, `lead_custom_field_57`, `lead_custom_field_58`, `lead_custom_field_59`, `lead_custom_field_60`, `lead_custom_field_61`, `lead_custom_field_62`, `lead_custom_field_63`, `lead_custom_field_64`, `lead_custom_field_65`, `lead_custom_field_66`, `lead_custom_field_67`, `lead_custom_field_68`, `lead_custom_field_69`, `lead_custom_field_70`, `lead_custom_field_71`, `lead_custom_field_72`, `lead_custom_field_73`, `lead_custom_field_74`, `lead_custom_field_75`, `lead_custom_field_76`, `lead_custom_field_77`, `lead_custom_field_78`, `lead_custom_field_79`, `lead_custom_field_80`, `lead_custom_field_81`, `lead_custom_field_82`, `lead_custom_field_83`, `lead_custom_field_84`, `lead_custom_field_85`, `lead_custom_field_86`, `lead_custom_field_87`, `lead_custom_field_88`, `lead_custom_field_89`, `lead_custom_field_90`, `lead_custom_field_91`, `lead_custom_field_92`, `lead_custom_field_93`, `lead_custom_field_94`, `lead_custom_field_95`, `lead_custom_field_96`, `lead_custom_field_97`, `lead_custom_field_98`, `lead_custom_field_99`, `lead_custom_field_100`, `lead_custom_field_101`, `lead_custom_field_102`, `lead_custom_field_103`, `lead_custom_field_104`, `lead_custom_field_105`, `lead_custom_field_106`, `lead_custom_field_107`, `lead_custom_field_108`, `lead_custom_field_109`, `lead_custom_field_110`, `lead_custom_field_111`, `lead_custom_field_112`, `lead_custom_field_113`, `lead_custom_field_114`, `lead_custom_field_115`, `lead_custom_field_116`, `lead_custom_field_117`, `lead_custom_field_118`, `lead_custom_field_119`, `lead_custom_field_120`, `lead_custom_field_121`, `lead_custom_field_122`, `lead_custom_field_123`, `lead_custom_field_124`, `lead_custom_field_125`, `lead_custom_field_126`, `lead_custom_field_127`, `lead_custom_field_128`, `lead_custom_field_129`, `lead_custom_field_130`, `lead_custom_field_131`, `lead_custom_field_132`, `lead_custom_field_133`, `lead_custom_field_134`, `lead_custom_field_135`, `lead_custom_field_136`, `lead_custom_field_137`, `lead_custom_field_138`, `lead_custom_field_139`, `lead_custom_field_140`, `lead_custom_field_141`, `lead_custom_field_142`, `lead_custom_field_143`, `lead_custom_field_144`, `lead_custom_field_145`, `lead_custom_field_146`, `lead_custom_field_147`, `lead_custom_field_148`, `lead_custom_field_149`, `lead_custom_field_150`) VALUES
(1, NULL, 40960, '2024-02-16 22:36:15', '2024-02-20 18:58:02', NULL, 1, NULL, 3, 'ddd', 'fdsds', 'test@test12.com', '7872309108', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Pakistan', NULL, 'jjj', 'ssa', NULL, '2024-02-26', 'no', NULL, NULL, NULL, 5, 'active', 'visible', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(2, NULL, 16384, '2024-02-16 22:36:27', '2024-02-17 18:45:26', NULL, 1, NULL, 3, 'ddd', 'fdsds', 'test@test12.com', '7872309108', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Pakistan', NULL, 'jjj', NULL, NULL, NULL, 'no', NULL, NULL, NULL, 1, 'archived', 'visible', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(3, NULL, 8192, '2024-02-16 22:39:22', '2024-02-16 23:49:49', NULL, 1, NULL, 3, 'ddd', 'fdsds', 'test@test12.com', '7872309108', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Pakistan', NULL, 'jjj', NULL, NULL, NULL, 'yes', 1, '2024-02-16 23:49:49', 2, 2, 'active', 'visible', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(4, NULL, 65536, '2024-02-17 18:43:57', '2024-02-17 19:23:00', NULL, 1, NULL, 3, 'aa', 'kk', 'bhjbgh@gmail.com', '2063022560.2', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'eco', NULL, 2.00, NULL, 'no', NULL, NULL, NULL, 1, 'archived', 'visible', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(5, NULL, 24576, '2024-02-17 19:22:51', '2024-02-17 19:24:13', NULL, 1, NULL, 3, 'aa', 'okl,', NULL, '.3632', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'eco', NULL, NULL, NULL, 'no', NULL, NULL, NULL, 4, 'active', 'visible', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(6, NULL, 57344, '2024-02-19 21:25:38', '2024-02-24 17:52:29', NULL, 1, NULL, 3, 'Testing FN', 'Testing LN', 'Testing@email.com', '07412013254', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Testing Lead Title', 'Testing Details', 1.00, '2024-02-20', 'no', NULL, NULL, NULL, 5, 'active', 'visible', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(7, NULL, 98304, '2024-02-24 17:49:45', '2024-02-24 17:49:45', NULL, 1, NULL, 3, 'test', 'test', '123234@gmail.com', '000000000', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Australia', NULL, 'Lead', NULL, 213.00, NULL, 'no', NULL, NULL, NULL, 2, 'active', 'visible', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(8, NULL, 114688, '2024-02-24 17:52:19', '2024-02-24 17:52:19', NULL, 1, NULL, 3, 'Test Checklisy', 'SMITH', 'taha1823944@gmail.com', '000000000', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Australia', NULL, 'Lead', NULL, 1.00, NULL, 'no', NULL, NULL, NULL, 1, 'active', 'visible', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `leads_assigned`
--

CREATE TABLE `leads_assigned` (
  `leadsassigned_id` int(11) NOT NULL,
  `leadsassigned_leadid` int(11) DEFAULT NULL,
  `leadsassigned_userid` int(11) DEFAULT NULL,
  `leadsassigned_created` datetime NOT NULL,
  `leadsassigned_updated` datetime NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='[truncate]' ROW_FORMAT=FIXED;

--
-- Dumping data for table `leads_assigned`
--

INSERT INTO `leads_assigned` (`leadsassigned_id`, `leadsassigned_leadid`, `leadsassigned_userid`, `leadsassigned_created`, `leadsassigned_updated`) VALUES
(1, 4, 1, '2024-02-17 18:43:57', '2024-02-17 18:43:57'),
(5, 1, 4, '2024-02-17 20:05:05', '2024-02-17 20:05:05'),
(4, 1, 1, '2024-02-17 20:05:05', '2024-02-17 20:05:05'),
(6, 6, 4, '2024-02-19 21:25:38', '2024-02-19 21:25:38'),
(7, 7, 4, '2024-02-24 17:49:45', '2024-02-24 17:49:45'),
(8, 8, 1, '2024-02-24 17:52:19', '2024-02-24 17:52:19');

-- --------------------------------------------------------

--
-- Table structure for table `leads_sources`
--

CREATE TABLE `leads_sources` (
  `leadsources_id` int(11) NOT NULL,
  `leadsources_created` datetime NOT NULL,
  `leadsources_updated` datetime NOT NULL,
  `leadsources_creatorid` int(11) NOT NULL,
  `leadsources_title` varchar(200) NOT NULL COMMENT '[do not truncate] - good to have example sources like google'
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='[truncate]' ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `leads_status`
--

CREATE TABLE `leads_status` (
  `leadstatus_id` int(11) NOT NULL,
  `leadstatus_created` datetime DEFAULT NULL,
  `leadstatus_creatorid` int(11) DEFAULT NULL,
  `leadstatus_updated` datetime DEFAULT NULL,
  `leadstatus_title` varchar(200) NOT NULL,
  `leadstatus_position` int(11) NOT NULL,
  `leadstatus_color` varchar(100) NOT NULL DEFAULT 'default' COMMENT 'default|primary|success|info|warning|danger|lime|brown',
  `leadstatus_system_default` varchar(10) NOT NULL DEFAULT 'no' COMMENT 'yes | no'
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='[do not truncate]  expected to have 2 system default statuses (ID: 1 & 2) ''new'' & ''converted'' statuses ' ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `leads_status`
--

INSERT INTO `leads_status` (`leadstatus_id`, `leadstatus_created`, `leadstatus_creatorid`, `leadstatus_updated`, `leadstatus_title`, `leadstatus_position`, `leadstatus_color`, `leadstatus_system_default`) VALUES
(1, '2024-01-30 15:58:58', 0, '2024-01-30 15:58:58', 'New', 1, 'default', 'yes'),
(2, '2024-01-30 15:58:58', 0, '2024-02-16 22:15:49', 'Follow up', 6, 'success', 'yes'),
(3, '2024-01-30 15:58:58', 0, '2024-02-16 22:15:14', 'Awaiting Photos', 3, 'info', 'no'),
(4, '2024-01-30 15:58:58', 0, '2024-02-16 22:15:39', 'On Hold', 5, 'lime', 'no'),
(5, '2024-01-30 15:58:58', 0, '2024-02-16 22:15:01', 'Voice Mail', 2, 'warning', 'no'),
(7, '2024-01-30 15:58:58', 0, '2024-01-30 15:58:58', 'Disqualified', 4, 'danger', 'no'),
(8, '2024-02-17 19:00:26', 1, '2024-02-17 19:00:37', 'Booked', 7, 'brown', 'no');

-- --------------------------------------------------------

--
-- Table structure for table `lineitems`
--

CREATE TABLE `lineitems` (
  `lineitem_id` int(11) NOT NULL,
  `lineitem_position` int(11) DEFAULT NULL,
  `lineitem_created` datetime DEFAULT NULL,
  `lineitem_updated` datetime DEFAULT NULL,
  `lineitem_description` text DEFAULT NULL,
  `lineitem_rate` varchar(250) DEFAULT NULL,
  `lineitem_unit` varchar(100) DEFAULT NULL,
  `lineitem_quantity` float DEFAULT NULL,
  `lineitem_total` decimal(15,2) DEFAULT NULL,
  `lineitemresource_linked_type` varchar(30) DEFAULT NULL COMMENT 'task | expense',
  `lineitemresource_linked_id` int(11) DEFAULT NULL COMMENT 'e.g. task id',
  `lineitemresource_type` varchar(50) DEFAULT NULL COMMENT '[polymorph] invoice | estimate',
  `lineitemresource_id` int(11) DEFAULT NULL COMMENT '[polymorph] e.g invoice_id',
  `lineitem_type` varchar(10) DEFAULT 'plain' COMMENT 'plain|time|dimensions',
  `lineitem_time_hours` int(11) DEFAULT NULL,
  `lineitem_time_minutes` int(11) DEFAULT NULL,
  `lineitem_time_timers_list` text DEFAULT NULL COMMENT 'comma separated list of timers',
  `lineitem_dimensions_length` float DEFAULT NULL,
  `lineitem_dimensions_width` float DEFAULT NULL,
  `lineitem_tax_status` varchar(100) DEFAULT 'taxable' COMMENT 'taxable|exempt  - this is inherited from the product/item setting',
  `lineitem_linked_product_id` int(11) DEFAULT NULL COMMENT 'the original product that created this line item'
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='[truncate]' ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `logs`
--

CREATE TABLE `logs` (
  `log_id` int(11) NOT NULL,
  `log_uniqueid` varchar(100) DEFAULT NULL COMMENT 'optional',
  `log_created` datetime NOT NULL,
  `log_updated` datetime NOT NULL,
  `log_creatorid` int(11) DEFAULT NULL,
  `log_text` text DEFAULT NULL COMMENT 'either free text or a (lang) string',
  `log_text_type` varchar(20) DEFAULT 'text' COMMENT 'text|lang',
  `log_data_1` varchar(250) DEFAULT NULL COMMENT 'optional data',
  `log_data_2` varchar(250) DEFAULT NULL COMMENT 'optional data',
  `log_data_3` varchar(250) DEFAULT NULL COMMENT 'optional data',
  `log_payload` text DEFAULT NULL COMMENT 'optional',
  `logresource_type` varchar(60) DEFAULT NULL COMMENT 'debug|subscription|invoice|etc',
  `logresource_id` int(11) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `messages`
--

CREATE TABLE `messages` (
  `message_id` int(11) NOT NULL,
  `message_unique_id` varchar(100) NOT NULL,
  `message_created` datetime NOT NULL,
  `message_updated` datetime NOT NULL,
  `message_timestamp` int(11) NOT NULL,
  `message_creatorid` int(11) NOT NULL,
  `message_source` varchar(150) NOT NULL COMMENT 'sender unique id',
  `message_target` varchar(150) NOT NULL COMMENT 'receivers unique id',
  `message_creator_uniqueid` varchar(150) DEFAULT NULL,
  `message_target_uniqueid` varchar(150) DEFAULT NULL,
  `message_text` text DEFAULT NULL,
  `message_file_name` varchar(250) DEFAULT NULL,
  `message_file_directory` varchar(150) DEFAULT NULL,
  `message_file_thumb_name` varchar(150) DEFAULT NULL,
  `message_file_type` varchar(50) DEFAULT NULL COMMENT 'file | image',
  `message_type` varchar(150) DEFAULT 'file' COMMENT 'text | file',
  `message_status` varchar(150) DEFAULT 'unread' COMMENT 'read | unread'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `messages_tracking`
--

CREATE TABLE `messages_tracking` (
  `messagestracking_id` int(11) NOT NULL,
  `messagestracking_created` datetime NOT NULL,
  `messagestracking_update` datetime NOT NULL,
  `messagestracking_massage_unique_id` varchar(120) NOT NULL,
  `messagestracking_target` varchar(120) DEFAULT NULL,
  `messagestracking_user_unique_id` varchar(120) DEFAULT NULL,
  `messagestracking_type` varchar(50) DEFAULT NULL COMMENT 'read|delete'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `milestones`
--

CREATE TABLE `milestones` (
  `milestone_id` int(11) NOT NULL,
  `milestone_created` datetime NOT NULL,
  `milestone_updated` datetime NOT NULL,
  `milestone_creatorid` int(11) NOT NULL,
  `milestone_title` varchar(250) NOT NULL DEFAULT 'uncategorised',
  `milestone_projectid` int(11) DEFAULT NULL,
  `milestone_position` int(11) NOT NULL DEFAULT 1,
  `milestone_type` varchar(50) NOT NULL DEFAULT 'categorised' COMMENT 'categorised|uncategorised [1 uncategorised milestone if automatically created when a new project is created]',
  `milestone_color` varchar(50) NOT NULL DEFAULT 'default' COMMENT 'default|primary|success|info|warning|danger|lime|brown'
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='[truncate]' ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `milestone_categories`
--

CREATE TABLE `milestone_categories` (
  `milestonecategory_id` int(11) NOT NULL,
  `milestonecategory_created` datetime NOT NULL,
  `milestonecategory_updated` datetime NOT NULL,
  `milestonecategory_creatorid` int(11) NOT NULL,
  `milestonecategory_title` varchar(250) NOT NULL,
  `milestonecategory_position` int(11) NOT NULL,
  `milestonecategory_color` varchar(100) DEFAULT 'default' COMMENT 'default|primary|success|info|warning|danger|lime|brown'
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `milestone_categories`
--

INSERT INTO `milestone_categories` (`milestonecategory_id`, `milestonecategory_created`, `milestonecategory_updated`, `milestonecategory_creatorid`, `milestonecategory_title`, `milestonecategory_position`, `milestonecategory_color`) VALUES
(1, '2024-01-19 15:42:44', '2024-01-19 17:30:24', 0, 'Planning', 1, 'default'),
(2, '2024-01-19 15:42:44', '2024-01-19 17:30:32', 0, 'Design', 2, 'default'),
(3, '2024-01-19 15:42:44', '2024-01-19 15:42:44', 0, 'Development', 3, 'default'),
(4, '2024-01-19 15:42:44', '2024-01-19 15:42:44', 0, 'Testing', 4, 'default');

-- --------------------------------------------------------

--
-- Table structure for table `notes`
--

CREATE TABLE `notes` (
  `note_id` int(11) NOT NULL,
  `note_created` datetime DEFAULT NULL COMMENT 'always now()',
  `note_updated` datetime DEFAULT NULL,
  `note_creatorid` int(11) DEFAULT NULL,
  `note_title` varchar(250) DEFAULT NULL,
  `note_description` text DEFAULT NULL,
  `note_visibility` varchar(30) DEFAULT 'public' COMMENT 'private|public',
  `noteresource_type` varchar(50) DEFAULT NULL COMMENT '[polymorph] client | project | user | lead',
  `noteresource_id` int(11) DEFAULT NULL COMMENT '[polymorph] e.g project_id'
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='[truncate]. Notes are always private to the user who created them. They are never visible to anyone else' ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `notes`
--

INSERT INTO `notes` (`note_id`, `note_created`, `note_updated`, `note_creatorid`, `note_title`, `note_description`, `note_visibility`, `noteresource_type`, `noteresource_id`) VALUES
(1, '2024-02-19 23:01:51', '2024-02-19 23:01:51', 1, NULL, 'test', 'private', 'lead', 1);

-- --------------------------------------------------------

--
-- Table structure for table `payments`
--

CREATE TABLE `payments` (
  `payment_id` int(11) NOT NULL COMMENT '[truncate]',
  `payment_created` datetime DEFAULT NULL,
  `payment_updated` datetime DEFAULT NULL,
  `payment_creatorid` int(11) DEFAULT NULL COMMENT '''0'' for system',
  `payment_date` date DEFAULT NULL,
  `payment_invoiceid` int(11) DEFAULT NULL COMMENT 'invoice id',
  `payment_subscriptionid` int(11) DEFAULT NULL COMMENT 'subscription id',
  `payment_clientid` int(11) DEFAULT NULL,
  `payment_projectid` int(11) DEFAULT NULL,
  `payment_amount` decimal(10,2) NOT NULL,
  `payment_transaction_id` varchar(100) DEFAULT NULL,
  `payment_gateway` varchar(100) DEFAULT NULL COMMENT 'paypal | stripe | cash | bank',
  `payment_notes` text DEFAULT NULL,
  `payment_type` varchar(50) DEFAULT 'invoice' COMMENT 'invoice|subscription'
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='[truncate]' ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `payment_sessions`
--

CREATE TABLE `payment_sessions` (
  `session_id` int(11) NOT NULL,
  `session_created` datetime DEFAULT NULL,
  `session_updated` datetime DEFAULT NULL,
  `session_creatorid` int(11) DEFAULT NULL COMMENT 'user making the payment',
  `session_creator_fullname` varchar(150) DEFAULT NULL,
  `session_creator_email` varchar(150) DEFAULT NULL,
  `session_gateway_name` varchar(150) DEFAULT NULL COMMENT 'stripe | paypal | etc',
  `session_gateway_ref` varchar(150) DEFAULT NULL COMMENT 'Stripe - The checkout_session_id | Paypal -',
  `session_amount` decimal(10,2) DEFAULT NULL COMMENT 'amount of the payment',
  `session_invoices` varchar(250) DEFAULT NULL COMMENT '[currently] - single invoice id | [future] - comma seperated list of invoice id''s that are for this payment',
  `session_subscription` int(11) DEFAULT NULL COMMENT 'subscription id',
  `session_payload` text DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='Track payment sessions so that IPN/Webhook calls can be linked to the correct invoice. Cronjob can be used to cleanup this table for any records older than 72hrs' ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `product_tasks`
--

CREATE TABLE `product_tasks` (
  `product_task_id` int(11) NOT NULL,
  `product_task_created` date NOT NULL,
  `product_task_updated` date NOT NULL,
  `product_task_creatorid` int(11) DEFAULT NULL,
  `product_task_itemid` int(11) DEFAULT NULL,
  `product_task_title` varchar(250) DEFAULT NULL,
  `product_task_description` text DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `product_tasks_dependencies`
--

CREATE TABLE `product_tasks_dependencies` (
  `product_task_dependency_id` int(11) NOT NULL,
  `product_task_dependency_created` date NOT NULL,
  `product_task_dependency_updated` date NOT NULL,
  `product_task_dependency_taskid` int(11) DEFAULT NULL,
  `product_task_dependency_blockerid` int(11) DEFAULT NULL,
  `product_task_dependency_type` varchar(100) DEFAULT NULL COMMENT 'cannot_complete|cannot_start'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `projects`
--

CREATE TABLE `projects` (
  `project_id` int(11) NOT NULL,
  `project_uniqueid` varchar(100) DEFAULT NULL COMMENT 'optional',
  `project_type` varchar(30) NOT NULL DEFAULT 'project' COMMENT 'project|template|space',
  `project_reference` varchar(250) DEFAULT NULL COMMENT '[optiona] additional data for identifying a project',
  `project_importid` varchar(100) DEFAULT NULL,
  `project_created` datetime DEFAULT NULL,
  `project_updated` datetime DEFAULT NULL,
  `project_timestamp_created` int(11) DEFAULT NULL,
  `project_timestamp_updated` int(11) DEFAULT NULL,
  `project_clientid` int(11) DEFAULT NULL,
  `project_creatorid` int(11) NOT NULL COMMENT 'creator of the project',
  `project_categoryid` int(11) DEFAULT 1 COMMENT 'default category',
  `project_cover_directory` varchar(100) DEFAULT NULL,
  `project_cover_filename` varchar(100) DEFAULT NULL,
  `project_cover_file_id` int(11) DEFAULT NULL COMMENT 'if this cover was made from an existing file',
  `project_title` varchar(250) NOT NULL,
  `project_date_start` date DEFAULT NULL,
  `project_date_due` date DEFAULT NULL,
  `project_description` text DEFAULT NULL,
  `project_status` varchar(50) DEFAULT 'not_started' COMMENT 'not_started | in_progress | on_hold | cancelled | completed',
  `project_active_state` varchar(10) DEFAULT 'active' COMMENT 'active|archive',
  `project_progress` tinyint(4) DEFAULT 0,
  `project_billing_rate` decimal(10,2) DEFAULT 0.00,
  `project_billing_type` varchar(40) DEFAULT 'hourly' COMMENT 'hourly | fixed',
  `project_billing_estimated_hours` int(11) DEFAULT 0 COMMENT 'estimated hours',
  `project_billing_costs_estimate` decimal(10,2) DEFAULT 0.00,
  `project_progress_manually` varchar(10) DEFAULT 'no' COMMENT 'yes | no',
  `clientperm_tasks_view` varchar(10) DEFAULT 'yes' COMMENT 'yes | no',
  `clientperm_tasks_collaborate` varchar(40) DEFAULT 'yes' COMMENT 'yes | no',
  `clientperm_tasks_create` varchar(40) DEFAULT 'yes' COMMENT 'yes | no',
  `clientperm_timesheets_view` varchar(40) DEFAULT 'yes' COMMENT 'yes | no',
  `clientperm_expenses_view` varchar(40) DEFAULT 'no' COMMENT 'yes | no',
  `assignedperm_milestone_manage` varchar(40) DEFAULT 'yes' COMMENT 'yes | no',
  `assignedperm_tasks_collaborate` varchar(40) DEFAULT NULL COMMENT 'yes | no',
  `project_visibility` varchar(40) DEFAULT 'visible' COMMENT 'visible|hidden (used to prevent projects that are still being cloned from showing in projects list)',
  `project_custom_field_1` tinytext DEFAULT NULL,
  `project_custom_field_2` tinytext DEFAULT NULL,
  `project_custom_field_3` tinytext DEFAULT NULL,
  `project_custom_field_4` tinytext DEFAULT NULL,
  `project_custom_field_5` tinytext DEFAULT NULL,
  `project_custom_field_6` tinytext DEFAULT NULL,
  `project_custom_field_7` tinytext DEFAULT NULL,
  `project_custom_field_8` tinytext DEFAULT NULL,
  `project_custom_field_9` tinytext DEFAULT NULL,
  `project_custom_field_10` tinytext DEFAULT NULL,
  `project_custom_field_11` datetime DEFAULT NULL,
  `project_custom_field_12` datetime DEFAULT NULL,
  `project_custom_field_13` datetime DEFAULT NULL,
  `project_custom_field_14` datetime DEFAULT NULL,
  `project_custom_field_15` datetime DEFAULT NULL,
  `project_custom_field_16` datetime DEFAULT NULL,
  `project_custom_field_17` datetime DEFAULT NULL,
  `project_custom_field_18` datetime DEFAULT NULL,
  `project_custom_field_19` datetime DEFAULT NULL,
  `project_custom_field_20` datetime DEFAULT NULL,
  `project_custom_field_21` text DEFAULT NULL,
  `project_custom_field_22` text DEFAULT NULL,
  `project_custom_field_23` text DEFAULT NULL,
  `project_custom_field_24` text DEFAULT NULL,
  `project_custom_field_25` text DEFAULT NULL,
  `project_custom_field_26` text DEFAULT NULL,
  `project_custom_field_27` text DEFAULT NULL,
  `project_custom_field_28` text DEFAULT NULL,
  `project_custom_field_29` text DEFAULT NULL,
  `project_custom_field_30` text DEFAULT NULL,
  `project_custom_field_31` varchar(20) DEFAULT NULL,
  `project_custom_field_32` varchar(20) DEFAULT NULL,
  `project_custom_field_33` varchar(20) DEFAULT NULL,
  `project_custom_field_34` varchar(20) DEFAULT NULL,
  `project_custom_field_35` varchar(20) DEFAULT NULL,
  `project_custom_field_36` varchar(20) DEFAULT NULL,
  `project_custom_field_37` varchar(20) DEFAULT NULL,
  `project_custom_field_38` varchar(20) DEFAULT NULL,
  `project_custom_field_39` varchar(20) DEFAULT NULL,
  `project_custom_field_40` varchar(20) DEFAULT NULL,
  `project_custom_field_41` varchar(150) DEFAULT NULL,
  `project_custom_field_42` varchar(150) DEFAULT NULL,
  `project_custom_field_43` varchar(150) DEFAULT NULL,
  `project_custom_field_44` varchar(150) DEFAULT NULL,
  `project_custom_field_45` varchar(150) DEFAULT NULL,
  `project_custom_field_46` varchar(150) DEFAULT NULL,
  `project_custom_field_47` varchar(150) DEFAULT NULL,
  `project_custom_field_48` varchar(150) DEFAULT NULL,
  `project_custom_field_49` varchar(150) DEFAULT NULL,
  `project_custom_field_50` varchar(150) DEFAULT NULL,
  `project_custom_field_51` int(11) DEFAULT NULL,
  `project_custom_field_52` int(11) DEFAULT NULL,
  `project_custom_field_53` int(11) DEFAULT NULL,
  `project_custom_field_54` int(11) DEFAULT NULL,
  `project_custom_field_55` int(11) DEFAULT NULL,
  `project_custom_field_56` int(11) DEFAULT NULL,
  `project_custom_field_57` int(11) DEFAULT NULL,
  `project_custom_field_58` int(11) DEFAULT NULL,
  `project_custom_field_59` int(11) DEFAULT NULL,
  `project_custom_field_60` int(11) DEFAULT NULL,
  `project_custom_field_61` decimal(10,2) DEFAULT NULL,
  `project_custom_field_62` decimal(10,2) DEFAULT NULL,
  `project_custom_field_63` decimal(10,2) DEFAULT NULL,
  `project_custom_field_64` decimal(10,2) DEFAULT NULL,
  `project_custom_field_65` decimal(10,2) DEFAULT NULL,
  `project_custom_field_66` decimal(10,2) DEFAULT NULL,
  `project_custom_field_67` decimal(10,2) DEFAULT NULL,
  `project_custom_field_68` decimal(10,2) DEFAULT NULL,
  `project_custom_field_69` decimal(10,2) DEFAULT NULL,
  `project_custom_field_70` decimal(10,2) DEFAULT NULL,
  `project_automation_status` varchar(30) DEFAULT 'disabled' COMMENT 'disabled|enabled',
  `project_automation_create_invoices` varchar(30) DEFAULT 'no' COMMENT 'yes|no',
  `project_automation_convert_estimates_to_invoices` varchar(30) DEFAULT 'no' COMMENT 'yes|no',
  `project_automation_invoice_unbilled_hours` varchar(30) DEFAULT 'no' COMMENT 'yes|no',
  `project_automation_invoice_hourly_rate` decimal(10,2) DEFAULT NULL,
  `project_automation_invoice_hourly_tax_1` int(11) DEFAULT NULL,
  `project_automation_invoice_email_client` varchar(30) DEFAULT 'no' COMMENT 'yes|no',
  `project_automation_invoice_due_date` int(11) DEFAULT 0
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='[truncate]' ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `projects`
--

INSERT INTO `projects` (`project_id`, `project_uniqueid`, `project_type`, `project_reference`, `project_importid`, `project_created`, `project_updated`, `project_timestamp_created`, `project_timestamp_updated`, `project_clientid`, `project_creatorid`, `project_categoryid`, `project_cover_directory`, `project_cover_filename`, `project_cover_file_id`, `project_title`, `project_date_start`, `project_date_due`, `project_description`, `project_status`, `project_active_state`, `project_progress`, `project_billing_rate`, `project_billing_type`, `project_billing_estimated_hours`, `project_billing_costs_estimate`, `project_progress_manually`, `clientperm_tasks_view`, `clientperm_tasks_collaborate`, `clientperm_tasks_create`, `clientperm_timesheets_view`, `clientperm_expenses_view`, `assignedperm_milestone_manage`, `assignedperm_tasks_collaborate`, `project_visibility`, `project_custom_field_1`, `project_custom_field_2`, `project_custom_field_3`, `project_custom_field_4`, `project_custom_field_5`, `project_custom_field_6`, `project_custom_field_7`, `project_custom_field_8`, `project_custom_field_9`, `project_custom_field_10`, `project_custom_field_11`, `project_custom_field_12`, `project_custom_field_13`, `project_custom_field_14`, `project_custom_field_15`, `project_custom_field_16`, `project_custom_field_17`, `project_custom_field_18`, `project_custom_field_19`, `project_custom_field_20`, `project_custom_field_21`, `project_custom_field_22`, `project_custom_field_23`, `project_custom_field_24`, `project_custom_field_25`, `project_custom_field_26`, `project_custom_field_27`, `project_custom_field_28`, `project_custom_field_29`, `project_custom_field_30`, `project_custom_field_31`, `project_custom_field_32`, `project_custom_field_33`, `project_custom_field_34`, `project_custom_field_35`, `project_custom_field_36`, `project_custom_field_37`, `project_custom_field_38`, `project_custom_field_39`, `project_custom_field_40`, `project_custom_field_41`, `project_custom_field_42`, `project_custom_field_43`, `project_custom_field_44`, `project_custom_field_45`, `project_custom_field_46`, `project_custom_field_47`, `project_custom_field_48`, `project_custom_field_49`, `project_custom_field_50`, `project_custom_field_51`, `project_custom_field_52`, `project_custom_field_53`, `project_custom_field_54`, `project_custom_field_55`, `project_custom_field_56`, `project_custom_field_57`, `project_custom_field_58`, `project_custom_field_59`, `project_custom_field_60`, `project_custom_field_61`, `project_custom_field_62`, `project_custom_field_63`, `project_custom_field_64`, `project_custom_field_65`, `project_custom_field_66`, `project_custom_field_67`, `project_custom_field_68`, `project_custom_field_69`, `project_custom_field_70`, `project_automation_status`, `project_automation_create_invoices`, `project_automation_convert_estimates_to_invoices`, `project_automation_invoice_unbilled_hours`, `project_automation_invoice_hourly_rate`, `project_automation_invoice_hourly_tax_1`, `project_automation_invoice_email_client`, `project_automation_invoice_due_date`) VALUES
(-1708194549, '65d0faf5c4b856.43453283', 'space', 'default-team-space', NULL, '2024-02-17 18:29:09', '2024-02-17 18:29:09', NULL, NULL, NULL, 0, 1, NULL, NULL, NULL, 'Team Workspace', NULL, NULL, NULL, 'not_started', 'active', 0, 0.00, 'hourly', 0, 0.00, 'no', 'yes', 'yes', 'yes', 'yes', 'no', 'yes', NULL, 'visible', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'disabled', 'no', 'no', 'no', NULL, NULL, 'no', 0);

-- --------------------------------------------------------

--
-- Table structure for table `projects_assigned`
--

CREATE TABLE `projects_assigned` (
  `projectsassigned_id` int(11) NOT NULL COMMENT '[truncate]',
  `projectsassigned_projectid` int(11) DEFAULT NULL,
  `projectsassigned_userid` int(11) DEFAULT NULL,
  `projectsassigned_created` datetime DEFAULT NULL,
  `projectsassigned_updated` datetime DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='[truncate]' ROW_FORMAT=FIXED;

-- --------------------------------------------------------

--
-- Table structure for table `projects_manager`
--

CREATE TABLE `projects_manager` (
  `projectsmanager_id` int(11) NOT NULL,
  `projectsmanager_created` datetime NOT NULL,
  `projectsmanager_updated` datetime NOT NULL,
  `projectsmanager_projectid` int(11) DEFAULT NULL,
  `projectsmanager_userid` int(11) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='[truncate]' ROW_FORMAT=FIXED;

-- --------------------------------------------------------

--
-- Table structure for table `proposals`
--

CREATE TABLE `proposals` (
  `doc_id` int(11) NOT NULL,
  `doc_unique_id` varchar(150) DEFAULT NULL,
  `doc_template` varchar(150) DEFAULT NULL COMMENT 'default',
  `doc_created` datetime NOT NULL,
  `doc_updated` datetime NOT NULL,
  `doc_date_status_change` datetime DEFAULT NULL,
  `doc_creatorid` int(11) NOT NULL COMMENT 'use ( -1 ) for logged out user.',
  `doc_categoryid` int(11) DEFAULT 11 COMMENT '11 is the default category',
  `doc_heading` varchar(250) DEFAULT NULL COMMENT 'e.g. proposal',
  `doc_heading_color` varchar(30) DEFAULT NULL,
  `doc_title` varchar(250) DEFAULT NULL,
  `doc_title_color` varchar(30) DEFAULT NULL,
  `doc_hero_direcory` varchar(250) DEFAULT NULL,
  `doc_hero_filename` varchar(250) DEFAULT NULL,
  `doc_hero_updated` varchar(250) DEFAULT 'no' COMMENT 'ys|no (when no, we use default image path)',
  `doc_body` text DEFAULT NULL,
  `doc_date_start` date DEFAULT NULL COMMENT 'Proposal Issue Date | Contract Start Date',
  `doc_date_end` date DEFAULT NULL COMMENT 'Proposal Expiry Date | Contract End Date',
  `doc_date_published` date DEFAULT NULL,
  `doc_date_last_emailed` datetime DEFAULT NULL,
  `doc_client_id` int(11) DEFAULT NULL,
  `doc_project_id` int(11) DEFAULT NULL,
  `doc_lead_id` int(11) DEFAULT NULL,
  `doc_notes` text DEFAULT NULL,
  `doc_viewed` varchar(20) DEFAULT 'no' COMMENT 'yes|no',
  `doc_type` varchar(150) DEFAULT NULL COMMENT 'proposal|contract',
  `doc_system_type` varchar(150) DEFAULT 'document' COMMENT 'document|template',
  `doc_signed_date` datetime DEFAULT NULL,
  `doc_signed_first_name` varchar(150) DEFAULT '',
  `doc_signed_last_name` varchar(150) DEFAULT '',
  `doc_signed_signature_directory` varchar(150) DEFAULT '',
  `doc_signed_signature_filename` varchar(150) DEFAULT '',
  `doc_signed_ip_address` varchar(150) DEFAULT NULL,
  `doc_fallback_client_first_name` varchar(150) DEFAULT '' COMMENT 'used for creating events when users are not logged in',
  `doc_fallback_client_last_name` varchar(150) DEFAULT '' COMMENT 'used for creating events when users are not logged in',
  `doc_fallback_client_email` varchar(150) DEFAULT '' COMMENT 'used for creating events when users are not logged in',
  `doc_status` varchar(100) DEFAULT 'draft' COMMENT 'draft|new|accepted|declined|revised|expired',
  `docresource_type` varchar(100) DEFAULT NULL COMMENT 'client|lead',
  `docresource_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `proposal_templates`
--

CREATE TABLE `proposal_templates` (
  `proposal_template_id` int(11) NOT NULL,
  `proposal_template_created` datetime NOT NULL,
  `proposal_template_updated` datetime NOT NULL,
  `proposal_template_creatorid` int(11) DEFAULT NULL,
  `proposal_template_title` varchar(250) DEFAULT NULL,
  `proposal_template_heading_color` varchar(30) DEFAULT '#FFFFFF',
  `proposal_template_title_color` varchar(30) DEFAULT '#FFFFFF',
  `proposal_template_body` text DEFAULT NULL,
  `proposal_template_estimate_id` int(11) DEFAULT NULL,
  `proposal_template_system` varchar(20) DEFAULT 'no' COMMENT 'yes|no'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `proposal_templates`
--

INSERT INTO `proposal_templates` (`proposal_template_id`, `proposal_template_created`, `proposal_template_updated`, `proposal_template_creatorid`, `proposal_template_title`, `proposal_template_heading_color`, `proposal_template_title_color`, `proposal_template_body`, `proposal_template_estimate_id`, `proposal_template_system`) VALUES
(1, '2024-02-15 21:58:22', '2022-05-22 09:15:49', 1, 'Default Template', '#FFFFFF', '#FFFFFF', '<h2 style=\"font-family: Montserrat;\"><span style=\"color: #67757c; font-size: 14px;\">Thank you, on behalf of the entire </span><strong style=\"color: #67757c; font-size: 14px;\">{company_name}</strong><span style=\"color: #67757c; font-size: 14px;\"> team, for reaching out to us and giving us the opportunity to collaborate with you on your project. We are ready to provide you with the experience and expertise needed to complete your project on time and on budget.</span></h2>\r\n<br /><strong>Once again, thank you for the opportunity to earn your business.<br /></strong><br /><br /><br />\r\n<table style=\"border-collapse: collapse; width: 100%;\" border=\"1\">\r\n<tbody>\r\n<tr>\r\n<td style=\"width: 50%; border-color: #ffffff; text-align: left; vertical-align: top;\"><img src=\"public/documents/images/sample-1.jpg\" alt=\"\" width=\"389\" height=\"466\" /></td>\r\n<td style=\"width: 50%; border-color: #ffffff; vertical-align: top;\">\r\n<h3 style=\"font-family: Montserrat;\"><span style=\"text-decoration: underline;\">About Us</span></h3>\r\n<span style=\"font-family: Montserrat;\">We believe in creating websites that not only&nbsp;</span><span style=\"font-family: Montserrat;\">look amazing</span><span style=\"font-family: Montserrat;\">&nbsp;but also provide a fantastic user experience and are&nbsp;</span><span style=\"font-family: Montserrat;\">highly optimized</span><span style=\"font-family: Montserrat;\">&nbsp;to provide you with the best</span><span style=\"font-family: Montserrat;\">&nbsp;search ranking</span><span style=\"font-family: Montserrat;\">&nbsp;benefits possible. <br /><br /><strong>We are a full-stack development firm with experience in the following areas:</strong></span><br style=\"font-family: Montserrat;\" /><br style=\"font-family: Montserrat;\" />\r\n<ul>\r\n<li>\r\n<h5>Example Skill Set</h5>\r\n</li>\r\n<li>\r\n<h5>Example Skill Set</h5>\r\n</li>\r\n<li>\r\n<h5>Example Skill Set</h5>\r\n</li>\r\n<li>\r\n<h5>Example Skill Set</h5>\r\n</li>\r\n<li>\r\n<h5>Example Skill Set</h5>\r\n</li>\r\n<li>\r\n<h5>Example Skill Set</h5>\r\n</li>\r\n</ul>\r\n<br /><span style=\"font-family: Montserrat;\">We have over&nbsp;</span><span style=\"font-weight: 600; font-family: Montserrat;\">10 years</span><span style=\"font-family: Montserrat;\">&nbsp;of experience working with outstanding brands like yours. <br /><br />We are happy to provide you with references upon request.</span></td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n<h3><span style=\"text-decoration: underline;\"><br /><br />Your Needs</span></h3>\r\nAfter reviewing your requirements and discussing with you at length about them, we\'ve created a vision for your website that we believe will improve your overall brand presence, resulting in more leads and conversions for your business.<br /><br />\r\n<ul>\r\n<li>\r\n<h5>Example Item</h5>\r\n</li>\r\n<li>\r\n<h5>Example Item</h5>\r\n</li>\r\n<li>\r\n<h5>Example Item</h5>\r\n</li>\r\n<li>\r\n<h5>Example Item</h5>\r\n</li>\r\n</ul>\r\n<br />\r\n<table style=\"border-collapse: collapse; width: 100%; height: 337px;\" border=\"1\">\r\n<tbody>\r\n<tr style=\"height: 337px;\">\r\n<td style=\"width: 50%; border-color: #ffffff; vertical-align: top; height: 337px;\">\r\n<h3><span style=\"text-decoration: underline;\"><br />Our Process</span></h3>\r\n<span style=\"font-family: Montserrat;\">We have devised a process that ensures a robust, yet fluid approach to completing your project on time, on budget, and beyond your expectation.</span><br style=\"font-family: Montserrat;\" /><br style=\"font-family: Montserrat;\" /><span style=\"text-decoration: underline;\"><span style=\"font-weight: 600;\">Here\'s what you can expect once your project begins.</span></span><br style=\"font-family: Montserrat;\" /><br style=\"font-family: Montserrat;\" />\r\n<ul style=\"font-family: Montserrat;\">\r\n<li>\r\n<h5>Example Process Step</h5>\r\n</li>\r\n<li>\r\n<h5>Example Process Step</h5>\r\n</li>\r\n<li>\r\n<h5>Example Process Step</h5>\r\n</li>\r\n<li>\r\n<h5>Example Process Step</h5>\r\n</li>\r\n</ul>\r\n</td>\r\n<td style=\"width: 50%; border-color: #ffffff; height: 337px; text-align: right;\"><img src=\"public/documents/images/sample-2.png\" alt=\"\" width=\"401\" height=\"266\" /></td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n<h3><span style=\"text-decoration: underline;\"><br /><br />Project Milestones</span></h3>\r\nOur estimated timeline for your project is shown in the table below.<br /><br />\r\n<table style=\"border-collapse: collapse; width: 100%; height: 240px;\" border=\"1\">\r\n<tbody>\r\n<tr style=\"height: 48px;\">\r\n<th style=\"width: 50%; background-color: #efeeee; height: 48px;\"><strong>Milestone</strong></th>\r\n<th style=\"width: 50%; background-color: #efeeee; height: 48px;\"><strong>Target Date</strong></th>\r\n</tr>\r\n<tr style=\"height: 48px;\">\r\n<td style=\"width: 50%; height: 48px;\">Example milestone 1</td>\r\n<td style=\"width: 50%; height: 48px;\">01-10-2022</td>\r\n</tr>\r\n<tr style=\"height: 48px;\">\r\n<td style=\"width: 50%; height: 48px;\">Example milestone 2</td>\r\n<td style=\"width: 50%; height: 48px;\">01-23-2022</td>\r\n</tr>\r\n<tr style=\"height: 48px;\">\r\n<td style=\"width: 50%; height: 48px;\">Example milestone 3</td>\r\n<td style=\"width: 50%; height: 48px;\">02-15-2022</td>\r\n</tr>\r\n<tr style=\"height: 48px;\">\r\n<td style=\"width: 50%; height: 48px;\">Example milestone 4</td>\r\n<td style=\"width: 50%; height: 48px;\">03-12-2022</td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n<h3><span style=\"text-decoration: underline;\"><br /><br />Project Pricing</span></h3>\r\nThe costs for your design project are listed in the table below.<br /><br />{pricing_table}<br />\r\n<h3><span style=\"text-decoration: underline;\"><br /><br />Meet The Team</span></h3>\r\n<p>We are a team of 8 and below are the people that will be working directly on your project.<br /><!--MEET THE TEACM [START]--></p>\r\n<table class=\"doc-meet-the-team\" style=\"height: autho;\" width=\"100%\">\r\n<tbody>\r\n<tr>\r\n<td style=\"width: 50%; background-color: #fbfcfd;\">\r\n<div class=\"row\">\r\n<div class=\"col-sm-12 col-md-4\"><img src=\"public/documents/images/sample-3.jpg\" alt=\"\" width=\"600\" height=\"600\" /></div>\r\n<div class=\"col-sm-6 col-md-8\">\r\n<h4>Jonathan Reed</h4>\r\n<strong>Project Lead</strong><br />75 Reed Street, London, U.K.<br /><strong>Tel:</strong> +44 123 456 7890<br /><strong>Email:</strong> john@example.com</div>\r\n</div>\r\n</td>\r\n<td class=\"spacer\">&nbsp;</td>\r\n<td style=\"width: 50%; background-color: #fbfcfd;\">\r\n<div class=\"row\">\r\n<div class=\"col-sm-12 col-md-4\"><img src=\"public/documents/images/sample-4.jpg\" alt=\"\" width=\"600\" height=\"600\" /></div>\r\n<div class=\"col-sm-6 col-md-8\">\r\n<h4>Jane Doney</h4>\r\n<strong>Web Designer</strong><br />75 Reed Street, London, U.K.<br /><strong>Tel:</strong> +44 123 456 7890<br /><strong>Email:</strong> jane@example.com</div>\r\n</div>\r\n</td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n<br /><!--MEET THE TEACM [END]--> <!--MEET THE TEACM [START]-->\r\n<table class=\"doc-meet-the-team\" style=\"height: autho;\" width=\"100%\">\r\n<tbody>\r\n<tr>\r\n<td style=\"width: 50%; background-color: #fbfcfd;\">\r\n<div class=\"row\">\r\n<div class=\"col-sm-12 col-md-4\"><img src=\"public/documents/images/sample-5.jpg\" alt=\"\" width=\"600\" height=\"600\" /></div>\r\n<div class=\"col-sm-6 col-md-8\">\r\n<h4>David Patterson</h4>\r\n<strong>UX &amp; UI Designer</strong><br />75 Reed Street, London, U.K.<br /><strong>Tel:</strong> +44 123 456 7890<br /><strong>Email:</strong> david@example.com</div>\r\n</div>\r\n</td>\r\n<td class=\"spacer\">&nbsp;</td>\r\n<td style=\"width: 50%; background-color: #fbfcfd;\">\r\n<div class=\"row\">\r\n<div class=\"col-sm-12 col-md-4\"><img src=\"public/documents/images/sample-6.jpg\" alt=\"\" width=\"150\" height=\"150\" /></div>\r\n<div class=\"col-sm-6 col-md-8\">\r\n<h4>Amanda Lewis</h4>\r\n<strong>Full-Stack Developer</strong><br />75 Reed Street, London, U.K.<br /><strong>Tel:</strong> +44 123 456 7890<br /><strong>Email:</strong>&nbsp;amanda@example.com</div>\r\n</div>\r\n</td>\r\n</tr>\r\n</tbody>\r\n</table>', NULL, 'no');

-- --------------------------------------------------------

--
-- Table structure for table `reminders`
--

CREATE TABLE `reminders` (
  `reminder_id` int(11) NOT NULL,
  `reminder_created` datetime NOT NULL,
  `reminder_updated` datetime NOT NULL,
  `reminder_userid` int(11) DEFAULT NULL,
  `reminder_datetime` datetime DEFAULT NULL,
  `reminder_timestamp` timestamp NULL DEFAULT NULL,
  `reminder_title` varchar(250) DEFAULT NULL,
  `reminder_meta` varchar(250) DEFAULT NULL,
  `reminder_notes` text DEFAULT NULL,
  `reminder_status` varchar(10) DEFAULT 'new' COMMENT 'active|due',
  `reminder_sent` varchar(10) DEFAULT 'no' COMMENT 'yes|no',
  `reminderresource_type` varchar(50) DEFAULT NULL COMMENT 'project|client|estimate|lead|task|invoice|ticket',
  `reminderresource_id` int(11) DEFAULT NULL COMMENT 'linked resoucre id'
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `roles`
--

CREATE TABLE `roles` (
  `role_id` int(11) NOT NULL,
  `role_created` datetime DEFAULT NULL,
  `role_updated` datetime DEFAULT NULL,
  `role_system` varchar(10) NOT NULL DEFAULT 'no' COMMENT 'yes | no (system roles cannot be deleted)',
  `role_type` varchar(10) NOT NULL COMMENT 'client|team',
  `role_name` varchar(100) NOT NULL,
  `role_clients` tinyint(4) NOT NULL DEFAULT 0 COMMENT 'none (0) | view (1) | view-add-edit (2) | view-edit-add-delete (3)',
  `role_contacts` tinyint(4) NOT NULL COMMENT 'none (0) | view (1) | view-add-edit (2) | view-edit-add-delete (3)',
  `role_contracts` tinyint(4) NOT NULL DEFAULT 0 COMMENT 'none (0) | view (1) | view-add-edit (2) | view-edit-add-delete (3)',
  `role_invoices` tinyint(4) NOT NULL DEFAULT 0 COMMENT 'none (0) | view (1) | view-add-edit (2) | view-edit-add-delete (3)',
  `role_estimates` tinyint(4) NOT NULL DEFAULT 0 COMMENT 'none (0) | view (1) | view-add-edit (2) | view-edit-add-delete (3)',
  `role_proposals` tinyint(4) NOT NULL DEFAULT 0 COMMENT 'none (0) | view (1) | view-add-edit (2) | view-edit-add-delete (3)',
  `role_payments` tinyint(4) NOT NULL DEFAULT 0 COMMENT 'none (0) | view (1) | view-add-edit (2) | view-edit-add-delete (3)',
  `role_items` tinyint(4) NOT NULL DEFAULT 0 COMMENT 'none (0) | view (1) | view-add-edit (2) | view-edit-add-delete (3)',
  `role_tasks` tinyint(4) NOT NULL DEFAULT 0 COMMENT 'none (0) | view (1) | view-add-edit (2) | view-edit-add-delete (3)',
  `role_tasks_scope` varchar(20) NOT NULL DEFAULT 'own' COMMENT 'own | global',
  `role_projects` tinyint(4) NOT NULL DEFAULT 0 COMMENT 'none (0) | view (1) | view-add-edit (2) | view-edit-add-delete (3)',
  `role_projects_scope` varchar(20) NOT NULL DEFAULT 'own' COMMENT 'own | global',
  `role_projects_billing` varchar(20) NOT NULL DEFAULT '0' COMMENT 'none (0) | view (1) | view-add-edit (2)',
  `role_leads` tinyint(4) NOT NULL DEFAULT 0 COMMENT 'none (0) | view (1) | view-add-edit (2) | view-edit-add-delete (3)',
  `role_leads_scope` varchar(20) NOT NULL DEFAULT 'own' COMMENT 'own | global',
  `role_expenses` tinyint(4) NOT NULL DEFAULT 0 COMMENT 'none (0) | view (1) | view-add-edit (2) | view-edit-add-delete (3)',
  `role_expenses_scope` varchar(20) NOT NULL DEFAULT 'own' COMMENT 'own | global',
  `role_timesheets` int(11) NOT NULL DEFAULT 0 COMMENT 'none (0) | view (1) | view-delete (2)',
  `role_timesheets_scope` varchar(20) NOT NULL DEFAULT 'own' COMMENT 'own | global',
  `role_team` tinyint(4) NOT NULL DEFAULT 0 COMMENT 'none (0) | view (1) | view-add-edit (2) | view-edit-add-delete (3)',
  `role_team_scope` varchar(20) NOT NULL DEFAULT 'global' COMMENT 'own | global',
  `role_tickets` tinyint(4) NOT NULL DEFAULT 0 COMMENT 'none (0) | view (1) | view-add-edit (2) | view-edit-add-delete (3)',
  `role_knowledgebase` tinyint(4) NOT NULL DEFAULT 0 COMMENT 'none (0) | view (1) | view-add-edit (2) | view-edit-add-delete (3)',
  `role_manage_knowledgebase_categories` varchar(20) NOT NULL DEFAULT 'no' COMMENT 'yes|no',
  `role_assign_projects` varchar(20) NOT NULL DEFAULT 'no' COMMENT 'yes|no',
  `role_assign_leads` varchar(20) NOT NULL DEFAULT 'no' COMMENT 'yes|no',
  `role_assign_tasks` varchar(20) NOT NULL DEFAULT 'no' COMMENT 'yes|no',
  `role_set_project_permissions` varchar(20) NOT NULL DEFAULT 'no' COMMENT 'yes|no',
  `role_subscriptions` varchar(20) NOT NULL DEFAULT '0' COMMENT 'none (0) | view (1) | view-add-edit (2) | view-edit-add-delete (3)',
  `role_templates_projects` varchar(20) NOT NULL DEFAULT '1' COMMENT 'none (0) | view (1) | view-add-edit (2) | view-edit-add-delete (3)',
  `role_templates_contracts` varchar(20) NOT NULL DEFAULT '1' COMMENT 'none (0) | view (1) | view-add-edit (2) | view-edit-add-delete (3)',
  `role_templates_proposals` varchar(20) NOT NULL DEFAULT '1' COMMENT 'none (0) | view (1) | view-add-edit (2) | view-edit-add-delete (3)',
  `role_content_import` varchar(20) NOT NULL DEFAULT 'yes' COMMENT 'yes|no',
  `role_content_export` varchar(20) NOT NULL DEFAULT 'yes' COMMENT 'yes|no',
  `role_module_cs_affiliate` varchar(20) NOT NULL DEFAULT '3' COMMENT 'global',
  `role_homepage` varchar(100) NOT NULL DEFAULT 'dashboard',
  `role_messages` varchar(20) NOT NULL DEFAULT 'yes' COMMENT 'yes|no',
  `role_reports` varchar(20) NOT NULL DEFAULT 'no' COMMENT 'yes|no'
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='[do not truncate] [roles 1,2,3 required] [role 1 = admin] [role 2 = client] [role 3 = staff]' ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `roles`
--

INSERT INTO `roles` (`role_id`, `role_created`, `role_updated`, `role_system`, `role_type`, `role_name`, `role_clients`, `role_contacts`, `role_contracts`, `role_invoices`, `role_estimates`, `role_proposals`, `role_payments`, `role_items`, `role_tasks`, `role_tasks_scope`, `role_projects`, `role_projects_scope`, `role_projects_billing`, `role_leads`, `role_leads_scope`, `role_expenses`, `role_expenses_scope`, `role_timesheets`, `role_timesheets_scope`, `role_team`, `role_team_scope`, `role_tickets`, `role_knowledgebase`, `role_manage_knowledgebase_categories`, `role_assign_projects`, `role_assign_leads`, `role_assign_tasks`, `role_set_project_permissions`, `role_subscriptions`, `role_templates_projects`, `role_templates_contracts`, `role_templates_proposals`, `role_content_import`, `role_content_export`, `role_module_cs_affiliate`, `role_homepage`, `role_messages`, `role_reports`) VALUES
(1, '2018-09-07 14:49:41', '2018-09-07 14:49:41', 'yes', 'team', 'Administrator', 3, 4, 3, 3, 3, 4, 3, 3, 3, 'global', 3, 'global', '2', 3, 'global', 3, 'global', 3, 'global', 3, 'global', 3, 3, 'yes', 'yes', 'yes', 'yes', 'yes', '3', '3', '3', '3', 'yes', 'yes', '3', 'dashboard', 'yes', 'yes'),
(3, '2018-09-07 14:49:41', '2023-09-08 15:38:37', 'no', 'team', 'Staff', 1, 1, 0, 0, 0, 3, 0, 0, 3, 'own', 1, 'own', '0', 3, 'own', 3, 'own', 2, 'own', 1, 'global', 3, 1, 'no', 'no', 'no', 'no', 'no', '0', '1', '0', '1', 'yes', 'yes', '3', 'dashboard', 'yes', 'no'),
(2, '2018-09-07 14:49:41', '2018-09-07 14:49:41', 'yes', 'client', 'Client', 0, 3, 1, 1, 1, 0, 1, 0, 1, 'own', 1, 'own', '0', 0, 'own', 0, 'own', 1, 'own', 1, 'global', 2, 1, 'no', 'no', 'no', 'no', 'no', '1', '0', '0', '0', 'no', 'no', '3', 'dashboard', 'yes', 'no');

-- --------------------------------------------------------

--
-- Table structure for table `sessions`
--

CREATE TABLE `sessions` (
  `id` varchar(250) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` text DEFAULT NULL,
  `payload` text NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `last_activity` int(11) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='[truncate]' ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `sessions`
--

INSERT INTO `sessions` (`id`, `user_id`, `ip_address`, `user_agent`, `payload`, `created_at`, `updated_at`, `last_activity`) VALUES
('7sEg3hsP5XZhidMX3QGqAehA72wjBtvLTfYMiYmq', 1, '81.178.240.212', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/121.0.0.0 Safari/537.36', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoia0Z1alFtM0RFRUVBNjVveFRLcFRWYmo1WlpXdzRHUEx1cW1rcTJWZSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzU6Imh0dHBzOi8vbGFtdGFuc3N5c3RlbXMuY29tL3Byb2plY3RzIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319czo1MDoibG9naW5fd2ViXzU5YmEzNmFkZGMyYjJmOTQwMTU4MGYwMTRjN2Y1OGVhNGUzMDk4OWQiO2k6MTt9', NULL, NULL, 1708599953),
('0ecqtQXdkvCWofjzkTTVmBi426nHbOMjv7neJd5O', NULL, '34.122.147.229', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/117.0.5938.132 Safari/537.36', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoiSkYwMmIxNHNhRDZOYnpPTmN2MkJBTXBIeUpFS2MySGVWUnpWZ1hIQSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzI6Imh0dHBzOi8vbGFtdGFuc3N5c3RlbXMuY29tL2xvZ2luIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319czozOiJ1cmwiO2E6MTp7czo4OiJpbnRlbmRlZCI7czozMToiaHR0cHM6Ly9sYW10YW5zc3lzdGVtcy5jb20vaG9tZSI7fX0=', NULL, NULL, 1708720650),
('SUjx0Qqb2Dga0CRzEL2PWLsvgG7CPgjnyZvJEK4b', 1, '81.178.240.212', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/121.0.0.0 Safari/537.36', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoibEhnNXFiNm1DQmRld2tIM0hpR3VkejFNMzhoVm96RnJxZkVqS1k5MiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzI6Imh0dHBzOi8vbGFtdGFuc3N5c3RlbXMuY29tL2xlYWRzIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319czo1MDoibG9naW5fd2ViXzU5YmEzNmFkZGMyYjJmOTQwMTU4MGYwMTRjN2Y1OGVhNGUzMDk4OWQiO2k6MTt9', NULL, NULL, 1708799557),
('UlATWEP9KTA9FMXaSepfAGaTIK6Gljav7gnsSGh0', NULL, '43.134.89.111', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiczJPc1lRUVlDemJiOHZRVUIwYUtJcXFOUExZZ2VVN2podkZmM2tKdiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjY6Imh0dHBzOi8vbGFtdGFuc3N5c3RlbXMuY29tIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', NULL, NULL, 1708733983),
('SEGXuxShScyQgxxKV4dTwU81SPJ9BIUq6uc0vEBu', NULL, '43.134.89.111', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoiY1o2eXNma2JGbUM5VTFHYnNWMk51a0haSzh6VWhJSmJyUk52MmM2RCI7czozOiJ1cmwiO2E6MTp7czo4OiJpbnRlbmRlZCI7czozMToiaHR0cHM6Ly9sYW10YW5zc3lzdGVtcy5jb20vaG9tZSI7fXM6OToiX3ByZXZpb3VzIjthOjE6e3M6MzoidXJsIjtzOjMxOiJodHRwczovL2xhbXRhbnNzeXN0ZW1zLmNvbS9ob21lIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', NULL, NULL, 1708733985),
('RjVDbCke07m6tKdEsfx8kS7MYEDDI3nMRBqkTmo5', NULL, '54.82.22.35', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.81 Safari/537.36', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoiN3ZnN1FwZ25QaTZJOUpUTHVBS05HRDRBTUI5WTIybTJDNVB6YjN0OSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzI6Imh0dHBzOi8vbGFtdGFuc3N5c3RlbXMuY29tL2xvZ2luIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319czozOiJ1cmwiO2E6MTp7czo4OiJpbnRlbmRlZCI7czozMToiaHR0cHM6Ly9sYW10YW5zc3lzdGVtcy5jb20vaG9tZSI7fX0=', NULL, NULL, 1708742702),
('0e6DavYqOl2b9E9T3799fRgxJsb9DXv40CuB33Mc', NULL, '43.131.44.218', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoibXBNV3cwM3c3MWFHaDFieFRtRWY1YzU4TkRGSXAwdFI2bTJaWU5GUiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzY6Imh0dHBzOi8vd3d3LmxhbXRhbnNzeXN0ZW1zLmNvbS9sb2dpbiI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', NULL, NULL, 1708742469),
('jdR6B9N2wykW3zFRVyDqfYYzLxf2W4Dlof3AZ7YD', NULL, '43.131.44.218', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoibUVTZFFvZ094aTRZRHVMWXhkdWdQc1l0WkxlZTVrSGJkZ2tNWDZXdyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzA6Imh0dHBzOi8vd3d3LmxhbXRhbnNzeXN0ZW1zLmNvbSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', NULL, NULL, 1708742468),
('D8wXDSZAHmujcAAFH8j7uzskYvIZni9kZYgkHV5l', NULL, '43.131.44.218', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoibGFvZTlQdDJhTmhXYktsMFVFN1JaTTVTRlFyTnNLajBVZlJvNVNSayI7czozOiJ1cmwiO2E6MTp7czo4OiJpbnRlbmRlZCI7czozNToiaHR0cHM6Ly93d3cubGFtdGFuc3N5c3RlbXMuY29tL2hvbWUiO31zOjk6Il9wcmV2aW91cyI7YToxOntzOjM6InVybCI7czozNToiaHR0cHM6Ly93d3cubGFtdGFuc3N5c3RlbXMuY29tL2hvbWUiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', NULL, NULL, 1708742469),
('CWuKXF2zLNoiUQhICiO4u0jRaovG1PsOqKmedhAv', NULL, '43.134.89.111', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiQkloYTlHbnV1ck1uREh2UWd1bkhFU2plWjRvdG5GODZCZWQ1M2FOUSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzI6Imh0dHBzOi8vbGFtdGFuc3N5c3RlbXMuY29tL2xvZ2luIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', NULL, NULL, 1708733986),
('dXf3Al24IhNcjJ9J0zWx0SoZyurBUeIJ8G2w5okl', NULL, '51.89.211.248', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/51.0.2704.106 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiMWVyajd0bFdyVHZiRXdqbTNmcHlRR09UbXhOeW92MEtzNXVGQVRzUiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzI6Imh0dHBzOi8vbGFtdGFuc3N5c3RlbXMuY29tL2xvZ2luIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', NULL, NULL, 1708747345),
('5w7ygXgDF01aUGLTOZtHZo3TmBYHiJLogYAqxvZe', NULL, '51.89.211.248', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/51.0.2704.106 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiNTJESW5Ob251SnliUVNNU0ZTenZnaFVicndWOTB1SmV1UWRrT1lsNyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjY6Imh0dHBzOi8vbGFtdGFuc3N5c3RlbXMuY29tIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', NULL, NULL, 1708747345),
('yEAT7JywY6GXP6zWzxIYDjHgKuMPKiFQjY7wUEtf', NULL, '51.89.211.248', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/51.0.2704.106 Safari/537.36', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoidzZjNDVzQnhNNnBLa2Jham5wTlVvejJpc2dWcDlHQ1loVE9qbWZyNCI7czozOiJ1cmwiO2E6MTp7czo4OiJpbnRlbmRlZCI7czozMToiaHR0cHM6Ly9sYW10YW5zc3lzdGVtcy5jb20vaG9tZSI7fXM6OToiX3ByZXZpb3VzIjthOjE6e3M6MzoidXJsIjtzOjMxOiJodHRwczovL2xhbXRhbnNzeXN0ZW1zLmNvbS9ob21lIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', NULL, NULL, 1708747345),
('RH4oytpeYU8QGE78GYMkcWoMxhK8zPMokZ4Nkjxl', NULL, '2a02:4780:a:c0de::84', 'Go-http-client/2.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiaWFEeXljWmNOZVZvN3lpTFdiaVRZbm9GQjB3RjU5OWtXcnEyVmpHNiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzI6Imh0dHBzOi8vbGFtdGFuc3N5c3RlbXMuY29tL2xvZ2luIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', NULL, NULL, 1708747241),
('JFFR41uhI7fjRKD9HvnIOxoxJ656XOIlwjj46NnD', NULL, '2a02:4780:a:c0de::84', 'Go-http-client/2.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiTEVtZHpvU0Q3OE5CQ0I4dHV6ZlBOZmxjbm1OWlZza25iUFF2cGw4ZyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjY6Imh0dHBzOi8vbGFtdGFuc3N5c3RlbXMuY29tIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', NULL, NULL, 1708747241),
('nBwm92fnK3WOMvfc7d2BY77lbd9sUsfpSFWGEBZS', NULL, '2a02:4780:a:c0de::84', 'Go-http-client/2.0', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoiOFZSRnZtSjBNaThPMTczN0hYR3ZNRmVoQU56emJmeGYyT1B6Q2FUdiI7czozOiJ1cmwiO2E6MTp7czo4OiJpbnRlbmRlZCI7czozMToiaHR0cHM6Ly9sYW10YW5zc3lzdGVtcy5jb20vaG9tZSI7fXM6OToiX3ByZXZpb3VzIjthOjE6e3M6MzoidXJsIjtzOjMxOiJodHRwczovL2xhbXRhbnNzeXN0ZW1zLmNvbS9ob21lIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', NULL, NULL, 1708747241),
('VmJXpy31vq4GdcjidPDztuF8cF6UhVw8hIzvuURY', NULL, '50.114.104.106', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 12_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/114.0.0.0 Safari/537.36 Edg/114.0.1264.71', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoiYkQwdlRKQjgyUHA4TVltb2VhZVlBaWZkcHNWdXpEaTFpbDVwYk03QyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjY6Imh0dHBzOi8vbGFtdGFuc3N5c3RlbXMuY29tIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319czozOiJ1cmwiO2E6MTp7czo4OiJpbnRlbmRlZCI7czozMToiaHR0cHM6Ly9sYW10YW5zc3lzdGVtcy5jb20vaG9tZSI7fX0=', NULL, NULL, 1708754551),
('RzAtErOweNUytBhY6lHR0Vw85YTEMKAgBBfsBHmy', NULL, '43.153.216.189', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiSFRnOHdReFZ0N3FVS2lWUElKdDJxR0FIcmNkOGJoclhCYTd5V0psZiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzA6Imh0dHBzOi8vd3d3LmxhbXRhbnNzeXN0ZW1zLmNvbSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', NULL, NULL, 1708756772),
('HcLPMKGyBiAqfsacOJGYtyReZWeWRisISxJsubYO', NULL, '43.153.216.189', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoiUWhqclcwMjN2S250NzlIVDZQMm9UaWNPa3JIZzNRWTN2aFgyVEV0SCI7czozOiJ1cmwiO2E6MTp7czo4OiJpbnRlbmRlZCI7czozNToiaHR0cHM6Ly93d3cubGFtdGFuc3N5c3RlbXMuY29tL2hvbWUiO31zOjk6Il9wcmV2aW91cyI7YToxOntzOjM6InVybCI7czozNToiaHR0cHM6Ly93d3cubGFtdGFuc3N5c3RlbXMuY29tL2hvbWUiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', NULL, NULL, 1708756776),
('M3METw5KRZ9zBxyQIqB8Hx2serCgjf24xJTtSdh3', NULL, '43.153.216.189', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoianVRRVhDZDVxMzlXcFV5dWRxSTA5V2hHTGpwOFluRlFhSmNDQWJSTyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzY6Imh0dHBzOi8vd3d3LmxhbXRhbnNzeXN0ZW1zLmNvbS9sb2dpbiI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', NULL, NULL, 1708756778),
('YxOR9FxcXiHRxXiw3lCdx1ijfgRZd5nT63tnc5tX', NULL, '205.169.39.84', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/83.0.4103.61 Safari/537.36', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoiMExUNlZ3czBJTjZhSXVoeUprd3F4REZBdXRvUEtQanF1SEExbjF5SSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzI6Imh0dHBzOi8vbGFtdGFuc3N5c3RlbXMuY29tL2xvZ2luIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319czozOiJ1cmwiO2E6MTp7czo4OiJpbnRlbmRlZCI7czozMToiaHR0cHM6Ly9sYW10YW5zc3lzdGVtcy5jb20vaG9tZSI7fX0=', NULL, NULL, 1708559353),
('BJjuRK7WmxzvrjKGQZaOKTpjs9EbDqVV2BILdiLK', NULL, '49.51.206.130', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiaVFoYVRxRnZSR3NidXZZYVNCdlF2MHlpQlZYQkFTakttbmJUZm9zSiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzY6Imh0dHBzOi8vd3d3LmxhbXRhbnNzeXN0ZW1zLmNvbS9sb2dpbiI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', NULL, NULL, 1708568501),
('LSHUp6ldb38lWQSg75AIKI3P7U87ZONeaEqXdone', NULL, '49.51.206.130', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoiV1hsNjFlS1FQdHBxYkN3R3VlcHZPcG1kUm9tZXdzMFZrRXZlSElXTCI7czozOiJ1cmwiO2E6MTp7czo4OiJpbnRlbmRlZCI7czozNToiaHR0cHM6Ly93d3cubGFtdGFuc3N5c3RlbXMuY29tL2hvbWUiO31zOjk6Il9wcmV2aW91cyI7YToxOntzOjM6InVybCI7czozNToiaHR0cHM6Ly93d3cubGFtdGFuc3N5c3RlbXMuY29tL2hvbWUiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', NULL, NULL, 1708568500),
('n32CVC39SNgl5SmGR4vryrBnhoZ5trkh3CmqAk74', NULL, '49.51.206.130', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiWTlqdXpzMGRtaFJ2VUpTY3RrYndsaXZyRGhDWjk0RmhzQkV5d3RqSCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzA6Imh0dHBzOi8vd3d3LmxhbXRhbnNzeXN0ZW1zLmNvbSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', NULL, NULL, 1708568499),
('I75uZJddjbvqxoALVmn1UHd8MTQrjYe0PM790YSp', NULL, '67.220.86.160', 'Mozilla/5.0 (X11; Linux i686; rv:49.0) Gecko/20100101 Firefox/49.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoicndyRkN5Rk1RS0RHaVhUb2Z6dEg0Rk1Gb1VZbXBXVXZ1UUFXRXM5aCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzI6Imh0dHBzOi8vbGFtdGFuc3N5c3RlbXMuY29tL2xvZ2luIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', NULL, NULL, 1708553131),
('7s5tTrYuI60jhjoEyviiaMkefYvnAQ1fgXfCMZ2P', NULL, '43.133.77.230', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoiVmJRc2lUZjBwRVlSemFpQkdHQUpuUUV4ZEhZRlNiS3VvV3Nic290YyI7czozOiJ1cmwiO2E6MTp7czo4OiJpbnRlbmRlZCI7czozNToiaHR0cHM6Ly93d3cubGFtdGFuc3N5c3RlbXMuY29tL2hvbWUiO31zOjk6Il9wcmV2aW91cyI7YToxOntzOjM6InVybCI7czozNToiaHR0cHM6Ly93d3cubGFtdGFuc3N5c3RlbXMuY29tL2hvbWUiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', NULL, NULL, 1708787412),
('XOatDi0ks8niZl270jMK3McfKeGLIkNLZdaQjZOc', NULL, '43.133.77.230', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiTWpIdldZRjV5ajlwdVhmY3Nya1NxNEtoRGhSTGl6MjJHRUpVa293aiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzY6Imh0dHBzOi8vd3d3LmxhbXRhbnNzeXN0ZW1zLmNvbS9sb2dpbiI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', NULL, NULL, 1708787424),
('PKfXAecE6KS4wmi5oudznxDolO6g2LoQ08SYPvPf', 1, '2400:adc1:15d:1300:5528:ee76:39e0:8ed8', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/121.0.0.0 Safari/537.36', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoiejZwTkNlNnZkYjVPb2VaaHNiSVNSZkh6a3ZFeVRxUXlpclRHVHVwNiI7czo1MDoibG9naW5fd2ViXzU5YmEzNmFkZGMyYjJmOTQwMTU4MGYwMTRjN2Y1OGVhNGUzMDk4OWQiO2k6MTtzOjk6Il9wcmV2aW91cyI7YToxOntzOjM6InVybCI7czozMToiaHR0cHM6Ly9sYW10YW5zc3lzdGVtcy5jb20vaG9tZSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', NULL, NULL, 1708791698),
('kzoZYYcHFJebqVcnzODOV2j15CcbmAvtmOFq92ex', 1, '2400:adc1:15d:1300:5528:ee76:39e0:8ed8', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/121.0.0.0 Safari/537.36', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoiZ01SbERqWWRITmZtY29mVzM3RUZ6Sk9kRUxkekl6S1ZQaE5oOTRkZyI7czo1MDoibG9naW5fd2ViXzU5YmEzNmFkZGMyYjJmOTQwMTU4MGYwMTRjN2Y1OGVhNGUzMDk4OWQiO2k6MTtzOjk6Il9wcmV2aW91cyI7YToxOntzOjM6InVybCI7czoyNjoiaHR0cHM6Ly9sYW10YW5zc3lzdGVtcy5jb20iO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', NULL, NULL, 1708790921),
('JV1PwfRLTZhgaoZTIOrPSYWKxmYaHjNw7IRXav9k', NULL, '2400:adc1:15d:1300:c4bc:cb06:243b:59db', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoicExETkhwUGhPOEo5YXpSZ1BSYzc5aHhxeVlaMU1OMmR0b1pBSWZTdSI7czozOiJ1cmwiO2E6MTp7czo4OiJpbnRlbmRlZCI7czozMToiaHR0cHM6Ly9sYW10YW5zc3lzdGVtcy5jb20vaG9tZSI7fXM6OToiX3ByZXZpb3VzIjthOjE6e3M6MzoidXJsIjtzOjMyOiJodHRwczovL2xhbXRhbnNzeXN0ZW1zLmNvbS9sb2dpbiI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', NULL, NULL, 1708799070),
('MVJy59MWEqxhUbJqyc9uHnMsdNudXxxRDHhZFgbb', NULL, '2a00:6800:3:78a::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.114 Safari/537.36 Edg/91.0.864.54', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiRnRzY1J4NWN1azFBNmVJUjMybnZwY2Fob0ljODVNdmo4V0ExM21MMyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzI6Imh0dHBzOi8vbGFtdGFuc3N5c3RlbXMuY29tL2xvZ2luIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', NULL, NULL, 1708775943),
('hNgXLTehOywGVnB1DYHRnX8FcndhHWNeeil0GXZ3', NULL, '2a00:6800:3:78a::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.114 Safari/537.36 Edg/91.0.864.54', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiOXJab2xmTzRzNGVzMmRiaVpmR0ZPMmQyN2RqZmZuTGdMOWQyTmFhZyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjY6Imh0dHBzOi8vbGFtdGFuc3N5c3RlbXMuY29tIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', NULL, NULL, 1708775942),
('o87GSX2w2Wb77lwI58G0scPsMUaRsavvE2hWILRM', NULL, '2a00:6800:3:78a::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.114 Safari/537.36 Edg/91.0.864.54', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoiS2w2dERWek9BRVNWSEM0TkNKdHRaZjEzSTBxQUJuNDZtV1FaUTFkTyI7czozOiJ1cmwiO2E6MTp7czo4OiJpbnRlbmRlZCI7czozMToiaHR0cHM6Ly9sYW10YW5zc3lzdGVtcy5jb20vaG9tZSI7fXM6OToiX3ByZXZpb3VzIjthOjE6e3M6MzoidXJsIjtzOjMxOiJodHRwczovL2xhbXRhbnNzeXN0ZW1zLmNvbS9ob21lIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', NULL, NULL, 1708775943),
('2JHNS04hXIc1AiIuRQMDullaYQYO4OK4Df4H4NKI', NULL, '67.220.86.160', 'Opera/7.51 (Windows NT 5.1; U) [en]', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiYmtuQ1hSTk8zbHRHSVNERU5tOVBmQ01iRjY5eTJIQmo0R3Y2UXBJRyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjY6Imh0dHBzOi8vbGFtdGFuc3N5c3RlbXMuY29tIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', NULL, NULL, 1708782127),
('tHuiWzno7LAjShFpiWTD32zGxXcSghd3bPCRZp66', NULL, '67.220.86.160', 'Opera/7.51 (Windows NT 5.1; U) [en]', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoiNTBvak0zb3RZQ3NiMnNQTExPUjdTM09WcEdFSEYwUEdHaG9SeUFzRSI7czozOiJ1cmwiO2E6MTp7czo4OiJpbnRlbmRlZCI7czozMToiaHR0cHM6Ly9sYW10YW5zc3lzdGVtcy5jb20vaG9tZSI7fXM6OToiX3ByZXZpb3VzIjthOjE6e3M6MzoidXJsIjtzOjMxOiJodHRwczovL2xhbXRhbnNzeXN0ZW1zLmNvbS9ob21lIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', NULL, NULL, 1708782128),
('OZQA6J6pPqQT0co6VxTvkifPAkV6oPfibsLsr6gS', NULL, '67.220.86.160', 'Opera/7.51 (Windows NT 5.1; U) [en]', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiWkl0eEY1V09zeks3RWlCbDBiNnk4VFozWFRlMkZ1dWR4RXVhcmFGcSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzI6Imh0dHBzOi8vbGFtdGFuc3N5c3RlbXMuY29tL2xvZ2luIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', NULL, NULL, 1708782128),
('et6fnlnxTLV8pXAH19sMFRjiwaBaerAOYG6NlLwf', 1, '2400:adc1:15d:1300:5528:ee76:39e0:8ed8', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/121.0.0.0 Safari/537.36', 'YTo1OntzOjY6Il90b2tlbiI7czo0MDoiZlJ2QTA2ME5EMEtaOFpJT3N3aDFOQTNlY2NOSWpaV1JHZmpVQmF4UyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzI6Imh0dHBzOi8vbGFtdGFuc3N5c3RlbXMuY29tL2xlYWRzIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319czozOiJ1cmwiO2E6MTp7czo4OiJpbnRlbmRlZCI7czozMToiaHR0cHM6Ly9sYW10YW5zc3lzdGVtcy5jb20vaG9tZSI7fXM6NTA6ImxvZ2luX3dlYl81OWJhMzZhZGRjMmIyZjk0MDE1ODBmMDE0YzdmNThlYTRlMzA5ODlkIjtpOjE7fQ==', NULL, NULL, 1708792365),
('4WkKp47VFP9wWbIP6WmIUv0GseiM7yd9vBqijeU8', 1, '2400:adc1:15d:1300:c4bc:cb06:243b:59db', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoiY0I3TnFlMXo0WXZtM202RmJveGl0ejgyUG9BVHFpTUZ1MjVtelFuRSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzE6Imh0dHBzOi8vbGFtdGFuc3N5c3RlbXMuY29tL2hvbWUiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX1zOjUwOiJsb2dpbl93ZWJfNTliYTM2YWRkYzJiMmY5NDAxNTgwZjAxNGM3ZjU4ZWE0ZTMwOTg5ZCI7aToxO30=', NULL, NULL, 1708799580),
('LoB7doSBkom6vTcNQVBGEDzu1mkKjFV3JyxXi3VJ', NULL, '43.133.77.230', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoidjhOQXdlSHIxYkM0MWFZdEplZ2RiSUZiMEF3djZjc1E0dzl0SXZEcCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzA6Imh0dHBzOi8vd3d3LmxhbXRhbnNzeXN0ZW1zLmNvbSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', NULL, NULL, 1708787407),
('XcURRb7yK2rHEqUCDsVYeJchBmdIpEveRe07GFnb', NULL, '43.130.37.62', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiZ0ZPWEJKUEJHU25YV1pMQ1dYaEdkcVhxZmh1U3dMa09WVEtubDk4QSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjY6Imh0dHBzOi8vbGFtdGFuc3N5c3RlbXMuY29tIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', NULL, NULL, 1708798570),
('ffWwJLo5lBxrIvO33seycdtVTtSdNVWCPXluepBr', NULL, '43.130.37.62', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoidDM2TVpLb0xrU1FveTM5aEJHN1F0SFZSdjB0V0ZFRHVyNVdxdGpLUCI7czozOiJ1cmwiO2E6MTp7czo4OiJpbnRlbmRlZCI7czozMToiaHR0cHM6Ly9sYW10YW5zc3lzdGVtcy5jb20vaG9tZSI7fXM6OToiX3ByZXZpb3VzIjthOjE6e3M6MzoidXJsIjtzOjMxOiJodHRwczovL2xhbXRhbnNzeXN0ZW1zLmNvbS9ob21lIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', NULL, NULL, 1708798573),
('x1B8l53Tz4PcXjn9GL9TSWkxrC3StFtsAqWHHTEP', NULL, '139.59.93.79', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/108.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiVWpISlk1RnFmdUszN0VWU2lKcjVndGJ0c3B5ZGJLQm1ZU2tvNEE1aCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzA6Imh0dHBzOi8vd3d3LmxhbXRhbnNzeXN0ZW1zLmNvbSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', NULL, NULL, 1708542417),
('Yz5bIKt5tl5jAPDt3Laf4T4dsOUR1uDztU9Gb5Pg', NULL, '67.220.86.160', 'Mozilla/5.0 (X11; Linux i686; rv:49.0) Gecko/20100101 Firefox/49.0', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoiRTdLTFM4WmY5QTJwVlUwNVdwdHFWV3Z6SEk3WWdEVjJ0T0NoaEJBRiI7czozOiJ1cmwiO2E6MTp7czo4OiJpbnRlbmRlZCI7czozMToiaHR0cHM6Ly9sYW10YW5zc3lzdGVtcy5jb20vaG9tZSI7fXM6OToiX3ByZXZpb3VzIjthOjE6e3M6MzoidXJsIjtzOjMxOiJodHRwczovL2xhbXRhbnNzeXN0ZW1zLmNvbS9ob21lIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', NULL, NULL, 1708553131),
('N6KDD6ucQOI5nK8yxOiUmMXaEakJEOUSmXNiHMEi', NULL, '66.249.66.37', 'Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoibzZzRnRSMnNGemVlSVdJYWlwek5TZ0psOVMwZXoxeTFGYmpoU3FPTiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzI6Imh0dHBzOi8vbGFtdGFuc3N5c3RlbXMuY29tL2xvZ2luIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', NULL, NULL, 1708543225),
('mIyHCrxuVzKypWVseNWPDNnf26FyiUQR1wcnkkSR', NULL, '66.249.66.38', 'Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/121.0.6167.139 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoidUllZmN0NXJmSnY3RWNKOXFOMFpndFc5Mzk5NUlzUTdzQlVOZXhLRiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzI6Imh0dHBzOi8vbGFtdGFuc3N5c3RlbXMuY29tL2xvZ2luIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', NULL, NULL, 1708543215),
('qISqpHMLKoKdhW6jHPvnDQ5UvoKSeAsrQiF0sVlL', NULL, '67.220.86.160', 'Mozilla/5.0 (X11; Linux i686; rv:49.0) Gecko/20100101 Firefox/49.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiZktGRnVOZXpGS0Vta0JnQk9kZnRBWUlSY29kZllBTzd5QVh5d1RLayI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjY6Imh0dHBzOi8vbGFtdGFuc3N5c3RlbXMuY29tIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', NULL, NULL, 1708553130),
('VlnsPsPAGfyb0GgC1l0rPh2glH3E4jewte415JCC', NULL, '43.133.72.69', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiMjhVZnZ1bzk4WEhtNU50dVBlMlZidEhMcjRjWXF3NTE2QkN2ZDNGSyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzI6Imh0dHBzOi8vbGFtdGFuc3N5c3RlbXMuY29tL2xvZ2luIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', NULL, NULL, 1708549427),
('5J9re68WeCa67dfPlu90Wp8Kv4WDhn6XVK2ajAAY', NULL, '43.133.72.69', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoibmxxaUtMQ1B6TjY5ZWRvN0t3cnhaNWlUTkFkWnEzdUZIZGVVYW9JSSI7czozOiJ1cmwiO2E6MTp7czo4OiJpbnRlbmRlZCI7czozMToiaHR0cHM6Ly9sYW10YW5zc3lzdGVtcy5jb20vaG9tZSI7fXM6OToiX3ByZXZpb3VzIjthOjE6e3M6MzoidXJsIjtzOjMxOiJodHRwczovL2xhbXRhbnNzeXN0ZW1zLmNvbS9ob21lIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', NULL, NULL, 1708549424),
('XXoPgvFIztpJQ8Gty3i7D0vm5dlC9pT7oKsPjbUy', NULL, '43.133.72.69', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiNnB6Z0U2YUlQNmFRRG9oY2tuOUFVaWNyWGlqYjFTMDJmNk1sTlk3dCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjY6Imh0dHBzOi8vbGFtdGFuc3N5c3RlbXMuY29tIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', NULL, NULL, 1708549420),
('yKKTCr0OKNdOjVg6eohxYBMUm3BWOZGxXuxiu2j5', NULL, '51.77.112.6', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/51.0.2704.106 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiSjJ5QktBS1hoRUpHR0lIeHU5dkNaTUVMUVM4Q1JFZXplaDNwMDFGYiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzI6Imh0dHBzOi8vbGFtdGFuc3N5c3RlbXMuY29tL2xvZ2luIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', NULL, NULL, 1708551107),
('uhVD58UCwp1DoUKqKDEdmfFFz8pgOxgCHTgqDaFP', NULL, '51.77.112.6', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/51.0.2704.106 Safari/537.36', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoielliN3czaFBNVEwwa0JsREw1T3ZaV2tKbGhjbXRIMHhXMDI4bUNtZCI7czozOiJ1cmwiO2E6MTp7czo4OiJpbnRlbmRlZCI7czozMToiaHR0cHM6Ly9sYW10YW5zc3lzdGVtcy5jb20vaG9tZSI7fXM6OToiX3ByZXZpb3VzIjthOjE6e3M6MzoidXJsIjtzOjMxOiJodHRwczovL2xhbXRhbnNzeXN0ZW1zLmNvbS9ob21lIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', NULL, NULL, 1708551107),
('u6Syo245SluvMmcS6WsslSiXju8XcLy9jK4Yq2YQ', NULL, '51.77.112.6', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/51.0.2704.106 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiaDRPNWRSblp2M3FnQWMza1lSQ1c2RktXQVhZT09IeE1ITkw3SVFtMyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjY6Imh0dHBzOi8vbGFtdGFuc3N5c3RlbXMuY29tIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', NULL, NULL, 1708551107),
('oGG9BzXrBXgXoZXQL2MlQRfNr7PmRaOO3XyHArnU', NULL, '111.7.100.21', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/92.0.4515.107 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiTGdsOXFOOGFxQ0VyWDZPcDhpMzZhbTFJSW5hbWFweTNhSFBLSHZ6ZSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzI6Imh0dHBzOi8vbGFtdGFuc3N5c3RlbXMuY29tL2xvZ2luIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', NULL, NULL, 1708567929),
('sS5qCIjPcCVVsyOhw4HiJPtyNPrr07FScpJ32bBd', NULL, '65.154.226.167', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/117.0.5938.132 Safari/537.36', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoiMzNEZ1JiQ1RoeFNsbVp4WFRzaGV0T0hRb1g0RTBWTjRkUTlMb1RqRiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzI6Imh0dHBzOi8vbGFtdGFuc3N5c3RlbXMuY29tL2xvZ2luIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319czozOiJ1cmwiO2E6MTp7czo4OiJpbnRlbmRlZCI7czozMToiaHR0cHM6Ly9sYW10YW5zc3lzdGVtcy5jb20vaG9tZSI7fX0=', NULL, NULL, 1708559466),
('1fQjItsX8iMK0gFCoOTjFrYuFZtlhabtmL4YJafo', NULL, '205.169.39.84', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.79 Safari/537.36', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoiYXRRQWlIV0ozVjVuT1Y2eHNFQnExVTVCV3I4c2VvWTJ0RFhUSGo5bSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzI6Imh0dHBzOi8vbGFtdGFuc3N5c3RlbXMuY29tL2xvZ2luIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319czozOiJ1cmwiO2E6MTp7czo4OiJpbnRlbmRlZCI7czozMToiaHR0cHM6Ly9sYW10YW5zc3lzdGVtcy5jb20vaG9tZSI7fX0=', NULL, NULL, 1708559373),
('WeV8bUH5SY6PeorsPeN4sjAwgPurHQxidFxNM4lx', NULL, '111.7.100.20', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/92.0.4515.107 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiSFp4ZXlZWkNvckpNdXVYckxqck9zSGN2ajhXejV6R2NEU3FGT2w3SiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjY6Imh0dHBzOi8vbGFtdGFuc3N5c3RlbXMuY29tIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', NULL, NULL, 1708567922),
('BGHsk0BmFsC1XkzNBA0p16HKA0QCv5XMaE9QqLGX', NULL, '111.7.100.23', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/92.0.4515.107 Safari/537.36', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoiZ1BReFNuRW1qOHJlRVZ1TXFtRzJCbEtaNVRzbG5TUHhCR3p6aU94VyI7czozOiJ1cmwiO2E6MTp7czo4OiJpbnRlbmRlZCI7czozMToiaHR0cHM6Ly9sYW10YW5zc3lzdGVtcy5jb20vaG9tZSI7fXM6OToiX3ByZXZpb3VzIjthOjE6e3M6MzoidXJsIjtzOjMxOiJodHRwczovL2xhbXRhbnNzeXN0ZW1zLmNvbS9ob21lIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', NULL, NULL, 1708567926),
('AvgqNuBDXzWz6ePGBS2DIzijcmZysQdvvosQgmCo', NULL, '111.7.100.21', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/92.0.4515.107 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiUFJWdHVsMm9ZQlZZWXNJVG05VlRMR3FPRWNzMDhUdGFxSWtBblhQdiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjY6Imh0dHBzOi8vbGFtdGFuc3N5c3RlbXMuY29tIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', NULL, NULL, 1708567914),
('lIUqnrpnUEF49kmkwLnjYfW2vWIdbtn7PQSfwufR', NULL, '2a02:4780:a:c0de::84', 'Go-http-client/2.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiTW5wTHNSaFpjb081dElkbjRFeWpDcXhxWVVKME9iRndQcjV3S3BJdSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzI6Imh0dHBzOi8vbGFtdGFuc3N5c3RlbXMuY29tL2xvZ2luIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', NULL, NULL, 1708574439),
('5dXbW2dROpEQFyURqUMLu3j5zGJRTFQwN4n7Gzmo', NULL, '2a02:4780:a:c0de::84', 'Go-http-client/2.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiY3F2eEk5S1o4SHFzdmhjY3RQeUlLbDRhUFhBQWh6ZExoNG1YckcwViI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjY6Imh0dHBzOi8vbGFtdGFuc3N5c3RlbXMuY29tIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', NULL, NULL, 1708574439),
('LeliEpVqcZnEGrnACQ6yFrFzStDiLAGf4YwSuepQ', NULL, '2a02:4780:a:c0de::84', 'Go-http-client/2.0', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoibkJNTlZ3UXNQTWFkOFVzb3lMY21zcHQ1MTBSam14NFdjSzhhSENRRCI7czozOiJ1cmwiO2E6MTp7czo4OiJpbnRlbmRlZCI7czozMToiaHR0cHM6Ly9sYW10YW5zc3lzdGVtcy5jb20vaG9tZSI7fXM6OToiX3ByZXZpb3VzIjthOjE6e3M6MzoidXJsIjtzOjMxOiJodHRwczovL2xhbXRhbnNzeXN0ZW1zLmNvbS9ob21lIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', NULL, NULL, 1708574439),
('k4tEpQAse274hnED4x21Ar0rYoRgAiVSMRuJPsYA', NULL, '87.98.153.11', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/51.0.2704.106 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiaFVwQlIxbkpkdElSdGZPUndpRDdhTFZDTFBwMnB3RmlPRjFHaW95RCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzI6Imh0dHBzOi8vbGFtdGFuc3N5c3RlbXMuY29tL2xvZ2luIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', NULL, NULL, 1708574281),
('Juj1JryOyTwny8wn6iiYHCDMWRMXL1q65PQ14t4L', NULL, '87.98.153.11', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/51.0.2704.106 Safari/537.36', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoieUlHdzA4Tkx1a3pIVTltb0c1dWk2R1Nac0NXZ0oyZllpbHRJT0NQWCI7czozOiJ1cmwiO2E6MTp7czo4OiJpbnRlbmRlZCI7czozMToiaHR0cHM6Ly9sYW10YW5zc3lzdGVtcy5jb20vaG9tZSI7fXM6OToiX3ByZXZpb3VzIjthOjE6e3M6MzoidXJsIjtzOjMxOiJodHRwczovL2xhbXRhbnNzeXN0ZW1zLmNvbS9ob21lIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', NULL, NULL, 1708574281),
('a2NpHje9nd61PUWUgrWVXRIg6WxhP6ZSiDvJ7H9g', NULL, '87.98.153.11', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/51.0.2704.106 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiU1dQQlFGTDdBSjkyaEtWS1FqbWlucUI0RVVSSEJ3SThpOVQ2S1kzNiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjY6Imh0dHBzOi8vbGFtdGFuc3N5c3RlbXMuY29tIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', NULL, NULL, 1708574281),
('ayFEANONkOw6dFC2asoGfIHeuJTGkgY6sGHXf1F8', NULL, '91.92.241.173', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5X Build/MDB08L) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/53.0.2785.124 Mobile Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiMlhPZGlodU03aUN5Um8yYUpKVlNEWDBJbmF3VW1oekJIbFN3cndIYiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjY6Imh0dHBzOi8vbGFtdGFuc3N5c3RlbXMuY29tIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', NULL, NULL, 1708576619),
('zeKYft0jZ6gUz5pKxH3tWJ7t0Bjno9iWhIpGWeQ3', NULL, '34.242.104.135', 'Pandalytics/1.0 (https://domainsbot.com/pandalytics/)', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoiTVNZRk5GOFBsSlFJbnZjcnRFeXBpTVhvT1VlQVVCWDRMb1RrZ21BMSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzI6Imh0dHBzOi8vbGFtdGFuc3N5c3RlbXMuY29tL2xvZ2luIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319czozOiJ1cmwiO2E6MTp7czo4OiJpbnRlbmRlZCI7czozMToiaHR0cHM6Ly9sYW10YW5zc3lzdGVtcy5jb20vaG9tZSI7fX0=', NULL, NULL, 1708605167),
('6vRYrk3PX2dioRXMbtIyAwKe2uhoKubivjPxETdT', NULL, '52.81.187.72', 'Mozilla/5.0 (Windows NT 9_1_1; Win64; x64) AppleWebKit/548.38 (KHTML, like Gecko) Chrome/107.0.265 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiajNnTjJwbnhMYWNja3ByeHVNWkVEOVhHRGQyTzNSZGhiTWhYZnBLcSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjY6Imh0dHBzOi8vbGFtdGFuc3N5c3RlbXMuY29tIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', NULL, NULL, 1708583838),
('xcwDqnw4S8Ccdohd9AlnyG32DPqGMfW342NB1cPh', NULL, '52.81.187.72', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 9_1) AppleWebKit/545.39 (KHTML, like Gecko) Chrome/57.0.2167 Safari/537.36', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoiRXpJQXNIVWdrb3BMRTcyTzd4cElLcXJYWlM3MW5Vc3N2UVFxQ1BKZyI7czozOiJ1cmwiO2E6MTp7czo4OiJpbnRlbmRlZCI7czozMToiaHR0cHM6Ly9sYW10YW5zc3lzdGVtcy5jb20vaG9tZSI7fXM6OToiX3ByZXZpb3VzIjthOjE6e3M6MzoidXJsIjtzOjMxOiJodHRwczovL2xhbXRhbnNzeXN0ZW1zLmNvbS9ob21lIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', NULL, NULL, 1708583847),
('dA0Bj3rUJoiFFZ5rudBwXeS6GvEq9xd3zeiyF00i', NULL, '193.34.73.125', 'Apache-HttpClient/5.1.4 (Java/11.0.18)', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoidXFLTmZ1VmNOWWdNeDFFWm0xRHhuV0d6d3NaSXlmc0oxQ25kUzhPWCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjY6Imh0dHBzOi8vbGFtdGFuc3N5c3RlbXMuY29tIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', NULL, NULL, 1708588524),
('EyYT76VU4TkrSaSjSCGW5tie7uxHjTtlKKRlH6tT', NULL, '209.127.110.138', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/107.0.0.0 Safari/537.36', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoidEVoQXdyZUlUWWJOem9VVzhSaTdZcGFoS2lKTkN4a0lDN0FYMElGZyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzI6Imh0dHBzOi8vbGFtdGFuc3N5c3RlbXMuY29tL2xvZ2luIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319czozOiJ1cmwiO2E6MTp7czo4OiJpbnRlbmRlZCI7czozMToiaHR0cHM6Ly9sYW10YW5zc3lzdGVtcy5jb20vaG9tZSI7fX0=', NULL, NULL, 1708588530),
('pUEQPZKBZyGGS06GEhaN5f0nrooyLaAZdRkEd3FB', NULL, '18.237.6.13', 'Mozilla/5.0 (Linux; Android 13; SM-A037U) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Mobile Safari/537.36', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoiTVN0R3JSMWZ5SGQ1TGFTTWxOeWVPeDFOWUhlUTRxM2VmVWxZeTVhQiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzI6Imh0dHBzOi8vbGFtdGFuc3N5c3RlbXMuY29tL2xvZ2luIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319czozOiJ1cmwiO2E6MTp7czo4OiJpbnRlbmRlZCI7czozMToiaHR0cHM6Ly9sYW10YW5zc3lzdGVtcy5jb20vaG9tZSI7fX0=', NULL, NULL, 1708604275),
('cBXCZsjr5JxxzmALfAkn7zRe2CyoHY8VYjN2T9Vv', NULL, '34.221.156.254', 'Mozilla/5.0 (Linux; Android 13; SM-A037U) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Mobile Safari/537.36', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoiMTdFNnNqTnVnZjk4NGNvVWdCU3ltQW1LNlRmRTVRV0JpYWR0WXRCdCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzI6Imh0dHBzOi8vbGFtdGFuc3N5c3RlbXMuY29tL2xvZ2luIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319czozOiJ1cmwiO2E6MTp7czo4OiJpbnRlbmRlZCI7czozMToiaHR0cHM6Ly9sYW10YW5zc3lzdGVtcy5jb20vaG9tZSI7fX0=', NULL, NULL, 1708604272),
('w9tTpMjGH74rQYfNLo9G5qxzw8gtAqwv8TkrQ9d4', NULL, '35.86.86.190', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/76.0.3809.100 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiSWVZblJjZEU4Tlg2MG80QWgwd2FpOFNuMk9PNll5RUMzM0ZYZFFLNCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzI6Imh0dHBzOi8vbGFtdGFuc3N5c3RlbXMuY29tL2xvZ2luIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', NULL, NULL, 1708604173),
('B8tg7Usc3szcNyZw94fBVTFJGTvvwQ0oQGG8AbG4', NULL, '35.86.86.190', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/76.0.3809.100 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiWVRseWpVdm05c25UZkpKSHdydTZ6WVBKRFZJeEVHb1lEb29kRWRQViI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzI6Imh0dHBzOi8vbGFtdGFuc3N5c3RlbXMuY29tL2xvZ2luIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', NULL, NULL, 1708604173),
('Si976vS2QvL9riGHyvXeUB1MEwGnZEGUrIHuUgyF', NULL, '35.86.86.190', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/76.0.3809.100 Safari/537.36', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoiUTZIcEJ5WUFqRkpObW1OSEdhMnFlbFRHMGxucThpUjVvck1Id21mTiI7czozOiJ1cmwiO2E6MTp7czo4OiJpbnRlbmRlZCI7czozMToiaHR0cHM6Ly9sYW10YW5zc3lzdGVtcy5jb20vaG9tZSI7fXM6OToiX3ByZXZpb3VzIjthOjE6e3M6MzoidXJsIjtzOjMxOiJodHRwczovL2xhbXRhbnNzeXN0ZW1zLmNvbS9ob21lIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', NULL, NULL, 1708604173),
('dtEke7JrX2uroQlsQALpF2rOUgdX9ozRe7m4FETe', NULL, '35.86.86.190', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/76.0.3809.100 Safari/537.36', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoiZkJnaFZSSVpoaTA0QU5md3BhQTR6blJxVEt0bEhkMHJSRUFOYTA2VCI7czozOiJ1cmwiO2E6MTp7czo4OiJpbnRlbmRlZCI7czozMToiaHR0cHM6Ly9sYW10YW5zc3lzdGVtcy5jb20vaG9tZSI7fXM6OToiX3ByZXZpb3VzIjthOjE6e3M6MzoidXJsIjtzOjMxOiJodHRwczovL2xhbXRhbnNzeXN0ZW1zLmNvbS9ob21lIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', NULL, NULL, 1708604172),
('t5855Vc5lF61xSrgSF9GpTEQsYV6TIllg73JDPSo', NULL, '35.86.86.190', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/76.0.3809.100 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiMWhCaWlNaVZZZDB2ZmJYcEltMTBIcjNKRW9Mb20zRUI3UXo2eGVOSyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzI6Imh0dHBzOi8vbGFtdGFuc3N5c3RlbXMuY29tL2xvZ2luIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', NULL, NULL, 1708604172),
('zTDdauFdvKWjZr1j6KH78Eo1MjWnl1KbJyMyR3Px', NULL, '35.86.86.190', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/76.0.3809.100 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiN2tHaVgzd2p6dk5JSFJ5MEphZFpmQXgzSDhjdFltYk92a3ZSak1aZSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjY6Imh0dHBzOi8vbGFtdGFuc3N5c3RlbXMuY29tIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', NULL, NULL, 1708604172),
('usRYhAyjzShafch6azkxZNY2EMGssjlFcwHlmTUG', NULL, '35.86.86.190', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/76.0.3809.100 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiZ0gwUlJGTWQ0eFZRWmdzcFpjRHYxelB3Rm54OUFJZEozOEFKMU5EMSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjY6Imh0dHBzOi8vbGFtdGFuc3N5c3RlbXMuY29tIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', NULL, NULL, 1708604172),
('BfqdC3cFuCHJAzhDp0ApVyviNNjQFTka7vv1SH8P', NULL, '35.86.86.190', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/76.0.3809.100 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiblIxYUhyRjFIbWhTOExFN0g5MVoxbkRtc200Y1dUSnZJN0czcVFROSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjY6Imh0dHBzOi8vbGFtdGFuc3N5c3RlbXMuY29tIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', NULL, NULL, 1708604171),
('tXJVk8VSEDbzwhLTqgOTMwgYvUO84P9uH3kwqc3g', NULL, '35.86.86.190', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/76.0.3809.100 Safari/537.36', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoiODM3VWczd3FBbzloalhmNHU5Uzk4RWhndks2Rzc2WlFyYjdMa3ROSiI7czozOiJ1cmwiO2E6MTp7czo4OiJpbnRlbmRlZCI7czozMToiaHR0cHM6Ly9sYW10YW5zc3lzdGVtcy5jb20vaG9tZSI7fXM6OToiX3ByZXZpb3VzIjthOjE6e3M6MzoidXJsIjtzOjMxOiJodHRwczovL2xhbXRhbnNzeXN0ZW1zLmNvbS9ob21lIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', NULL, NULL, 1708604172),
('9HtfSiuU0D1D8BnWJjNPaSeXQHjSLCy6eX5DEOKG', NULL, '2001:bc8:1201:1d:ba2a:72ff:fee1:1d32', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/112.0.0.0 Safari/537.36', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoiSXp1NFcyTmJkeGJBTHZ4cnRkWm93djlXVG0yQTg3UkZPNEpyb1RPUyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzI6Imh0dHBzOi8vbGFtdGFuc3N5c3RlbXMuY29tL2xvZ2luIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319czozOiJ1cmwiO2E6MTp7czo4OiJpbnRlbmRlZCI7czozMToiaHR0cHM6Ly9sYW10YW5zc3lzdGVtcy5jb20vaG9tZSI7fX0=', NULL, NULL, 1708612331),
('kIa0uAQcJt66xcit9cbWCkYXLfooCyv8Ykw1RAnq', NULL, '51.89.211.248', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/51.0.2704.106 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoicjVVSGdvMWpMc2EzdUNlSWl0YnVRUmpCTTVTWHpyVkNaVHBtZjVNeiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzI6Imh0dHBzOi8vbGFtdGFuc3N5c3RlbXMuY29tL2xvZ2luIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', NULL, NULL, 1708628498),
('OlZbjXUEWmJCc5e1H4n6p6gFThWSaVD6U1MddDL7', NULL, '51.89.211.248', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/51.0.2704.106 Safari/537.36', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoic1BaRDY3dndlYTBJRkt1VkxEV3JCWmF3ZFRmWHJNQUhqVlVOZnFwayI7czozOiJ1cmwiO2E6MTp7czo4OiJpbnRlbmRlZCI7czozMToiaHR0cHM6Ly9sYW10YW5zc3lzdGVtcy5jb20vaG9tZSI7fXM6OToiX3ByZXZpb3VzIjthOjE6e3M6MzoidXJsIjtzOjMxOiJodHRwczovL2xhbXRhbnNzeXN0ZW1zLmNvbS9ob21lIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', NULL, NULL, 1708628498),
('QwcPENN9CPQi4e7fwNN0zKv4lmGs5KG5Lk7ilS7g', NULL, '51.89.211.248', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/51.0.2704.106 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiTUJib0FLNXRJMldKV0NKYmNYUnFoOUZ0eEk0elh5dUJNQ0V4UnFSTyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjY6Imh0dHBzOi8vbGFtdGFuc3N5c3RlbXMuY29tIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', NULL, NULL, 1708628498),
('CIH3nuU04bJ17cqsx4VOvpIGcJKDasPQSDDJDi3y', NULL, '16.170.245.127', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/117.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiYU9pMUQ4bEhTT2xkZG9RenAwaUJmUU5SbklQQjdmbDZ2RXlqZFRROSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzI6Imh0dHBzOi8vbGFtdGFuc3N5c3RlbXMuY29tL2xvZ2luIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', NULL, NULL, 1708627535),
('1NEA9yRqPkGntoYb9xAUQ4iFeq2nPtqssNmYQlnL', NULL, '16.170.245.127', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/117.0.0.0 Safari/537.36', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoidnhxQmZ2eDI3blRCT2lUU0F6NzA0M1NjWGZ1TTFSa1YydFFzN0RqSSI7czozOiJ1cmwiO2E6MTp7czo4OiJpbnRlbmRlZCI7czozMToiaHR0cHM6Ly9sYW10YW5zc3lzdGVtcy5jb20vaG9tZSI7fXM6OToiX3ByZXZpb3VzIjthOjE6e3M6MzoidXJsIjtzOjMxOiJodHRwczovL2xhbXRhbnNzeXN0ZW1zLmNvbS9ob21lIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', NULL, NULL, 1708627535),
('prBOg5iJJg2HgPlZ4xPdJKf0bx0k8iYFEsSlGeLf', NULL, '16.170.245.127', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/117.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiSXRUN3VhNWRKNHk4M2Nna1p6ZVVWb05RbDYwQVFHUFIzOHFYek1GViI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjY6Imh0dHBzOi8vbGFtdGFuc3N5c3RlbXMuY29tIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', NULL, NULL, 1708627535),
('immuvTBQzU73LTQPk5Qk9fWYzEwN8VnRHcKHUyMW', NULL, '43.159.63.75', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiaXg3TkpXenljbUY3RTZ4cEc1Z0dxMDkzaXZZQkRaUE1lUkRHVEJGYSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzI6Imh0dHBzOi8vbGFtdGFuc3N5c3RlbXMuY29tL2xvZ2luIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', NULL, NULL, 1708622856),
('UDZdLl7cAmlkdeXTdfxCe970QBHHlNOVIjpoHHFL', NULL, '43.159.63.75', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoiUjdQeVZZektjQmdHcE9ORDhFM0ZJYk9ZeVhIMGJ2eFFqV0NaQ1M0dyI7czozOiJ1cmwiO2E6MTp7czo4OiJpbnRlbmRlZCI7czozMToiaHR0cHM6Ly9sYW10YW5zc3lzdGVtcy5jb20vaG9tZSI7fXM6OToiX3ByZXZpb3VzIjthOjE6e3M6MzoidXJsIjtzOjMxOiJodHRwczovL2xhbXRhbnNzeXN0ZW1zLmNvbS9ob21lIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', NULL, NULL, 1708622853),
('JBvwJJQZrauegIzzaRWnHSnAsqygtPFBTYzbYn1e', NULL, '43.159.63.75', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiUnJXMUNtS0NVUWRwR2UzR1g5Nlo2b213dDlLb3M5WjdSdE1RWFFaUCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjY6Imh0dHBzOi8vbGFtdGFuc3N5c3RlbXMuY29tIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', NULL, NULL, 1708622849),
('DrT8wJV7bWLdZK6zmyHzXP1gEsAu1kbMzBXtgx9k', NULL, '221.180.143.13', 'Mozilla/5.0 (Linux; Android 10; SM-G981B) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.162 Mobile Safari/537.36', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoib0JRT2dBVG1MVGNETTRqOUVPeGdJakRWQ0g0Y0VSSndmU1F3RGlybyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzI6Imh0dHBzOi8vbGFtdGFuc3N5c3RlbXMuY29tL2xvZ2luIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319czozOiJ1cmwiO2E6MTp7czo4OiJpbnRlbmRlZCI7czozMToiaHR0cHM6Ly9sYW10YW5zc3lzdGVtcy5jb20vaG9tZSI7fX0=', NULL, NULL, 1708622478),
('vfdCDWqF1dBWfmymG0geMFW3ee6L72oKUHSEmKkW', NULL, '43.131.248.209', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiOEo1MWFwOGFiQjFsUDQ2ZlBYQ3lxSWJtcm0wVHVXMExqc1RNVjFKSSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzI6Imh0dHBzOi8vbGFtdGFuc3N5c3RlbXMuY29tL2xvZ2luIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', NULL, NULL, 1708625966),
('E1QAOvB3ss0GGs0LisaJIIBIWf9BR6jN46h0B8OL', NULL, '43.131.248.209', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoiT1dock1OVHZvQ2pvbkhHaFM2dHRkTTJnOGthYXptMzFIa2hjakdxRSI7czozOiJ1cmwiO2E6MTp7czo4OiJpbnRlbmRlZCI7czozMToiaHR0cHM6Ly9sYW10YW5zc3lzdGVtcy5jb20vaG9tZSI7fXM6OToiX3ByZXZpb3VzIjthOjE6e3M6MzoidXJsIjtzOjMxOiJodHRwczovL2xhbXRhbnNzeXN0ZW1zLmNvbS9ob21lIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', NULL, NULL, 1708625965),
('dOH59MWcTqXNCsmKfdwrMASTFpcCLNeSVsZMJX3D', NULL, '43.131.248.209', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoicTl1OERBc2pxbVgzcnZZSnBORzd1aG9QeUtuejUxM1ZlcFlCbUJrbSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjY6Imh0dHBzOi8vbGFtdGFuc3N5c3RlbXMuY29tIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', NULL, NULL, 1708625963),
('jFRAUIDaNZNMx3P3KgaxrUSg0lBeKNf79WsxSAmV', NULL, '161.35.173.40', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/108.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiUEg5aUdsRWRRY1Z4ZFdTM1VFRzBBTVc2bVBpYU42MlQ3NVNGd3lodSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjY6Imh0dHBzOi8vbGFtdGFuc3N5c3RlbXMuY29tIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', NULL, NULL, 1708632784),
('GPJ6XSqO3EGiEKjX6Gj6SBzJxheSTxzUXxiLP6Lm', NULL, '220.151.9.22', 'curl/7.76.1', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiMGhaWkh1dFF2ZXlhNk5KTkJDZWl6T2NlZ0R2M1VUNG9IZFk1akhvcCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzI6Imh0dHBzOi8vbGFtdGFuc3N5c3RlbXMuY29tL2xvZ2luIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', NULL, NULL, 1708632701),
('A2rHIGGiIkBex4XB87psFvSegkBh8pEf5iMk5rz5', NULL, '220.151.9.22', 'curl/7.76.1', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiMGw5N29DRXlCelZ6NFVxY09MRzBoR1NqVG81bjN5M2FEbEJXVzZ4cyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjY6Imh0dHBzOi8vbGFtdGFuc3N5c3RlbXMuY29tIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', NULL, NULL, 1708632700),
('EXfJdhmm2mglu2gm6dLYhMU3sYsavKruxNuRmmeG', NULL, '220.151.9.22', 'curl/7.76.1', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoia2NSRTM4Z2lmZ0JhMlhkM2RrNmFNWHJhMzFCOXVYekdidDF1WmdzTyI7czozOiJ1cmwiO2E6MTp7czo4OiJpbnRlbmRlZCI7czozMToiaHR0cHM6Ly9sYW10YW5zc3lzdGVtcy5jb20vaG9tZSI7fXM6OToiX3ByZXZpb3VzIjthOjE6e3M6MzoidXJsIjtzOjMxOiJodHRwczovL2xhbXRhbnNzeXN0ZW1zLmNvbS9ob21lIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', NULL, NULL, 1708632701);
INSERT INTO `sessions` (`id`, `user_id`, `ip_address`, `user_agent`, `payload`, `created_at`, `updated_at`, `last_activity`) VALUES
('y9TTAfQJ74wNLSujW2QOh0MyVNmTnHLJpHp3Ligd', NULL, '123.60.68.42', 'Mozilla/5.0 (Windows NT 10.9; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/77.0.2420.88 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoid242RVVnR0xKbXJPUTExT0ZtSnlFUXBsVDc0NXZPN3dYNnZQdDRLMSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzA6Imh0dHBzOi8vd3d3LmxhbXRhbnNzeXN0ZW1zLmNvbSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', NULL, NULL, 1708632132),
('JMbuxgqVkHPsLLjZNJYMDgHR1UGXtkf0QWhTs3qe', NULL, '66.249.65.43', 'Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/121.0.6167.139 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoiMTFRaHlLMTZJYjBjZEFHZmVJejVZWm1tVjFHMWc5aWwyanFpNmxzVyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzI6Imh0dHBzOi8vbGFtdGFuc3N5c3RlbXMuY29tL2xvZ2luIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319czozOiJ1cmwiO2E6MTp7czo4OiJpbnRlbmRlZCI7czozMToiaHR0cHM6Ly9sYW10YW5zc3lzdGVtcy5jb20vaG9tZSI7fX0=', NULL, NULL, 1708643318),
('ifr69Byf7GYphjycxnvYB34Fa93ZLnICKjU3y3Ta', NULL, '67.220.86.160', 'Mozilla/5.0 (Linux; Android 10; moto g(7) plus) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/101.0.4951.41 Mobile Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoicVN6ZEpXeGVMbVFCWXFTYkV1Wnd3QTNrTmlreE5ZZ01DamJ4SkpmNiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzI6Imh0dHBzOi8vbGFtdGFuc3N5c3RlbXMuY29tL2xvZ2luIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', NULL, NULL, 1708640089),
('owiqowvhQFpcISCjXe8k9qKOFTK9k8yK2mzNqVzT', NULL, '67.220.86.160', 'Mozilla/5.0 (Linux; Android 10; moto g(7) plus) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/101.0.4951.41 Mobile Safari/537.36', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoiMnE1QUtXZno3UmJBZTZtSDk5Mmp3eHlkMUtpb0JBSGpLNjVscGl4YSI7czozOiJ1cmwiO2E6MTp7czo4OiJpbnRlbmRlZCI7czozMToiaHR0cHM6Ly9sYW10YW5zc3lzdGVtcy5jb20vaG9tZSI7fXM6OToiX3ByZXZpb3VzIjthOjE6e3M6MzoidXJsIjtzOjMxOiJodHRwczovL2xhbXRhbnNzeXN0ZW1zLmNvbS9ob21lIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', NULL, NULL, 1708640089),
('liQXARIQUo5FQm6qBQLtgbc2pXOmO79tnEZjG625', NULL, '67.220.86.160', 'Mozilla/5.0 (Linux; Android 10; moto g(7) plus) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/101.0.4951.41 Mobile Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiYzdQTHBZTkM2ZnlBSWFxM21UaXhzbTVKV29iNUJSVWVHMmpIb0tseiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjY6Imh0dHBzOi8vbGFtdGFuc3N5c3RlbXMuY29tIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', NULL, NULL, 1708640088),
('u10896KjtpCqcF3eMnkIsQhq25lRjXfCLXIwE7sU', NULL, '194.104.146.27', 'Mozilla/5.0 (Linux; Android 8.0.0; SM-G955U Build/R16NW) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/87.0.4280.141 Mobile Safari/537.36', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoiTkxlTjY1eGtkWG5IY0lqSk1KNzlSYnFhVkJQTVY0clp3QnVkRFZzVCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzI6Imh0dHBzOi8vbGFtdGFuc3N5c3RlbXMuY29tL2xvZ2luIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319czozOiJ1cmwiO2E6MTp7czo4OiJpbnRlbmRlZCI7czozMToiaHR0cHM6Ly9sYW10YW5zc3lzdGVtcy5jb20vaG9tZSI7fX0=', NULL, NULL, 1708639900),
('koUTsFZCIdsViSIVEzaT0Jbc7W3d9UeGYwJPsdwU', NULL, '66.249.65.40', 'Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoiVXlFMFUwcmNqU1lOVXBEZ2piQ1dwT3J3T29tZnBWNmZ4cEo0c3hMYiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzI6Imh0dHBzOi8vbGFtdGFuc3N5c3RlbXMuY29tL2xvZ2luIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319czozOiJ1cmwiO2E6MTp7czo4OiJpbnRlbmRlZCI7czozMToiaHR0cHM6Ly9sYW10YW5zc3lzdGVtcy5jb20vaG9tZSI7fX0=', NULL, NULL, 1708639267),
('sboDOmIbMxqziWD2HZIZdRvvxl5JUz9E054tMEro', NULL, '124.225.164.130', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiZW5HVU5jbVF5aTUxMHNPY3loTzJHbGhhMHRmTTZSZGdpRGdMQktwYSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzI6Imh0dHBzOi8vbGFtdGFuc3N5c3RlbXMuY29tL2xvZ2luIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', NULL, NULL, 1708650731),
('yFrrvuWAXNLk2fwUN5tul60MCErYEHirq7FWKAhd', NULL, '124.225.164.130', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoiNklhbXdxMjFtMlFyRWpWcWFvZGd6QzRFaXQ3aUtDd0c1dWVKS1pSSCI7czozOiJ1cmwiO2E6MTp7czo4OiJpbnRlbmRlZCI7czozMToiaHR0cHM6Ly9sYW10YW5zc3lzdGVtcy5jb20vaG9tZSI7fXM6OToiX3ByZXZpb3VzIjthOjE6e3M6MzoidXJsIjtzOjMxOiJodHRwczovL2xhbXRhbnNzeXN0ZW1zLmNvbS9ob21lIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', NULL, NULL, 1708650728),
('rtsbl3yRAni5iPGdUoL1itZqcxfrN9YEETCjPz2N', NULL, '124.225.164.130', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiNHgyQzBIT2JRRmFvSU42Z2ZJenV6d3hrV1R3UE5qNDBDTmhXVmkyayI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjY6Imh0dHBzOi8vbGFtdGFuc3N5c3RlbXMuY29tIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', NULL, NULL, 1708650726),
('x0IhAEIdi4mTo973mMaPs15WzTupGV5fRzKgNbEc', NULL, '119.23.221.222', 'Mozilla/5.0 (iPhone; CPU iPhone OS 10_3 like Mac OS X) AppleWebKit/602.1.50 (KHTML, like Gecko) CriOS/56.0.2924.75 Mobile/14E5239e Safari/602.1', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoicHYySkpZUGxaTk1CVFI3dkdsV0sxQ2VpdUxzWlU5WVN4Wjd5TW81WCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzY6Imh0dHBzOi8vbGFtdGFuc3N5c3RlbXMuY29tL2luZGV4LnBocCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', NULL, NULL, 1708648896),
('h5q4t5ZhdvNPCjXAr1GZHQjuVwmo9arYFyUGnnsL', NULL, '49.7.227.204', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiWlVVc1N3VHB2TnF5Tk9Gc3ZFZVdnbThVOHVOM0p6REpOYlRWdG4zbiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzY6Imh0dHBzOi8vd3d3LmxhbXRhbnNzeXN0ZW1zLmNvbS9sb2dpbiI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', NULL, NULL, 1708683592),
('AKIciyfgmBlUQyozGIz4867cf5TOo0GkpYquwVDv', NULL, '49.7.227.204', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoicnd6b1o3aEFLdjNmWHFiSHFMWlBSU2JuM1VSVWtCNTBaRkQzNkRXaSI7czozOiJ1cmwiO2E6MTp7czo4OiJpbnRlbmRlZCI7czozNToiaHR0cHM6Ly93d3cubGFtdGFuc3N5c3RlbXMuY29tL2hvbWUiO31zOjk6Il9wcmV2aW91cyI7YToxOntzOjM6InVybCI7czozNToiaHR0cHM6Ly93d3cubGFtdGFuc3N5c3RlbXMuY29tL2hvbWUiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', NULL, NULL, 1708683576),
('t9c9tycwa2Pem8l4UO6kayKn8l1n2SEtvZs5A0kM', NULL, '49.7.227.204', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiaGlZWEV5bzlmaDJDNGNvem1nMTRBTVp2aURaaVJHSTFpZTVIdXBtQSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzA6Imh0dHBzOi8vd3d3LmxhbXRhbnNzeXN0ZW1zLmNvbSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', NULL, NULL, 1708683569),
('RrKjM0V4DF9F17YKSWXxxR1XThYZ5OOfeHCNM0aa', NULL, '2a02:4780:a:c0de::84', 'Go-http-client/2.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoicFNxbzlOM3FiSDlFZWpNWnhKTkdxcGJoaHpvblNFbldBUVVoZVZ2MiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzI6Imh0dHBzOi8vbGFtdGFuc3N5c3RlbXMuY29tL2xvZ2luIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', NULL, NULL, 1708660840),
('9eGp05Z7wi4uyISQe6yjkBnKdbfLTou7snzFBVse', NULL, '2a02:4780:a:c0de::84', 'Go-http-client/2.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiR01YOUk2aFJuQW8yZ3V4WTVyelNRM1FtemwwcUhtVUl3aU5waHEzViI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjY6Imh0dHBzOi8vbGFtdGFuc3N5c3RlbXMuY29tIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', NULL, NULL, 1708660840),
('aM8ujHgd2OCyh7VtW6HMdsylDe5tFJtKk70qtXCz', NULL, '2a02:4780:a:c0de::84', 'Go-http-client/2.0', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoicm84cldSVURSY25MR2FNOUYzZ3U0VFQ3TDhJaWFnYTBtRVhHYlQ3SCI7czozOiJ1cmwiO2E6MTp7czo4OiJpbnRlbmRlZCI7czozMToiaHR0cHM6Ly9sYW10YW5zc3lzdGVtcy5jb20vaG9tZSI7fXM6OToiX3ByZXZpb3VzIjthOjE6e3M6MzoidXJsIjtzOjMxOiJodHRwczovL2xhbXRhbnNzeXN0ZW1zLmNvbS9ob21lIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', NULL, NULL, 1708660840),
('jEjtJlMq2eWuiykhdNIVGLwxmlq60Yl3DUBGJYgA', NULL, '54.38.211.230', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/51.0.2704.106 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoicXlBQlNOY0lDOVVxbmx5bnM1aE9oanFMN2tpRDJ3WG4zTkZwUjZ6TSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzI6Imh0dHBzOi8vbGFtdGFuc3N5c3RlbXMuY29tL2xvZ2luIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', NULL, NULL, 1708683555),
('4Q6ag4NqP6U8ra8S8h6mTmqbZjwyc6oVoowiAHeF', NULL, '51.89.211.248', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/51.0.2704.106 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiR0lUWTFTclJHaW5uOFhMRnhmeWF2YXluZ1M1RzlZT1l4Q2dFV2ZyRiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzI6Imh0dHBzOi8vbGFtdGFuc3N5c3RlbXMuY29tL2xvZ2luIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', NULL, NULL, 1708665212),
('irXJiB2kjpKK88HDacMMV9CpJlms9zFQSAWtNhxu', NULL, '51.89.211.248', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/51.0.2704.106 Safari/537.36', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoiVnBhcGNhM3JaQ0FWSEJqUGJxZTlDNlBlNFdrVnkyT1hXbFZVa2xOdyI7czozOiJ1cmwiO2E6MTp7czo4OiJpbnRlbmRlZCI7czozMToiaHR0cHM6Ly9sYW10YW5zc3lzdGVtcy5jb20vaG9tZSI7fXM6OToiX3ByZXZpb3VzIjthOjE6e3M6MzoidXJsIjtzOjMxOiJodHRwczovL2xhbXRhbnNzeXN0ZW1zLmNvbS9ob21lIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', NULL, NULL, 1708665212),
('TAziLIc0KlZsYVSPaT00HkX6Kg6ysZFBJZTUJDrc', NULL, '51.89.211.248', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/51.0.2704.106 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiN0VzNGtkSEQxSE1mbE9GNWdXVnlDRG5uS0JHUkNVU3VaTjlQNnFsdCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjY6Imh0dHBzOi8vbGFtdGFuc3N5c3RlbXMuY29tIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', NULL, NULL, 1708665212),
('osTTF6j5hkS5hSov48CSNSpXX4yIVnIV40zpvu1J', NULL, '54.38.211.230', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/51.0.2704.106 Safari/537.36', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoiWDlaSWdma29JcVZnVlVQYVgyZXJ0cGMwWlY1aDN3NjBTOEpMRkdTSyI7czozOiJ1cmwiO2E6MTp7czo4OiJpbnRlbmRlZCI7czozMToiaHR0cHM6Ly9sYW10YW5zc3lzdGVtcy5jb20vaG9tZSI7fXM6OToiX3ByZXZpb3VzIjthOjE6e3M6MzoidXJsIjtzOjMxOiJodHRwczovL2xhbXRhbnNzeXN0ZW1zLmNvbS9ob21lIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', NULL, NULL, 1708683555),
('wdLUcvAbaXBhu3MbmpfHXEPsXGtavvr481jrT5AD', NULL, '54.38.211.230', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/51.0.2704.106 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiQ1NFVHdtMlJuSjFmdXl0VmdSRnJaYkRWWlNUY1pZam1BMDZuVVVUcSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjY6Imh0dHBzOi8vbGFtdGFuc3N5c3RlbXMuY29tIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', NULL, NULL, 1708683555),
('l11GJ5eIsZmxjz7JnQxAS3GwACW7y7nD9Utzv2mC', NULL, '178.33.149.171', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/51.0.2704.106 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiSEtsNDU5Y0oxdWFydk5oTUc2SmJxV2Q3ZDliZXVvQmM2NFA1cmtjZiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzI6Imh0dHBzOi8vbGFtdGFuc3N5c3RlbXMuY29tL2xvZ2luIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', NULL, NULL, 1708683549),
('X6dclgLifaEuQx8y2zQkWuHUfsA2q6nLzEkNyKXj', NULL, '178.33.149.171', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/51.0.2704.106 Safari/537.36', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoickI1RGZ5Um5jTzE1MkVyOENRYXBBRGNpRXhKNVJhcHJhTnduWlVaOCI7czozOiJ1cmwiO2E6MTp7czo4OiJpbnRlbmRlZCI7czozMToiaHR0cHM6Ly9sYW10YW5zc3lzdGVtcy5jb20vaG9tZSI7fXM6OToiX3ByZXZpb3VzIjthOjE6e3M6MzoidXJsIjtzOjMxOiJodHRwczovL2xhbXRhbnNzeXN0ZW1zLmNvbS9ob21lIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', NULL, NULL, 1708683549),
('4aRTNXwVsupIh4fTf08xHu8b73whEzN2GVMlbGkY', NULL, '178.33.149.171', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/51.0.2704.106 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiOWxQaElzeUppeGhsSmFZNkozRzZTQlFiMVhFRUQxWE5NekVxdTVoQSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjY6Imh0dHBzOi8vbGFtdGFuc3N5c3RlbXMuY29tIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', NULL, NULL, 1708683549),
('gMi6ZgEJndW1hkcylZupLBQSZKX213g0DqpdkL8u', NULL, '54.38.211.230', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/51.0.2704.106 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiUnFoU29jc1dlbktOOHlxaWF2UnJHb2lqamhiT1BsSzJYbUlJem43OSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzI6Imh0dHBzOi8vbGFtdGFuc3N5c3RlbXMuY29tL2xvZ2luIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', NULL, NULL, 1708683539),
('LUMBmidKheJcWpLNxgpe9g09Q784L9hZEDFwR7da', NULL, '54.38.211.230', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/51.0.2704.106 Safari/537.36', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoicWZ0VDRXMEtzakZ0TTlZdThINnNTN0phdW03RzlqNU85b1RwWWZIeiI7czozOiJ1cmwiO2E6MTp7czo4OiJpbnRlbmRlZCI7czozMToiaHR0cHM6Ly9sYW10YW5zc3lzdGVtcy5jb20vaG9tZSI7fXM6OToiX3ByZXZpb3VzIjthOjE6e3M6MzoidXJsIjtzOjMxOiJodHRwczovL2xhbXRhbnNzeXN0ZW1zLmNvbS9ob21lIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', NULL, NULL, 1708683539),
('nK6odUBYGhZktPjTb9SF6iNb9Cvy9qjjPksx61bj', NULL, '54.38.211.230', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/51.0.2704.106 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiRVZVV3BPcXN3dzhjYXJtVlBLRXVBWVAxZ25rWkE1OEs0elFWZVFlaSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjY6Imh0dHBzOi8vbGFtdGFuc3N5c3RlbXMuY29tIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', NULL, NULL, 1708683538),
('IisjgcaxHEGV4MiWlmPeKvhIHhT7xzu6vXl8dRvT', NULL, '51.89.211.248', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/51.0.2704.106 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiUUpGMUNJVjg2UlJvdnRuZENkY29tSTdER0NVc09UVjBGYkRrVUN5NSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzI6Imh0dHBzOi8vbGFtdGFuc3N5c3RlbXMuY29tL2xvZ2luIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', NULL, NULL, 1708683538),
('yOC3yyK4FB1cevw6jGl7mtlewdjvSpleJawAsm0l', NULL, '51.89.211.248', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/51.0.2704.106 Safari/537.36', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoidnlnWXhtQW0waWhHeGc4TE9RTlAxNkVjZDZIaW44WTJpd3JMREk4WSI7czozOiJ1cmwiO2E6MTp7czo4OiJpbnRlbmRlZCI7czozMToiaHR0cHM6Ly9sYW10YW5zc3lzdGVtcy5jb20vaG9tZSI7fXM6OToiX3ByZXZpb3VzIjthOjE6e3M6MzoidXJsIjtzOjMxOiJodHRwczovL2xhbXRhbnNzeXN0ZW1zLmNvbS9ob21lIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', NULL, NULL, 1708683538),
('WJ8WgUDmmFQp3lE07R5ksORM5tpnsjc4feEHbxr4', NULL, '51.89.211.248', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/51.0.2704.106 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiMmxJVDYzbDJ5UXNBTzNTaktHcFg3bkFoV3poRVEyeXdtV25TWGRwWiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjY6Imh0dHBzOi8vbGFtdGFuc3N5c3RlbXMuY29tIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', NULL, NULL, 1708683538),
('oIMNvlfV3T9SmdmEyrMmZkwSQcmN5ICSTUVuHQKM', NULL, '95.164.159.167', 'Apache-HttpClient/5.1.4 (Java/11.0.18)', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiWVhRY0luOGVIQVlUbFEzQk1nRkRzaVdTdHVLWUNxek5HSmRUTWl4WCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjY6Imh0dHBzOi8vbGFtdGFuc3N5c3RlbXMuY29tIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', NULL, NULL, 1708675012),
('kUJWaI7yC3KFF5fhlE0kk6MS5UeDfWXJeSVQuhA1', NULL, '170.247.221.158', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/107.0.0.0 Safari/537.36', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoiNG5Rb1czdURRajdGTGUxZG5KR1JieUFFOU90NFhrU0FScVNNY0k2VCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzI6Imh0dHBzOi8vbGFtdGFuc3N5c3RlbXMuY29tL2xvZ2luIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319czozOiJ1cmwiO2E6MTp7czo4OiJpbnRlbmRlZCI7czozMToiaHR0cHM6Ly9sYW10YW5zc3lzdGVtcy5jb20vaG9tZSI7fX0=', NULL, NULL, 1708675017),
('m139CBMtAxXpapTbh50vSqLOwcP20MbtQRlkqZxP', NULL, '54.212.41.114', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/83.0.4103.97 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiU0tnVndqelRwdTNtQXJMTFFUdVFSMUs1OWtiamozVzFmN1Z1WldEeCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzI6Imh0dHBzOi8vbGFtdGFuc3N5c3RlbXMuY29tL2xvZ2luIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', NULL, NULL, 1708683000),
('7CguHZWIlGsdqbXaWDsg2exdJldKloiWdQQgj0d0', NULL, '54.212.41.114', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/83.0.4103.97 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiR0tOeGFWaXdoUUVzS1FBNzdVbHVJWFRseXRrV1BYMnJ5NmdFYWVqZCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjY6Imh0dHBzOi8vbGFtdGFuc3N5c3RlbXMuY29tIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', NULL, NULL, 1708682998),
('ex72OYdiyXsbvi2AZHTEAsYBJXZNZ40pgPgAN6ZZ', NULL, '54.212.41.114', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/83.0.4103.97 Safari/537.36', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoiNnVSTUhEV3RlWkZDMVkyOFE0dWs3b2R1cFVOMVppd3h6Ukc2R3dQcSI7czozOiJ1cmwiO2E6MTp7czo4OiJpbnRlbmRlZCI7czozMToiaHR0cHM6Ly9sYW10YW5zc3lzdGVtcy5jb20vaG9tZSI7fXM6OToiX3ByZXZpb3VzIjthOjE6e3M6MzoidXJsIjtzOjMxOiJodHRwczovL2xhbXRhbnNzeXN0ZW1zLmNvbS9ob21lIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', NULL, NULL, 1708682999),
('L4xTcbYiL82s7sxZ4pI3wJaXycHA8SLU9TX2Cr3e', NULL, '34.221.187.186', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/83.0.4103.97 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiUDZWbURvRGpiQURyQ3BjRU5WY1h2dkRSb0d4S3kwVDVMMEU1N2l6byI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjY6Imh0dHBzOi8vbGFtdGFuc3N5c3RlbXMuY29tIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', NULL, NULL, 1708682959),
('8R1APwmmNXxx1wJ5dhp3xFhR9Y0vB5ik6NhDvjUE', NULL, '36.99.136.136', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 11_0_0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/87.0.4280.88 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiTGxFbm9rSUNGMjIwNUd1RnhYQTAwc2JoVW5Mekx5czA3SlVpTWdZSCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjY6Imh0dHBzOi8vbGFtdGFuc3N5c3RlbXMuY29tIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', NULL, NULL, 1708701839),
('0qNrdp3g7ptPPXmo6wX3jwgqyZ4ZzZXg6zv14rff', NULL, '36.99.136.129', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiMDZjck45YzZlYmdEc1FWRTQ2R3c4UnA5OFdPWlhnckpLUXVrSmdqYSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjY6Imh0dHBzOi8vbGFtdGFuc3N5c3RlbXMuY29tIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', NULL, NULL, 1708701836),
('4pDnGLYl9vjrMqFWglGMsetEuo0Xnx6SMmPTV6bw', NULL, '36.99.136.129', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoiNnFUZm4wMUVMZVJGYW9rR1RJOGdGSjN1YU5hcWhFNlNwNm54N3ppdiI7czozOiJ1cmwiO2E6MTp7czo4OiJpbnRlbmRlZCI7czozMToiaHR0cHM6Ly9sYW10YW5zc3lzdGVtcy5jb20vaG9tZSI7fXM6OToiX3ByZXZpb3VzIjthOjE6e3M6MzoidXJsIjtzOjMxOiJodHRwczovL2xhbXRhbnNzeXN0ZW1zLmNvbS9ob21lIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', NULL, NULL, 1708701836),
('RQUxfCU6ZojFSEy62l0gN2nF4l6r8QLzDOsCNyem', NULL, '43.130.39.101', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiemxKNUpzaTRhWUNNRXZXRmRZTHg5NkthWlJEbjBLT3BQcnVxYzFjVyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzA6Imh0dHBzOi8vd3d3LmxhbXRhbnNzeXN0ZW1zLmNvbSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', NULL, NULL, 1708701108),
('qujYiV0pPBfruRE0MlpiUfzUG0JQqJlqTkI0gtSC', NULL, '170.106.101.31', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoic1kzNVhCOXVndnBIUnJHTkk3MlB1T1Q1YlRPZ2Z6NDl4VWVLOHY2QyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjY6Imh0dHBzOi8vbGFtdGFuc3N5c3RlbXMuY29tIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', NULL, NULL, 1708712127),
('9XqDqpO5mi5JOTOyndRDTSIAxGh5kUbGvd94p91J', NULL, '170.106.101.31', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoiOTRjOUw4cDJtalJzTEZsTGduNG5HY05qb3NJcGZFc2ptZFVqNUZuaiI7czozOiJ1cmwiO2E6MTp7czo4OiJpbnRlbmRlZCI7czozMToiaHR0cHM6Ly9sYW10YW5zc3lzdGVtcy5jb20vaG9tZSI7fXM6OToiX3ByZXZpb3VzIjthOjE6e3M6MzoidXJsIjtzOjMxOiJodHRwczovL2xhbXRhbnNzeXN0ZW1zLmNvbS9ob21lIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', NULL, NULL, 1708712128),
('AHmGGrI4TDyd86fzrteOfAQNIzNtcC7U9hbisBdJ', 1, '2400:adc1:15d:1300:a06b:20c0:9dce:e20a', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/121.0.0.0 Safari/537.36', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoiVlAxT3VlcnJEc1BKaWFYcTlOSU4zSkxkbVpWYlpzMGV2dzhOOVlwciI7czo1MDoibG9naW5fd2ViXzU5YmEzNmFkZGMyYjJmOTQwMTU4MGYwMTRjN2Y1OGVhNGUzMDk4OWQiO2k6MTtzOjk6Il9wcmV2aW91cyI7YToxOntzOjM6InVybCI7czozMjoiaHR0cHM6Ly9sYW10YW5zc3lzdGVtcy5jb20vdGFza3MiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', NULL, NULL, 1708691764),
('dnyl69Ez4PW32IzBs4vAKuoxceWDK5HRyX4wwGpz', NULL, '170.106.101.31', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiRUZDZ3V2d29LckJ2TThoZDY4RzFQeW42eERmWlJzY2xSOTlQVFo0dyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzI6Imh0dHBzOi8vbGFtdGFuc3N5c3RlbXMuY29tL2xvZ2luIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', NULL, NULL, 1708712129),
('JXaCRKW7hBcrlfffCd8WAufEC1ntLsSDHxx3C5ht', NULL, '222.249.228.245', 'Mozilla/5.0 (Linux; Android 10; SM-G981B) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.162 Mobile Safari/537.36', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoicWcySngzeFc1cGZmZjhZcE1qeFNVRGxFUXV3U0ZadGJ3UmNpbEgxUiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzI6Imh0dHBzOi8vbGFtdGFuc3N5c3RlbXMuY29tL2xvZ2luIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319czozOiJ1cmwiO2E6MTp7czo4OiJpbnRlbmRlZCI7czozMToiaHR0cHM6Ly9sYW10YW5zc3lzdGVtcy5jb20vaG9tZSI7fX0=', NULL, NULL, 1708706400),
('ghKaR1xmCfjK2DVpvxAKqHjdmNPsS3tvSTogT53q', NULL, '182.44.12.37', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoib1BrRHI3MktLVHdmOVFsMUFGcUs4OTlRWUJZNDlKTkt1eHVHbWNDYyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzI6Imh0dHBzOi8vbGFtdGFuc3N5c3RlbXMuY29tL2xvZ2luIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', NULL, NULL, 1708718539),
('qTpSBBxo4dXIaF7tMZzJ099JCHu3s2wovez5UUZC', NULL, '182.44.12.37', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoicHRSMWpkcTF1ZmVaZXhUUnI5aVN6TG54bUJSd1VkUmxqOUFrblVMNSI7czozOiJ1cmwiO2E6MTp7czo4OiJpbnRlbmRlZCI7czozMToiaHR0cHM6Ly9sYW10YW5zc3lzdGVtcy5jb20vaG9tZSI7fXM6OToiX3ByZXZpb3VzIjthOjE6e3M6MzoidXJsIjtzOjMxOiJodHRwczovL2xhbXRhbnNzeXN0ZW1zLmNvbS9ob21lIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', NULL, NULL, 1708718531),
('zMrWASS5Pc1IvNf9hciO61KmKo9BYyE2lanf1vaE', NULL, '182.44.12.37', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiYzhJWEFaTEpGR25YRjFKbW5iQWxvVmF3NHVLWkhBTUNPd1BzNXZyWiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjY6Imh0dHBzOi8vbGFtdGFuc3N5c3RlbXMuY29tIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', NULL, NULL, 1708718524),
('P0qBvRTL9tFq9DuG9bJPZtO8iOe9vFYX4tbCilUe', NULL, '67.220.86.160', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/100.0.4896.127 Safari/537.36 OPR/86.0.4363.50', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoibVc0MGM5cmUwR2ZKWjlKQ1NCUEdsYWdnMjlvQVkyWmxkeVJJUEhYcCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzI6Imh0dHBzOi8vbGFtdGFuc3N5c3RlbXMuY29tL2xvZ2luIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', NULL, NULL, 1708727429),
('LNzXYg1M8ObmFbTVb1K0a6O8kxbcyHdOYzAfTirW', NULL, '67.220.86.160', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/100.0.4896.127 Safari/537.36 OPR/86.0.4363.50', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoiOE9lWk9DMVJWWlhETmdGNE42VUp3enVlQlM0Q2J4cnYxQXBjcDVZRyI7czozOiJ1cmwiO2E6MTp7czo4OiJpbnRlbmRlZCI7czozMToiaHR0cHM6Ly9sYW10YW5zc3lzdGVtcy5jb20vaG9tZSI7fXM6OToiX3ByZXZpb3VzIjthOjE6e3M6MzoidXJsIjtzOjMxOiJodHRwczovL2xhbXRhbnNzeXN0ZW1zLmNvbS9ob21lIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', NULL, NULL, 1708727429),
('18jcfoy2EpI0dwhSnSXQ6lfmGLhNYOwZsDYAasNJ', NULL, '67.220.86.160', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/100.0.4896.127 Safari/537.36 OPR/86.0.4363.50', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiWTAwdkdpT0VaWEZYWUduc2pSOFlOREVJU1hVMGRWS2hITDRUeDdmYyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjY6Imh0dHBzOi8vbGFtdGFuc3N5c3RlbXMuY29tIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', NULL, NULL, 1708727428);

-- --------------------------------------------------------

--
-- Table structure for table `settings`
--

CREATE TABLE `settings` (
  `settings_id` int(11) NOT NULL,
  `settings_created` datetime NOT NULL,
  `settings_updated` datetime NOT NULL,
  `settings_type` varchar(50) DEFAULT 'standalone' COMMENT 'standalone|saas',
  `settings_saas_tenant_id` int(11) DEFAULT NULL,
  `settings_saas_status` varchar(100) DEFAULT NULL COMMENT 'unsubscribed|free-trial|awaiting-payment|failed|active|cancelled',
  `settings_saas_package_id` int(11) DEFAULT NULL,
  `settings_saas_onetimelogin_key` varchar(100) DEFAULT NULL,
  `settings_saas_onetimelogin_destination` varchar(100) DEFAULT NULL COMMENT 'home|payment',
  `settings_saas_package_limits_clients` int(11) DEFAULT NULL,
  `settings_saas_package_limits_team` int(11) DEFAULT NULL,
  `settings_saas_package_limits_projects` int(11) DEFAULT NULL,
  `settings_saas_notification_uniqueid` text DEFAULT NULL COMMENT '(optional) unique identifier',
  `settings_saas_notification_body` text DEFAULT NULL COMMENT 'html body of promotion etc',
  `settings_saas_notification_read` text DEFAULT NULL COMMENT 'yes|no',
  `settings_saas_notification_action` text DEFAULT NULL COMMENT 'none|external-link|internal-link',
  `settings_saas_notification_action_url` text DEFAULT NULL,
  `settings_saas_email_server_type` varchar(30) DEFAULT 'local' COMMENT 'local |smtp',
  `settings_saas_email_forwarding_address` text DEFAULT NULL,
  `settings_saas_email_local_address` text DEFAULT NULL,
  `settings_installation_date` datetime NOT NULL COMMENT 'date the system was setup',
  `settings_version` text NOT NULL,
  `settings_purchase_code` text DEFAULT NULL COMMENT 'codecanyon code',
  `settings_company_name` text DEFAULT NULL,
  `settings_company_address_line_1` text DEFAULT NULL,
  `settings_company_state` text DEFAULT NULL,
  `settings_company_city` text DEFAULT NULL,
  `settings_company_zipcode` text DEFAULT NULL,
  `settings_company_country` text DEFAULT NULL,
  `settings_company_telephone` text DEFAULT NULL,
  `settings_company_customfield_1` text DEFAULT NULL,
  `settings_company_customfield_2` text DEFAULT NULL,
  `settings_company_customfield_3` text DEFAULT NULL,
  `settings_company_customfield_4` text DEFAULT NULL,
  `settings_clients_registration` text DEFAULT NULL COMMENT 'enabled | disabled',
  `settings_clients_shipping_address` text DEFAULT NULL COMMENT 'enabled | disabled',
  `settings_clients_disable_email_delivery` varchar(12) DEFAULT 'disabled' COMMENT 'enabled | disabled',
  `settings_clients_app_login` varchar(12) DEFAULT 'enabled' COMMENT 'enabled | disabled',
  `settings_customfields_display_leads` varchar(12) DEFAULT 'toggled' COMMENT 'toggled|expanded',
  `settings_customfields_display_clients` varchar(12) DEFAULT 'toggled' COMMENT 'toggled|expanded',
  `settings_customfields_display_projects` varchar(12) DEFAULT 'toggled' COMMENT 'toggled|expanded',
  `settings_customfields_display_tasks` varchar(12) DEFAULT 'toggled' COMMENT 'toggled|expanded',
  `settings_customfields_display_tickets` varchar(12) DEFAULT 'toggled' COMMENT 'toggled|expanded',
  `settings_email_general_variables` text DEFAULT NULL COMMENT 'common variable displayed available in templates',
  `settings_email_from_address` text DEFAULT NULL,
  `settings_email_from_name` text DEFAULT NULL,
  `settings_email_server_type` text DEFAULT NULL COMMENT 'smtp|sendmail',
  `settings_email_smtp_host` text DEFAULT NULL,
  `settings_email_smtp_port` text DEFAULT NULL,
  `settings_email_smtp_username` text DEFAULT NULL,
  `settings_email_smtp_password` text DEFAULT NULL,
  `settings_email_smtp_encryption` text DEFAULT NULL COMMENT 'tls|ssl|starttls',
  `settings_estimates_default_terms_conditions` text DEFAULT NULL,
  `settings_estimates_prefix` text DEFAULT NULL,
  `settings_estimates_show_view_status` varchar(10) DEFAULT 'yes' COMMENT 'yes|no',
  `settings_modules_projects` varchar(10) DEFAULT 'enabled' COMMENT 'enabled|disabled',
  `settings_modules_tasks` varchar(10) DEFAULT 'enabled' COMMENT 'enabled|disabled',
  `settings_modules_invoices` varchar(10) DEFAULT 'enabled' COMMENT 'enabled|disabled',
  `settings_modules_payments` varchar(10) DEFAULT 'enabled' COMMENT 'enabled|disabled',
  `settings_modules_leads` varchar(10) DEFAULT 'enabled' COMMENT 'enabled|disabled',
  `settings_modules_knowledgebase` varchar(10) DEFAULT 'enabled' COMMENT 'enabled|disabled',
  `settings_modules_estimates` varchar(10) DEFAULT 'enabled' COMMENT 'enabled|disabled',
  `settings_modules_expenses` varchar(10) DEFAULT 'enabled' COMMENT 'enabled|disabled',
  `settings_modules_notes` varchar(10) DEFAULT 'enabled' COMMENT 'enabled|disabled',
  `settings_modules_subscriptions` varchar(10) DEFAULT 'enabled' COMMENT 'enabled|disabled',
  `settings_modules_contracts` varchar(10) DEFAULT 'enabled' COMMENT 'enabled|disabled',
  `settings_modules_proposals` varchar(10) DEFAULT 'enabled' COMMENT 'enabled|disabled',
  `settings_modules_tickets` varchar(10) DEFAULT 'enabled' COMMENT 'enabled|disabled',
  `settings_modules_timetracking` varchar(10) DEFAULT 'enabled' COMMENT 'enabled|disabled',
  `settings_modules_reminders` varchar(10) DEFAULT 'enabled' COMMENT 'enabled|disabled',
  `settings_modules_spaces` varchar(10) DEFAULT 'enabled' COMMENT 'enabled|disabled',
  `settings_modules_messages` varchar(10) DEFAULT 'enabled' COMMENT 'enabled|disabled',
  `settings_modules_reports` text DEFAULT NULL COMMENT 'enabled|disabled',
  `settings_files_max_size_mb` int(11) DEFAULT 300 COMMENT 'maximum size in MB',
  `settings_knowledgebase_article_ordering` varchar(40) DEFAULT 'name' COMMENT 'name-asc|name-desc|date-asc|date-desc',
  `settings_knowledgebase_allow_guest_viewing` varchar(10) DEFAULT 'no' COMMENT 'yes | no',
  `settings_knowledgebase_external_pre_body` text DEFAULT NULL COMMENT 'for use when viewing externally, as guest',
  `settings_knowledgebase_external_post_body` text DEFAULT NULL COMMENT 'for use when viewing externally, as guest',
  `settings_knowledgebase_external_header` text DEFAULT NULL COMMENT 'for use when viewing externally, as guest',
  `settings_system_timezone` text DEFAULT NULL,
  `settings_system_date_format` text DEFAULT NULL COMMENT 'd-m-Y | d/m/Y | m-d-Y | m/d/Y | Y-m-d | Y/m/d | Y-d-m | Y/d/m',
  `settings_system_datepicker_format` text DEFAULT NULL COMMENT 'dd-mm-yyyy | mm-dd-yyyy',
  `settings_system_default_leftmenu` text DEFAULT NULL COMMENT 'collapsed | open',
  `settings_system_default_statspanel` text DEFAULT NULL COMMENT 'collapsed | open',
  `settings_system_pagination_limits` tinyint(4) DEFAULT NULL,
  `settings_system_kanban_pagination_limits` tinyint(4) DEFAULT NULL,
  `settings_system_currency_code` text DEFAULT NULL,
  `settings_system_currency_symbol` text DEFAULT NULL,
  `settings_system_currency_position` text DEFAULT NULL COMMENT 'left|right',
  `settings_system_decimal_separator` text DEFAULT NULL,
  `settings_system_thousand_separator` text DEFAULT NULL,
  `settings_system_close_modals_body_click` varchar(10) DEFAULT 'no' COMMENT 'yes|no',
  `settings_system_language_default` varchar(40) DEFAULT 'en' COMMENT 'english|french|etc',
  `settings_system_language_allow_users_to_change` varchar(10) DEFAULT 'yes' COMMENT 'yes|no',
  `settings_system_logo_large_name` varchar(40) DEFAULT 'logo.jpg',
  `settings_system_logo_small_name` varchar(40) DEFAULT 'logo-small.jpg',
  `settings_system_logo_versioning` varchar(40) DEFAULT '1' COMMENT 'used to refresh logo when updated',
  `settings_system_session_login_popup` varchar(10) DEFAULT 'disabled' COMMENT 'enabled|disabled',
  `settings_system_javascript_versioning` date DEFAULT NULL,
  `settings_system_exporting_strip_html` varchar(10) DEFAULT 'yes' COMMENT 'yes|no',
  `settings_tags_allow_users_create` varchar(10) DEFAULT 'yes' COMMENT 'yes|no',
  `settings_leads_allow_private` varchar(10) DEFAULT 'yes' COMMENT 'yes|no',
  `settings_leads_allow_new_sources` varchar(10) DEFAULT 'yes' COMMENT 'yes|no',
  `settings_leads_kanban_value` text DEFAULT NULL COMMENT 'show|hide',
  `settings_leads_kanban_date_created` text DEFAULT NULL COMMENT 'show|hide',
  `settings_leads_kanban_category` text DEFAULT NULL COMMENT 'show|hide',
  `settings_leads_kanban_date_contacted` text DEFAULT NULL COMMENT 'show|hide',
  `settings_leads_kanban_telephone` text DEFAULT NULL COMMENT 'show|hide',
  `settings_leads_kanban_source` text DEFAULT NULL COMMENT 'show|hide',
  `settings_leads_kanban_email` text DEFAULT NULL COMMENT 'show|hide',
  `settings_leads_kanban_tags` text DEFAULT NULL,
  `settings_leads_kanban_reminder` text DEFAULT NULL,
  `settings_tasks_client_visibility` text DEFAULT NULL COMMENT 'visible|invisible - used in create new task form on the checkbox ',
  `settings_tasks_billable` text DEFAULT NULL COMMENT 'billable|not-billable - used in create new task form on the checkbox ',
  `settings_tasks_kanban_date_created` text DEFAULT NULL COMMENT 'show|hide',
  `settings_tasks_kanban_date_due` text DEFAULT NULL COMMENT 'show|hide',
  `settings_tasks_kanban_date_start` text DEFAULT NULL COMMENT 'show|hide',
  `settings_tasks_kanban_priority` text DEFAULT NULL COMMENT 'show|hide',
  `settings_tasks_kanban_milestone` text DEFAULT NULL,
  `settings_tasks_kanban_client_visibility` text DEFAULT NULL COMMENT 'show|hide',
  `settings_tasks_kanban_project_title` varchar(10) DEFAULT 'show' COMMENT 'show|hide',
  `settings_tasks_kanban_client_name` varchar(10) DEFAULT 'show' COMMENT 'show|hide',
  `settings_tasks_kanban_tags` text DEFAULT NULL,
  `settings_tasks_kanban_reminder` text DEFAULT NULL,
  `settings_tasks_send_overdue_reminder` varchar(10) DEFAULT 'yes' COMMENT 'yes|no',
  `settings_invoices_prefix` text DEFAULT NULL,
  `settings_invoices_recurring_grace_period` smallint(6) DEFAULT NULL COMMENT 'Number of days for due date on recurring invoices. If set to zero, invoices will be given due date same as invoice date',
  `settings_invoices_default_terms_conditions` text DEFAULT NULL,
  `settings_invoices_show_view_status` text NOT NULL,
  `settings_projects_cover_images` varchar(10) DEFAULT 'disabled' COMMENT 'enabled|disabled',
  `settings_projects_permissions_basis` varchar(40) DEFAULT 'user_roles' COMMENT 'user_roles|category_based',
  `settings_projects_categories_main_menu` varchar(10) DEFAULT 'no' COMMENT 'yes|no',
  `settings_projects_default_hourly_rate` decimal(10,2) DEFAULT 0.00 COMMENT 'default hourly rate for new projects',
  `settings_projects_allow_setting_permission_on_project_creation` text DEFAULT NULL COMMENT 'yes|no',
  `settings_projects_clientperm_files_view` text DEFAULT NULL COMMENT 'yes|no',
  `settings_projects_clientperm_files_upload` text DEFAULT NULL COMMENT 'yes|no',
  `settings_projects_clientperm_comments_view` text DEFAULT NULL COMMENT 'yes|no',
  `settings_projects_clientperm_comments_post` text DEFAULT NULL COMMENT 'yes|no',
  `settings_projects_clientperm_tasks_view` text DEFAULT NULL COMMENT 'yes|no',
  `settings_projects_clientperm_tasks_collaborate` text DEFAULT NULL COMMENT 'yes|no',
  `settings_projects_clientperm_tasks_create` text DEFAULT NULL COMMENT 'yes|no',
  `settings_projects_clientperm_timesheets_view` text DEFAULT NULL COMMENT 'yes|no',
  `settings_projects_clientperm_expenses_view` text DEFAULT NULL COMMENT 'yes|no',
  `settings_projects_clientperm_milestones_view` text DEFAULT NULL COMMENT 'yes|no',
  `settings_projects_clientperm_assigned_view` text DEFAULT NULL COMMENT 'yes|no',
  `settings_projects_assignedperm_milestone_manage` text DEFAULT NULL COMMENT 'yes|no',
  `settings_projects_assignedperm_tasks_collaborate` text DEFAULT NULL COMMENT 'yes|no',
  `settings_stripe_secret_key` text DEFAULT NULL,
  `settings_stripe_public_key` text DEFAULT NULL,
  `settings_stripe_webhooks_key` text DEFAULT NULL COMMENT 'from strip dashboard',
  `settings_stripe_default_subscription_plan_id` text DEFAULT NULL,
  `settings_stripe_currency` text DEFAULT NULL,
  `settings_stripe_display_name` text DEFAULT NULL COMMENT 'what customer will see on payment screen',
  `settings_stripe_status` text DEFAULT NULL COMMENT 'enabled|disabled',
  `settings_subscriptions_prefix` varchar(40) DEFAULT 'SUB-',
  `settings_paypal_email` text DEFAULT NULL,
  `settings_paypal_currency` text DEFAULT NULL,
  `settings_paypal_display_name` text DEFAULT NULL COMMENT 'what customer will see on payment screen',
  `settings_paypal_mode` text DEFAULT NULL COMMENT 'sandbox | live',
  `settings_paypal_status` text DEFAULT NULL COMMENT 'enabled|disabled',
  `settings_mollie_live_api_key` text DEFAULT NULL,
  `settings_mollie_test_api_key` text DEFAULT NULL,
  `settings_mollie_display_name` text DEFAULT NULL,
  `settings_mollie_mode` varchar(40) DEFAULT 'live',
  `settings_mollie_currency` text DEFAULT NULL,
  `settings_mollie_status` varchar(10) DEFAULT 'disabled' COMMENT 'enabled|disabled',
  `settings_bank_details` text DEFAULT NULL,
  `settings_bank_display_name` text DEFAULT NULL COMMENT 'what customer will see on payment screen',
  `settings_bank_status` text DEFAULT NULL COMMENT 'enabled|disabled',
  `settings_razorpay_keyid` text DEFAULT NULL,
  `settings_razorpay_secretkey` text DEFAULT NULL,
  `settings_razorpay_currency` text DEFAULT NULL,
  `settings_razorpay_display_name` text DEFAULT NULL,
  `settings_razorpay_status` varchar(10) DEFAULT 'disabled',
  `settings_completed_check_email` varchar(10) DEFAULT 'no' COMMENT 'yes|no',
  `settings_expenses_billable_by_default` varchar(10) DEFAULT 'yes' COMMENT 'yes|no',
  `settings_tickets_edit_subject` text DEFAULT NULL COMMENT 'yes|no',
  `settings_tickets_edit_body` text DEFAULT NULL COMMENT 'yes|no',
  `settings_theme_name` varchar(60) DEFAULT 'default' COMMENT 'default|darktheme',
  `settings_theme_head` text DEFAULT NULL,
  `settings_theme_body` text DEFAULT NULL,
  `settings_track_thankyou_session_id` text DEFAULT NULL COMMENT 'used to ensure we show thank you page just once',
  `settings_proposals_prefix` varchar(30) DEFAULT 'PROP-',
  `settings_proposals_show_view_status` varchar(10) DEFAULT 'yes' COMMENT 'yes|no',
  `settings_contracts_prefix` varchar(30) DEFAULT 'CONT-',
  `settings_contracts_show_view_status` varchar(10) DEFAULT 'yes' COMMENT 'yes|no',
  `settings_cronjob_has_run` varchar(10) DEFAULT 'no' COMMENT 'yes|no',
  `settings_cronjob_last_run` datetime DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `settings`
--

INSERT INTO `settings` (`settings_id`, `settings_created`, `settings_updated`, `settings_type`, `settings_saas_tenant_id`, `settings_saas_status`, `settings_saas_package_id`, `settings_saas_onetimelogin_key`, `settings_saas_onetimelogin_destination`, `settings_saas_package_limits_clients`, `settings_saas_package_limits_team`, `settings_saas_package_limits_projects`, `settings_saas_notification_uniqueid`, `settings_saas_notification_body`, `settings_saas_notification_read`, `settings_saas_notification_action`, `settings_saas_notification_action_url`, `settings_saas_email_server_type`, `settings_saas_email_forwarding_address`, `settings_saas_email_local_address`, `settings_installation_date`, `settings_version`, `settings_purchase_code`, `settings_company_name`, `settings_company_address_line_1`, `settings_company_state`, `settings_company_city`, `settings_company_zipcode`, `settings_company_country`, `settings_company_telephone`, `settings_company_customfield_1`, `settings_company_customfield_2`, `settings_company_customfield_3`, `settings_company_customfield_4`, `settings_clients_registration`, `settings_clients_shipping_address`, `settings_clients_disable_email_delivery`, `settings_clients_app_login`, `settings_customfields_display_leads`, `settings_customfields_display_clients`, `settings_customfields_display_projects`, `settings_customfields_display_tasks`, `settings_customfields_display_tickets`, `settings_email_general_variables`, `settings_email_from_address`, `settings_email_from_name`, `settings_email_server_type`, `settings_email_smtp_host`, `settings_email_smtp_port`, `settings_email_smtp_username`, `settings_email_smtp_password`, `settings_email_smtp_encryption`, `settings_estimates_default_terms_conditions`, `settings_estimates_prefix`, `settings_estimates_show_view_status`, `settings_modules_projects`, `settings_modules_tasks`, `settings_modules_invoices`, `settings_modules_payments`, `settings_modules_leads`, `settings_modules_knowledgebase`, `settings_modules_estimates`, `settings_modules_expenses`, `settings_modules_notes`, `settings_modules_subscriptions`, `settings_modules_contracts`, `settings_modules_proposals`, `settings_modules_tickets`, `settings_modules_timetracking`, `settings_modules_reminders`, `settings_modules_spaces`, `settings_modules_messages`, `settings_modules_reports`, `settings_files_max_size_mb`, `settings_knowledgebase_article_ordering`, `settings_knowledgebase_allow_guest_viewing`, `settings_knowledgebase_external_pre_body`, `settings_knowledgebase_external_post_body`, `settings_knowledgebase_external_header`, `settings_system_timezone`, `settings_system_date_format`, `settings_system_datepicker_format`, `settings_system_default_leftmenu`, `settings_system_default_statspanel`, `settings_system_pagination_limits`, `settings_system_kanban_pagination_limits`, `settings_system_currency_code`, `settings_system_currency_symbol`, `settings_system_currency_position`, `settings_system_decimal_separator`, `settings_system_thousand_separator`, `settings_system_close_modals_body_click`, `settings_system_language_default`, `settings_system_language_allow_users_to_change`, `settings_system_logo_large_name`, `settings_system_logo_small_name`, `settings_system_logo_versioning`, `settings_system_session_login_popup`, `settings_system_javascript_versioning`, `settings_system_exporting_strip_html`, `settings_tags_allow_users_create`, `settings_leads_allow_private`, `settings_leads_allow_new_sources`, `settings_leads_kanban_value`, `settings_leads_kanban_date_created`, `settings_leads_kanban_category`, `settings_leads_kanban_date_contacted`, `settings_leads_kanban_telephone`, `settings_leads_kanban_source`, `settings_leads_kanban_email`, `settings_leads_kanban_tags`, `settings_leads_kanban_reminder`, `settings_tasks_client_visibility`, `settings_tasks_billable`, `settings_tasks_kanban_date_created`, `settings_tasks_kanban_date_due`, `settings_tasks_kanban_date_start`, `settings_tasks_kanban_priority`, `settings_tasks_kanban_milestone`, `settings_tasks_kanban_client_visibility`, `settings_tasks_kanban_project_title`, `settings_tasks_kanban_client_name`, `settings_tasks_kanban_tags`, `settings_tasks_kanban_reminder`, `settings_tasks_send_overdue_reminder`, `settings_invoices_prefix`, `settings_invoices_recurring_grace_period`, `settings_invoices_default_terms_conditions`, `settings_invoices_show_view_status`, `settings_projects_cover_images`, `settings_projects_permissions_basis`, `settings_projects_categories_main_menu`, `settings_projects_default_hourly_rate`, `settings_projects_allow_setting_permission_on_project_creation`, `settings_projects_clientperm_files_view`, `settings_projects_clientperm_files_upload`, `settings_projects_clientperm_comments_view`, `settings_projects_clientperm_comments_post`, `settings_projects_clientperm_tasks_view`, `settings_projects_clientperm_tasks_collaborate`, `settings_projects_clientperm_tasks_create`, `settings_projects_clientperm_timesheets_view`, `settings_projects_clientperm_expenses_view`, `settings_projects_clientperm_milestones_view`, `settings_projects_clientperm_assigned_view`, `settings_projects_assignedperm_milestone_manage`, `settings_projects_assignedperm_tasks_collaborate`, `settings_stripe_secret_key`, `settings_stripe_public_key`, `settings_stripe_webhooks_key`, `settings_stripe_default_subscription_plan_id`, `settings_stripe_currency`, `settings_stripe_display_name`, `settings_stripe_status`, `settings_subscriptions_prefix`, `settings_paypal_email`, `settings_paypal_currency`, `settings_paypal_display_name`, `settings_paypal_mode`, `settings_paypal_status`, `settings_mollie_live_api_key`, `settings_mollie_test_api_key`, `settings_mollie_display_name`, `settings_mollie_mode`, `settings_mollie_currency`, `settings_mollie_status`, `settings_bank_details`, `settings_bank_display_name`, `settings_bank_status`, `settings_razorpay_keyid`, `settings_razorpay_secretkey`, `settings_razorpay_currency`, `settings_razorpay_display_name`, `settings_razorpay_status`, `settings_completed_check_email`, `settings_expenses_billable_by_default`, `settings_tickets_edit_subject`, `settings_tickets_edit_body`, `settings_theme_name`, `settings_theme_head`, `settings_theme_body`, `settings_track_thankyou_session_id`, `settings_proposals_prefix`, `settings_proposals_show_view_status`, `settings_contracts_prefix`, `settings_contracts_show_view_status`, `settings_cronjob_has_run`, `settings_cronjob_last_run`) VALUES
(1, '2024-01-30 15:58:58', '2024-02-17 18:17:14', 'standalone', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'local', '', '', '2024-02-15 21:57:55', '2.4', 'd936f791-c280-4f22-a510-225db86d7cd3', 'Lamtans CRM', '10 Redcamp Road', 'Milehill', 'Kent', 'ZE12 8QT', 'United Kingdom', '012 345 6789', NULL, NULL, NULL, NULL, 'enabled', 'enabled', 'disabled', 'enabled', 'toggled', 'toggled', 'toggled', 'toggled', 'toggled', '{our_company_name}, {todays_date}, {email_signature}, {email_footer}, {dashboard_url}', 'info@example.com', 'ABC Inc', 'sendmail', '', '', '', '', 'tls', '<p>Thank you for your business. We look forward to working with you on this project.</p>', 'EST-', 'yes', 'enabled', 'enabled', 'enabled', 'enabled', 'enabled', 'enabled', 'enabled', 'enabled', 'enabled', 'enabled', 'enabled', 'enabled', 'enabled', 'enabled', 'enabled', 'disabled', 'enabled', 'enabled', 5000, 'name-asc', 'no', NULL, NULL, NULL, 'Europe/London', 'm-d-Y', 'mm-dd-yyyy', 'collapsed', 'collapsed', 35, 35, 'EUR', '€', 'left', 'fullstop', 'comma', 'no', 'english', 'yes', 'logo.png', 'logo-small.png', '2024-01-30 15:58:58', 'enabled', '2024-01-30', 'yes', 'yes', 'yes', 'yes', 'show', 'show', 'hide', 'show', 'show', 'hide', 'show', '', '', 'visible', 'billable', 'show', 'show', 'hide', 'show', 'hide', 'hide', 'show', 'show', '', '', 'yes', 'INV-', 3, '<p>Thank you for your business.</p>', 'no', 'enabled', 'user_roles', 'no', NULL, 'yes', 'yes', 'yes', 'yes', 'yes', 'yes', 'yes', 'yes', 'yes', 'yes', 'yes', 'no', 'yes', 'yes', '', '', '', NULL, 'USD', 'Credit Card', 'disabled', 'SUB-', 'info@example.com', 'USD', 'Paypal', 'sandbox', 'disabled', '', '', 'Mollie', 'sandbox', 'USD', 'disabled', '<p><strong>This is just an example:</strong></p>\r\n<p><strong>Bank Name:</strong>&nbsp;ABCD</p>\r\n<p><strong>Account Name:</strong>&nbsp;ABCD</p>\r\n<p><strong>Account Number:</strong>&nbsp;ABCD</p>', 'Bank Transfer', 'enabled', '', '', 'USD', 'RazorPay', 'disabled', 'yes', 'yes', 'yes', 'yes', 'default', NULL, NULL, '', 'PROP-', 'yes', 'CO-', 'yes', 'no', '0000-00-00 00:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `settings2`
--

CREATE TABLE `settings2` (
  `settings2_id` int(11) NOT NULL,
  `settings2_created` datetime NOT NULL,
  `settings2_updated` datetime NOT NULL,
  `settings2_bills_pdf_css` text DEFAULT NULL,
  `settings2_captcha_api_site_key` text DEFAULT NULL,
  `settings2_captcha_api_secret_key` text DEFAULT NULL,
  `settings2_captcha_status` varchar(10) DEFAULT 'disabled' COMMENT 'disabled|enabled',
  `settings2_estimates_automation_default_status` varchar(10) DEFAULT 'disabled' COMMENT 'disabled|enabled',
  `settings2_estimates_automation_create_project` varchar(10) DEFAULT 'no' COMMENT 'yes|no',
  `settings2_estimates_automation_project_status` varchar(50) DEFAULT 'in_progress' COMMENT 'not_started | in_progress | on_hold',
  `settings2_estimates_automation_project_title` text DEFAULT NULL COMMENT 'default project title',
  `settings2_estimates_automation_project_email_client` varchar(10) DEFAULT 'no' COMMENT 'yes|no',
  `settings2_estimates_automation_create_invoice` varchar(10) DEFAULT 'no' COMMENT 'yes|no',
  `settings2_estimates_automation_invoice_email_client` varchar(10) DEFAULT 'no' COMMENT 'yes|no',
  `settings2_estimates_automation_invoice_due_date` int(11) DEFAULT 7,
  `settings2_estimates_automation_create_tasks` varchar(10) DEFAULT 'no' COMMENT 'yes|no',
  `settings2_estimates_automation_copy_attachments` varchar(10) DEFAULT 'yes' COMMENT 'yes|no',
  `settings2_extras_dimensions_billing` varchar(10) DEFAULT 'disabled' COMMENT 'enabled|disabled',
  `settings2_extras_dimensions_default_unit` varchar(30) DEFAULT 'm2',
  `settings2_extras_dimensions_show_measurements` varchar(10) DEFAULT 'no' COMMENT 'show on the pd,web etc',
  `settings2_projects_automation_default_status` varchar(10) DEFAULT 'disabled' COMMENT 'disabled|enabled',
  `settings2_projects_automation_create_invoices` varchar(10) DEFAULT 'no' COMMENT 'yes|no',
  `settings2_projects_automation_convert_estimates_to_invoices` varchar(10) DEFAULT 'no' COMMENT 'yes|no',
  `settings2_projects_automation_skip_draft_estimates` varchar(10) DEFAULT 'yes' COMMENT 'yes|no',
  `settings2_projects_automation_skip_declined_estimates` varchar(10) DEFAULT 'yes' COMMENT 'yes|no',
  `settings2_projects_automation_invoice_unbilled_hours` varchar(10) DEFAULT 'no' COMMENT 'yes|no',
  `settings2_projects_automation_invoice_hourly_rate` decimal(10,2) DEFAULT NULL,
  `settings2_projects_automation_invoice_hourly_tax_1` int(11) DEFAULT NULL,
  `settings2_projects_automation_invoice_email_client` varchar(10) DEFAULT 'no',
  `settings2_projects_automation_invoice_due_date` int(11) DEFAULT 7,
  `settings2_tasks_manage_dependencies` varchar(60) DEFAULT 'super-users' COMMENT 'admin-users | super-users | all-task-users',
  `settings2_tap_secret_key` text DEFAULT NULL,
  `settings2_tap_publishable_key` text DEFAULT NULL,
  `settings2_tap_currency_code` text DEFAULT NULL,
  `settings2_tap_language` varchar(10) DEFAULT 'en' COMMENT 'arabic (ar) | english (en)',
  `settings2_tap_display_name` text DEFAULT NULL,
  `settings2_tap_status` varchar(10) DEFAULT 'disabled' COMMENT 'enabled|disabled',
  `settings2_paystack_secret_key` text DEFAULT NULL,
  `settings2_paystack_public_key` text DEFAULT NULL,
  `settings2_paystack_currency_code` text DEFAULT NULL,
  `settings2_paystack_display_name` text DEFAULT NULL,
  `settings2_paystack_status` varchar(10) DEFAULT 'disabled' COMMENT 'enabled|disabled',
  `settings2_file_folders_status` varchar(10) DEFAULT 'enabled' COMMENT 'enabled|disabled',
  `settings2_file_folders_manage_assigned` varchar(10) DEFAULT 'yes' COMMENT 'yes|no',
  `settings2_file_folders_manage_project_manager` varchar(10) DEFAULT 'yes' COMMENT 'yes|no',
  `settings2_file_folders_manage_client` varchar(10) DEFAULT 'yes' COMMENT 'yes|no',
  `settings2_file_bulk_download` varchar(10) DEFAULT 'enabled' COMMENT 'enabled|disabled',
  `settings2_spaces_team_space_id` text DEFAULT NULL,
  `settings2_spaces_team_space_status` varchar(10) DEFAULT 'enabled' COMMENT 'enabled|disabled',
  `settings2_spaces_user_space_status` varchar(10) DEFAULT 'enabled' COMMENT 'enabled|disabled',
  `settings2_spaces_team_space_title` varchar(150) DEFAULT 'Team Space',
  `settings2_spaces_user_space_title` varchar(150) DEFAULT 'My Space',
  `settings2_spaces_team_space_menu_name` varchar(150) DEFAULT 'Team Space',
  `settings2_spaces_user_space_menu_name` varchar(150) DEFAULT 'Space',
  `settings2_spaces_features_files` varchar(10) DEFAULT 'enabled' COMMENT 'enabled|disabled',
  `settings2_spaces_features_notes` varchar(10) DEFAULT 'enabled' COMMENT 'enabled|disabled',
  `settings2_spaces_features_comments` varchar(10) DEFAULT 'enabled' COMMENT 'enabled|disabled',
  `settings2_spaces_features_tasks` varchar(10) DEFAULT 'enabled' COMMENT 'enabled|disabled',
  `settings2_spaces_features_whiteboard` varchar(10) DEFAULT 'enabled' COMMENT 'enabled|disabled',
  `settings2_spaces_features_checklists` varchar(10) DEFAULT 'enabled' COMMENT 'enabled|disabled',
  `settings2_spaces_features_todos` varchar(10) DEFAULT 'enabled' COMMENT 'enabled|disabled',
  `settings2_spaces_features_reminders` varchar(10) DEFAULT 'enabled' COMMENT 'enabled|disabled',
  `settings2_tickets_replying_interface` varchar(10) DEFAULT 'popup' COMMENT 'popup|inline',
  `settings2_tickets_archive_button` varchar(10) DEFAULT 'yes' COMMENT 'yes|no',
  `settings2_projects_cover_images_show_on_project` varchar(10) DEFAULT 'no' COMMENT 'yes|no',
  `settings2_onboarding_status` varchar(10) DEFAULT 'disabled' COMMENT 'enabled|disabled',
  `settings2_onboarding_content` text DEFAULT NULL,
  `settings2_onboarding_view_status` varchar(10) DEFAULT 'unseen' COMMENT 'seen|unseen',
  `settings2_tweak_reports_truncate_long_text` varchar(10) DEFAULT 'yes' COMMENT 'yes|no'
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `settings2`
--

INSERT INTO `settings2` (`settings2_id`, `settings2_created`, `settings2_updated`, `settings2_bills_pdf_css`, `settings2_captcha_api_site_key`, `settings2_captcha_api_secret_key`, `settings2_captcha_status`, `settings2_estimates_automation_default_status`, `settings2_estimates_automation_create_project`, `settings2_estimates_automation_project_status`, `settings2_estimates_automation_project_title`, `settings2_estimates_automation_project_email_client`, `settings2_estimates_automation_create_invoice`, `settings2_estimates_automation_invoice_email_client`, `settings2_estimates_automation_invoice_due_date`, `settings2_estimates_automation_create_tasks`, `settings2_estimates_automation_copy_attachments`, `settings2_extras_dimensions_billing`, `settings2_extras_dimensions_default_unit`, `settings2_extras_dimensions_show_measurements`, `settings2_projects_automation_default_status`, `settings2_projects_automation_create_invoices`, `settings2_projects_automation_convert_estimates_to_invoices`, `settings2_projects_automation_skip_draft_estimates`, `settings2_projects_automation_skip_declined_estimates`, `settings2_projects_automation_invoice_unbilled_hours`, `settings2_projects_automation_invoice_hourly_rate`, `settings2_projects_automation_invoice_hourly_tax_1`, `settings2_projects_automation_invoice_email_client`, `settings2_projects_automation_invoice_due_date`, `settings2_tasks_manage_dependencies`, `settings2_tap_secret_key`, `settings2_tap_publishable_key`, `settings2_tap_currency_code`, `settings2_tap_language`, `settings2_tap_display_name`, `settings2_tap_status`, `settings2_paystack_secret_key`, `settings2_paystack_public_key`, `settings2_paystack_currency_code`, `settings2_paystack_display_name`, `settings2_paystack_status`, `settings2_file_folders_status`, `settings2_file_folders_manage_assigned`, `settings2_file_folders_manage_project_manager`, `settings2_file_folders_manage_client`, `settings2_file_bulk_download`, `settings2_spaces_team_space_id`, `settings2_spaces_team_space_status`, `settings2_spaces_user_space_status`, `settings2_spaces_team_space_title`, `settings2_spaces_user_space_title`, `settings2_spaces_team_space_menu_name`, `settings2_spaces_user_space_menu_name`, `settings2_spaces_features_files`, `settings2_spaces_features_notes`, `settings2_spaces_features_comments`, `settings2_spaces_features_tasks`, `settings2_spaces_features_whiteboard`, `settings2_spaces_features_checklists`, `settings2_spaces_features_todos`, `settings2_spaces_features_reminders`, `settings2_tickets_replying_interface`, `settings2_tickets_archive_button`, `settings2_projects_cover_images_show_on_project`, `settings2_onboarding_status`, `settings2_onboarding_content`, `settings2_onboarding_view_status`, `settings2_tweak_reports_truncate_long_text`) VALUES
(1, '2024-01-30 15:58:58', '2024-01-30 15:58:58', '', '', '', 'disabled', 'disabled', 'yes', 'on_hold', 'New Project', 'yes', 'yes', 'yes', 7, 'yes', 'yes', 'disabled', 'm2', 'no', 'disabled', 'yes', 'yes', 'yes', 'yes', 'yes', NULL, NULL, 'yes', 7, 'super-users', '', '', '', 'en', '', 'disabled', '', '', 'ZAR', '', 'disabled', 'enabled', 'yes', 'yes', 'yes', 'enabled', NULL, 'enabled', 'enabled', 'Team Workspace', 'My Workspace', 'Team Workspace', 'My Workspace', 'enabled', 'enabled', 'enabled', 'enabled', 'enabled', 'enabled', 'enabled', 'enabled', 'popup', 'yes', 'no', 'disabled', '', 'seen', 'yes');

-- --------------------------------------------------------

--
-- Table structure for table `subscriptions`
--

CREATE TABLE `subscriptions` (
  `subscription_id` int(11) NOT NULL,
  `subscription_gateway_id` varchar(250) DEFAULT NULL,
  `subscription_created` datetime DEFAULT NULL,
  `subscription_updated` datetime DEFAULT NULL,
  `subscription_creatorid` int(11) NOT NULL,
  `subscription_clientid` int(11) NOT NULL,
  `subscription_categoryid` int(11) NOT NULL DEFAULT 4,
  `subscription_projectid` int(11) DEFAULT NULL COMMENT 'optional',
  `subscription_gateway_product` varchar(250) DEFAULT NULL COMMENT 'stripe product id',
  `subscription_gateway_price` varchar(250) DEFAULT NULL COMMENT 'stripe price id',
  `subscription_gateway_product_name` varchar(250) DEFAULT NULL COMMENT 'e.g. Glod Plan',
  `subscription_gateway_interval` int(11) DEFAULT NULL COMMENT 'e.g. 2',
  `subscription_gateway_period` varchar(50) DEFAULT NULL COMMENT 'e.g. months',
  `subscription_date_started` datetime DEFAULT NULL,
  `subscription_date_ended` datetime DEFAULT NULL,
  `subscription_date_renewed` date DEFAULT NULL COMMENT 'from stripe',
  `subscription_date_next_renewal` date DEFAULT NULL COMMENT 'from stripe',
  `subscription_gateway_last_message` text DEFAULT NULL COMMENT 'from stripe',
  `subscription_gateway_last_message_date` datetime DEFAULT NULL,
  `subscription_subtotal` decimal(10,2) NOT NULL DEFAULT 0.00,
  `subscription_amount_before_tax` decimal(10,2) DEFAULT 0.00,
  `subscription_tax_percentage` decimal(10,2) DEFAULT 0.00 COMMENT 'percentage',
  `subscription_tax_amount` decimal(10,2) DEFAULT 0.00 COMMENT 'amount',
  `subscription_final_amount` decimal(10,2) DEFAULT 0.00,
  `subscription_notes` text DEFAULT NULL,
  `subscription_status` varchar(50) DEFAULT 'pending' COMMENT 'pending | active | failed | paused | cancelled',
  `subscription_visibility` varchar(50) DEFAULT 'visible' COMMENT 'visible | invisible',
  `subscription_cron_status` varchar(20) DEFAULT 'none' COMMENT 'none|processing|completed|error  (used to prevent collisions when recurring invoiced)',
  `subscription_cron_date` datetime DEFAULT NULL COMMENT 'date when cron was run'
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='[truncate]' ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `tableconfig`
--

CREATE TABLE `tableconfig` (
  `tableconfig_id` int(11) NOT NULL,
  `tableconfig_created` datetime NOT NULL,
  `tableconfig_updated` datetime NOT NULL,
  `tableconfig_userid` int(11) NOT NULL,
  `tableconfig_table_name` varchar(150) NOT NULL,
  `tableconfig_column_1` varchar(20) DEFAULT 'hidden' COMMENT 'hidden|displayed',
  `tableconfig_column_2` varchar(20) DEFAULT 'hidden' COMMENT 'hidden|displayed',
  `tableconfig_column_3` varchar(20) DEFAULT 'hidden' COMMENT 'hidden|displayed',
  `tableconfig_column_4` varchar(20) DEFAULT 'hidden' COMMENT 'hidden|displayed',
  `tableconfig_column_5` varchar(20) DEFAULT 'hidden' COMMENT 'hidden|displayed',
  `tableconfig_column_6` varchar(20) DEFAULT 'hidden' COMMENT 'hidden|displayed',
  `tableconfig_column_7` varchar(20) DEFAULT 'hidden' COMMENT 'hidden|displayed',
  `tableconfig_column_8` varchar(20) DEFAULT 'hidden' COMMENT 'hidden|displayed',
  `tableconfig_column_9` varchar(20) DEFAULT 'hidden' COMMENT 'hidden|displayed',
  `tableconfig_column_10` varchar(20) DEFAULT 'hidden' COMMENT 'hidden|displayed',
  `tableconfig_column_11` varchar(20) DEFAULT 'hidden' COMMENT 'hidden|displayed',
  `tableconfig_column_12` varchar(20) DEFAULT 'hidden' COMMENT 'hidden|displayed',
  `tableconfig_column_13` varchar(20) DEFAULT 'hidden' COMMENT 'hidden|displayed',
  `tableconfig_column_14` varchar(20) DEFAULT 'hidden' COMMENT 'hidden|displayed',
  `tableconfig_column_15` varchar(20) DEFAULT 'hidden' COMMENT 'hidden|displayed',
  `tableconfig_column_16` varchar(20) DEFAULT 'hidden' COMMENT 'hidden|displayed',
  `tableconfig_column_17` varchar(20) DEFAULT 'hidden' COMMENT 'hidden|displayed',
  `tableconfig_column_18` varchar(20) DEFAULT 'hidden' COMMENT 'hidden|displayed',
  `tableconfig_column_19` varchar(20) DEFAULT 'hidden' COMMENT 'hidden|displayed',
  `tableconfig_column_20` varchar(20) DEFAULT 'hidden' COMMENT 'hidden|displayed',
  `tableconfig_column_21` varchar(20) DEFAULT 'hidden' COMMENT 'hidden|displayed',
  `tableconfig_column_22` varchar(20) DEFAULT 'hidden' COMMENT 'hidden|displayed',
  `tableconfig_column_23` varchar(20) DEFAULT 'hidden' COMMENT 'hidden|displayed',
  `tableconfig_column_24` varchar(20) DEFAULT 'hidden' COMMENT 'hidden|displayed',
  `tableconfig_column_25` varchar(20) DEFAULT 'hidden' COMMENT 'hidden|displayed',
  `tableconfig_column_26` varchar(20) DEFAULT 'hidden' COMMENT 'hidden|displayed',
  `tableconfig_column_27` varchar(20) DEFAULT 'hidden' COMMENT 'hidden|displayed',
  `tableconfig_column_28` varchar(20) DEFAULT 'hidden' COMMENT 'hidden|displayed',
  `tableconfig_column_29` varchar(20) DEFAULT 'hidden' COMMENT 'hidden|displayed',
  `tableconfig_column_30` varchar(20) DEFAULT 'hidden' COMMENT 'hidden|displayed',
  `tableconfig_column_31` varchar(20) DEFAULT 'hidden' COMMENT 'hidden|displayed',
  `tableconfig_column_32` varchar(20) DEFAULT 'hidden' COMMENT 'hidden|displayed',
  `tableconfig_column_33` varchar(20) DEFAULT 'hidden' COMMENT 'hidden|displayed',
  `tableconfig_column_34` varchar(20) DEFAULT 'hidden' COMMENT 'hidden|displayed',
  `tableconfig_column_35` varchar(20) DEFAULT 'hidden' COMMENT 'hidden|displayed',
  `tableconfig_column_36` varchar(20) DEFAULT 'hidden' COMMENT 'hidden|displayed',
  `tableconfig_column_37` varchar(20) DEFAULT 'hidden' COMMENT 'hidden|displayed',
  `tableconfig_column_38` varchar(20) DEFAULT 'hidden' COMMENT 'hidden|displayed',
  `tableconfig_column_39` varchar(20) DEFAULT 'hidden' COMMENT 'hidden|displayed',
  `tableconfig_column_40` varchar(20) DEFAULT 'hidden' COMMENT 'hidden|displayed',
  `tableconfig_custom_1` varchar(20) DEFAULT 'hidden' COMMENT 'hidden|displayed',
  `tableconfig_custom_2` varchar(20) DEFAULT 'hidden' COMMENT 'hidden|displayed',
  `tableconfig_custom_3` varchar(20) DEFAULT 'hidden' COMMENT 'hidden|displayed',
  `tableconfig_custom_4` varchar(20) DEFAULT 'hidden' COMMENT 'hidden|displayed',
  `tableconfig_custom_5` varchar(20) DEFAULT 'hidden' COMMENT 'hidden|displayed',
  `tableconfig_custom_6` varchar(20) DEFAULT 'hidden' COMMENT 'hidden|displayed',
  `tableconfig_custom_7` varchar(20) DEFAULT 'hidden' COMMENT 'hidden|displayed',
  `tableconfig_custom_8` varchar(20) DEFAULT 'hidden' COMMENT 'hidden|displayed',
  `tableconfig_custom_9` varchar(20) DEFAULT 'hidden' COMMENT 'hidden|displayed',
  `tableconfig_custom_10` varchar(20) DEFAULT 'hidden' COMMENT 'hidden|displayed',
  `tableconfig_custom_11` varchar(20) DEFAULT 'hidden' COMMENT 'hidden|displayed',
  `tableconfig_custom_12` varchar(20) DEFAULT 'hidden' COMMENT 'hidden|displayed',
  `tableconfig_custom_13` varchar(20) DEFAULT 'hidden' COMMENT 'hidden|displayed',
  `tableconfig_custom_14` varchar(20) DEFAULT 'hidden' COMMENT 'hidden|displayed',
  `tableconfig_custom_15` varchar(20) DEFAULT 'hidden' COMMENT 'hidden|displayed',
  `tableconfig_custom_16` varchar(20) DEFAULT 'hidden' COMMENT 'hidden|displayed',
  `tableconfig_custom_17` varchar(20) DEFAULT 'hidden' COMMENT 'hidden|displayed',
  `tableconfig_custom_18` varchar(20) DEFAULT 'hidden' COMMENT 'hidden|displayed',
  `tableconfig_custom_19` varchar(20) DEFAULT 'hidden' COMMENT 'hidden|displayed',
  `tableconfig_custom_20` varchar(20) DEFAULT 'hidden' COMMENT 'hidden|displayed',
  `tableconfig_custom_21` varchar(20) DEFAULT 'hidden' COMMENT 'hidden|displayed',
  `tableconfig_custom_22` varchar(20) DEFAULT 'hidden' COMMENT 'hidden|displayed',
  `tableconfig_custom_23` varchar(20) DEFAULT 'hidden' COMMENT 'hidden|displayed',
  `tableconfig_custom_24` varchar(20) DEFAULT 'hidden' COMMENT 'hidden|displayed',
  `tableconfig_custom_25` varchar(20) DEFAULT 'hidden' COMMENT 'hidden|displayed',
  `tableconfig_custom_26` varchar(20) DEFAULT 'hidden' COMMENT 'hidden|displayed',
  `tableconfig_custom_27` varchar(20) DEFAULT 'hidden' COMMENT 'hidden|displayed',
  `tableconfig_custom_28` varchar(20) DEFAULT 'hidden' COMMENT 'hidden|displayed',
  `tableconfig_custom_29` varchar(20) DEFAULT 'hidden' COMMENT 'hidden|displayed',
  `tableconfig_custom_30` varchar(20) DEFAULT 'hidden' COMMENT 'hidden|displayed',
  `tableconfig_custom_31` varchar(20) DEFAULT 'hidden' COMMENT 'hidden|displayed',
  `tableconfig_custom_32` varchar(20) DEFAULT 'hidden' COMMENT 'hidden|displayed',
  `tableconfig_custom_33` varchar(20) DEFAULT 'hidden' COMMENT 'hidden|displayed',
  `tableconfig_custom_34` varchar(20) DEFAULT 'hidden' COMMENT 'hidden|displayed',
  `tableconfig_custom_35` varchar(20) DEFAULT 'hidden' COMMENT 'hidden|displayed',
  `tableconfig_custom_36` varchar(20) DEFAULT 'hidden' COMMENT 'hidden|displayed',
  `tableconfig_custom_37` varchar(20) DEFAULT 'hidden' COMMENT 'hidden|displayed',
  `tableconfig_custom_38` varchar(20) DEFAULT 'hidden' COMMENT 'hidden|displayed',
  `tableconfig_custom_39` varchar(20) DEFAULT 'hidden' COMMENT 'hidden|displayed',
  `tableconfig_custom_40` varchar(20) DEFAULT 'hidden' COMMENT 'hidden|displayed',
  `tableconfig_custom_41` varchar(20) DEFAULT 'hidden' COMMENT 'hidden|displayed',
  `tableconfig_custom_42` varchar(20) DEFAULT 'hidden' COMMENT 'hidden|displayed',
  `tableconfig_custom_43` varchar(20) DEFAULT 'hidden' COMMENT 'hidden|displayed',
  `tableconfig_custom_44` varchar(20) DEFAULT 'hidden' COMMENT 'hidden|displayed',
  `tableconfig_custom_45` varchar(20) DEFAULT 'hidden' COMMENT 'hidden|displayed',
  `tableconfig_custom_46` varchar(20) DEFAULT 'hidden' COMMENT 'hidden|displayed',
  `tableconfig_custom_47` varchar(20) DEFAULT 'hidden' COMMENT 'hidden|displayed',
  `tableconfig_custom_48` varchar(20) DEFAULT 'hidden' COMMENT 'hidden|displayed',
  `tableconfig_custom_49` varchar(20) DEFAULT 'hidden' COMMENT 'hidden|displayed',
  `tableconfig_custom_50` varchar(20) DEFAULT 'hidden' COMMENT 'hidden|displayed',
  `tableconfig_custom_51` varchar(20) DEFAULT 'hidden' COMMENT 'hidden|displayed',
  `tableconfig_custom_52` varchar(20) DEFAULT 'hidden' COMMENT 'hidden|displayed',
  `tableconfig_custom_53` varchar(20) DEFAULT 'hidden' COMMENT 'hidden|displayed',
  `tableconfig_custom_54` varchar(20) DEFAULT 'hidden' COMMENT 'hidden|displayed',
  `tableconfig_custom_55` varchar(20) DEFAULT 'hidden' COMMENT 'hidden|displayed',
  `tableconfig_custom_56` varchar(20) DEFAULT 'hidden' COMMENT 'hidden|displayed',
  `tableconfig_custom_57` varchar(20) DEFAULT 'hidden' COMMENT 'hidden|displayed',
  `tableconfig_custom_58` varchar(20) DEFAULT 'hidden' COMMENT 'hidden|displayed',
  `tableconfig_custom_59` varchar(20) DEFAULT 'hidden' COMMENT 'hidden|displayed',
  `tableconfig_custom_60` varchar(20) DEFAULT 'hidden' COMMENT 'hidden|displayed',
  `tableconfig_custom_61` varchar(20) DEFAULT 'hidden' COMMENT 'hidden|displayed',
  `tableconfig_custom_62` varchar(20) DEFAULT 'hidden' COMMENT 'hidden|displayed',
  `tableconfig_custom_63` varchar(20) DEFAULT 'hidden' COMMENT 'hidden|displayed',
  `tableconfig_custom_64` varchar(20) DEFAULT 'hidden' COMMENT 'hidden|displayed',
  `tableconfig_custom_65` varchar(20) DEFAULT 'hidden' COMMENT 'hidden|displayed',
  `tableconfig_custom_66` varchar(20) DEFAULT 'hidden' COMMENT 'hidden|displayed',
  `tableconfig_custom_67` varchar(20) DEFAULT 'hidden' COMMENT 'hidden|displayed',
  `tableconfig_custom_68` varchar(20) DEFAULT 'hidden' COMMENT 'hidden|displayed',
  `tableconfig_custom_69` varchar(20) DEFAULT 'hidden' COMMENT 'hidden|displayed',
  `tableconfig_custom_70` varchar(20) DEFAULT 'hidden' COMMENT 'hidden|displayed'
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `tableconfig`
--

INSERT INTO `tableconfig` (`tableconfig_id`, `tableconfig_created`, `tableconfig_updated`, `tableconfig_userid`, `tableconfig_table_name`, `tableconfig_column_1`, `tableconfig_column_2`, `tableconfig_column_3`, `tableconfig_column_4`, `tableconfig_column_5`, `tableconfig_column_6`, `tableconfig_column_7`, `tableconfig_column_8`, `tableconfig_column_9`, `tableconfig_column_10`, `tableconfig_column_11`, `tableconfig_column_12`, `tableconfig_column_13`, `tableconfig_column_14`, `tableconfig_column_15`, `tableconfig_column_16`, `tableconfig_column_17`, `tableconfig_column_18`, `tableconfig_column_19`, `tableconfig_column_20`, `tableconfig_column_21`, `tableconfig_column_22`, `tableconfig_column_23`, `tableconfig_column_24`, `tableconfig_column_25`, `tableconfig_column_26`, `tableconfig_column_27`, `tableconfig_column_28`, `tableconfig_column_29`, `tableconfig_column_30`, `tableconfig_column_31`, `tableconfig_column_32`, `tableconfig_column_33`, `tableconfig_column_34`, `tableconfig_column_35`, `tableconfig_column_36`, `tableconfig_column_37`, `tableconfig_column_38`, `tableconfig_column_39`, `tableconfig_column_40`, `tableconfig_custom_1`, `tableconfig_custom_2`, `tableconfig_custom_3`, `tableconfig_custom_4`, `tableconfig_custom_5`, `tableconfig_custom_6`, `tableconfig_custom_7`, `tableconfig_custom_8`, `tableconfig_custom_9`, `tableconfig_custom_10`, `tableconfig_custom_11`, `tableconfig_custom_12`, `tableconfig_custom_13`, `tableconfig_custom_14`, `tableconfig_custom_15`, `tableconfig_custom_16`, `tableconfig_custom_17`, `tableconfig_custom_18`, `tableconfig_custom_19`, `tableconfig_custom_20`, `tableconfig_custom_21`, `tableconfig_custom_22`, `tableconfig_custom_23`, `tableconfig_custom_24`, `tableconfig_custom_25`, `tableconfig_custom_26`, `tableconfig_custom_27`, `tableconfig_custom_28`, `tableconfig_custom_29`, `tableconfig_custom_30`, `tableconfig_custom_31`, `tableconfig_custom_32`, `tableconfig_custom_33`, `tableconfig_custom_34`, `tableconfig_custom_35`, `tableconfig_custom_36`, `tableconfig_custom_37`, `tableconfig_custom_38`, `tableconfig_custom_39`, `tableconfig_custom_40`, `tableconfig_custom_41`, `tableconfig_custom_42`, `tableconfig_custom_43`, `tableconfig_custom_44`, `tableconfig_custom_45`, `tableconfig_custom_46`, `tableconfig_custom_47`, `tableconfig_custom_48`, `tableconfig_custom_49`, `tableconfig_custom_50`, `tableconfig_custom_51`, `tableconfig_custom_52`, `tableconfig_custom_53`, `tableconfig_custom_54`, `tableconfig_custom_55`, `tableconfig_custom_56`, `tableconfig_custom_57`, `tableconfig_custom_58`, `tableconfig_custom_59`, `tableconfig_custom_60`, `tableconfig_custom_61`, `tableconfig_custom_62`, `tableconfig_custom_63`, `tableconfig_custom_64`, `tableconfig_custom_65`, `tableconfig_custom_66`, `tableconfig_custom_67`, `tableconfig_custom_68`, `tableconfig_custom_69`, `tableconfig_custom_70`) VALUES
(1, '2024-02-15 22:59:41', '2024-02-15 22:59:41', 1, 'projects', 'displayed', 'displayed', 'displayed', 'displayed', 'displayed', 'displayed', 'displayed', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden'),
(2, '2024-02-15 23:00:12', '2024-02-15 23:00:12', 1, 'clients', 'displayed', 'displayed', 'displayed', 'displayed', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden', 'displayed', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden', 'displayed', 'displayed', 'displayed', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden'),
(3, '2024-02-15 23:00:37', '2024-02-15 23:00:37', 1, 'leads', 'displayed', 'displayed', 'displayed', 'displayed', 'displayed', 'displayed', 'displayed', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden', 'hidden');

-- --------------------------------------------------------

--
-- Table structure for table `tags`
--

CREATE TABLE `tags` (
  `tag_id` int(11) NOT NULL,
  `tag_created` datetime DEFAULT NULL,
  `tag_updated` datetime DEFAULT NULL,
  `tag_creatorid` int(11) DEFAULT NULL,
  `tag_title` varchar(100) NOT NULL,
  `tag_visibility` varchar(50) NOT NULL DEFAULT 'user' COMMENT 'public | user  (public tags are only created via admin settings)',
  `tagresource_type` varchar(50) NOT NULL COMMENT '[polymorph] invoice | project | client | lead | task | estimate | ticket | contract | note | subscription | contract | proposal',
  `tagresource_id` int(11) NOT NULL COMMENT '[polymorph] e.g project_id'
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='[truncate]' ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `tasks`
--

CREATE TABLE `tasks` (
  `task_id` int(11) NOT NULL,
  `task_importid` varchar(100) DEFAULT NULL,
  `task_position` double NOT NULL COMMENT 'increment by 16384',
  `task_created` datetime DEFAULT NULL COMMENT 'always now()',
  `task_updated` datetime DEFAULT NULL,
  `task_creatorid` int(11) DEFAULT NULL,
  `task_clientid` int(11) DEFAULT NULL COMMENT 'optional',
  `task_projectid` int(11) DEFAULT NULL COMMENT 'project_id',
  `task_date_start` date DEFAULT NULL,
  `task_date_due` date DEFAULT NULL,
  `task_title` varchar(250) DEFAULT NULL,
  `task_description` text DEFAULT NULL,
  `task_client_visibility` varchar(100) DEFAULT 'yes',
  `task_milestoneid` int(11) DEFAULT NULL COMMENT 'new tasks must be set to the [uncategorised] milestone',
  `task_previous_status` varchar(100) DEFAULT 'new',
  `task_priority` int(11) DEFAULT 1,
  `task_status` int(11) DEFAULT 1,
  `task_active_state` varchar(100) DEFAULT 'active' COMMENT 'active|archived',
  `task_billable` varchar(5) DEFAULT 'yes' COMMENT 'yes | no',
  `task_billable_status` varchar(20) DEFAULT 'not_invoiced' COMMENT 'invoiced | not_invoiced',
  `task_billable_invoiceid` int(11) DEFAULT NULL COMMENT 'id of the invoice that it has been billed to',
  `task_billable_lineitemid` int(11) DEFAULT NULL COMMENT 'id of line item that was billed',
  `task_visibility` varchar(40) DEFAULT 'visible' COMMENT 'visible|hidden (used to prevent tasks that are still being cloned from showing in tasks list)',
  `task_overdue_notification_sent` varchar(40) DEFAULT 'no' COMMENT 'yes|no',
  `task_recurring` varchar(40) DEFAULT 'no' COMMENT 'yes|no',
  `task_recurring_duration` int(11) DEFAULT NULL COMMENT 'e.g. 20 (for 20 days)',
  `task_recurring_period` varchar(30) DEFAULT NULL COMMENT 'day | week | month | year',
  `task_recurring_cycles` int(11) DEFAULT NULL COMMENT '0 for infinity',
  `task_recurring_cycles_counter` int(11) DEFAULT 0 COMMENT 'number of times it has been renewed',
  `task_recurring_last` date DEFAULT NULL COMMENT 'date when it was last renewed',
  `task_recurring_next` date DEFAULT NULL COMMENT 'date when it will next be renewed',
  `task_recurring_child` varchar(10) DEFAULT 'no' COMMENT 'yes|no',
  `task_recurring_parent_id` datetime DEFAULT NULL COMMENT 'if it was generated from a recurring invoice, the id of parent invoice',
  `task_recurring_copy_checklists` varchar(10) DEFAULT 'yes' COMMENT 'yes|no',
  `task_recurring_copy_files` varchar(10) DEFAULT 'yes' COMMENT 'yes|no',
  `task_recurring_automatically_assign` varchar(10) DEFAULT 'yes' COMMENT 'yes|no',
  `task_recurring_finished` varchar(10) DEFAULT 'no' COMMENT 'yes|no',
  `task_cloning_original_task_id` varchar(10) DEFAULT NULL,
  `task_custom_field_1` tinytext DEFAULT NULL,
  `task_custom_field_2` tinytext DEFAULT NULL,
  `task_custom_field_3` tinytext DEFAULT NULL,
  `task_custom_field_4` tinytext DEFAULT NULL,
  `task_custom_field_5` tinytext DEFAULT NULL,
  `task_custom_field_6` tinytext DEFAULT NULL,
  `task_custom_field_7` tinytext DEFAULT NULL,
  `task_custom_field_8` tinytext DEFAULT NULL,
  `task_custom_field_9` tinytext DEFAULT NULL,
  `task_custom_field_10` tinytext DEFAULT NULL,
  `task_custom_field_11` datetime DEFAULT NULL,
  `task_custom_field_12` datetime DEFAULT NULL,
  `task_custom_field_13` datetime DEFAULT NULL,
  `task_custom_field_14` datetime DEFAULT NULL,
  `task_custom_field_15` datetime DEFAULT NULL,
  `task_custom_field_16` datetime DEFAULT NULL,
  `task_custom_field_17` datetime DEFAULT NULL,
  `task_custom_field_18` datetime DEFAULT NULL,
  `task_custom_field_19` datetime DEFAULT NULL,
  `task_custom_field_20` datetime DEFAULT NULL,
  `task_custom_field_21` text DEFAULT NULL,
  `task_custom_field_22` text DEFAULT NULL,
  `task_custom_field_23` text DEFAULT NULL,
  `task_custom_field_24` text DEFAULT NULL,
  `task_custom_field_25` text DEFAULT NULL,
  `task_custom_field_26` text DEFAULT NULL,
  `task_custom_field_27` text DEFAULT NULL,
  `task_custom_field_28` text DEFAULT NULL,
  `task_custom_field_29` text DEFAULT NULL,
  `task_custom_field_30` text DEFAULT NULL,
  `task_custom_field_31` varchar(20) DEFAULT NULL,
  `task_custom_field_32` varchar(20) DEFAULT NULL,
  `task_custom_field_33` varchar(20) DEFAULT NULL,
  `task_custom_field_34` varchar(20) DEFAULT NULL,
  `task_custom_field_35` varchar(20) DEFAULT NULL,
  `task_custom_field_36` varchar(20) DEFAULT NULL,
  `task_custom_field_37` varchar(20) DEFAULT NULL,
  `task_custom_field_38` varchar(20) DEFAULT NULL,
  `task_custom_field_39` varchar(20) DEFAULT NULL,
  `task_custom_field_40` varchar(20) DEFAULT NULL,
  `task_custom_field_41` varchar(150) DEFAULT NULL,
  `task_custom_field_42` varchar(150) DEFAULT NULL,
  `task_custom_field_43` varchar(150) DEFAULT NULL,
  `task_custom_field_44` varchar(150) DEFAULT NULL,
  `task_custom_field_45` varchar(150) DEFAULT NULL,
  `task_custom_field_46` varchar(150) DEFAULT NULL,
  `task_custom_field_47` varchar(150) DEFAULT NULL,
  `task_custom_field_48` varchar(150) DEFAULT NULL,
  `task_custom_field_49` varchar(150) DEFAULT NULL,
  `task_custom_field_50` varchar(150) DEFAULT NULL,
  `task_custom_field_51` int(11) DEFAULT NULL,
  `task_custom_field_52` int(11) DEFAULT NULL,
  `task_custom_field_53` int(11) DEFAULT NULL,
  `task_custom_field_54` int(11) DEFAULT NULL,
  `task_custom_field_55` int(11) DEFAULT NULL,
  `task_custom_field_56` int(11) DEFAULT NULL,
  `task_custom_field_57` int(11) DEFAULT NULL,
  `task_custom_field_58` int(11) DEFAULT NULL,
  `task_custom_field_59` int(11) DEFAULT NULL,
  `task_custom_field_60` int(11) DEFAULT NULL,
  `task_custom_field_61` decimal(10,2) DEFAULT NULL,
  `task_custom_field_62` decimal(10,2) DEFAULT NULL,
  `task_custom_field_63` decimal(10,2) DEFAULT NULL,
  `task_custom_field_64` decimal(10,2) DEFAULT NULL,
  `task_custom_field_65` decimal(10,2) DEFAULT NULL,
  `task_custom_field_66` decimal(10,2) DEFAULT NULL,
  `task_custom_field_67` decimal(10,2) DEFAULT NULL,
  `task_custom_field_68` decimal(10,2) DEFAULT NULL,
  `task_custom_field_69` decimal(10,2) DEFAULT NULL,
  `task_custom_field_70` decimal(10,2) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='[truncate]' ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `tasks_assigned`
--

CREATE TABLE `tasks_assigned` (
  `tasksassigned_id` int(11) NOT NULL COMMENT '[truncate]',
  `tasksassigned_taskid` int(11) NOT NULL,
  `tasksassigned_userid` int(11) DEFAULT NULL,
  `tasksassigned_created` datetime DEFAULT NULL,
  `tasksassigned_updated` datetime DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='[truncate]' ROW_FORMAT=FIXED;

-- --------------------------------------------------------

--
-- Table structure for table `tasks_dependencies`
--

CREATE TABLE `tasks_dependencies` (
  `tasksdependency_id` int(11) NOT NULL,
  `tasksdependency_created` int(11) NOT NULL,
  `tasksdependency_updated` int(11) NOT NULL,
  `tasksdependency_creatorid` int(11) DEFAULT NULL,
  `tasksdependency_projectid` int(11) DEFAULT NULL,
  `tasksdependency_clientid` int(11) DEFAULT NULL,
  `tasksdependency_taskid` int(11) DEFAULT NULL,
  `tasksdependency_blockerid` int(11) DEFAULT NULL,
  `tasksdependency_type` varchar(100) DEFAULT NULL COMMENT 'cannot_complete|cannot_start',
  `tasksdependency_status` varchar(100) DEFAULT 'active' COMMENT 'active|fulfilled'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `tasks_priority`
--

CREATE TABLE `tasks_priority` (
  `taskpriority_id` int(11) NOT NULL,
  `taskpriority_created` datetime DEFAULT NULL,
  `taskpriority_creatorid` int(11) DEFAULT NULL,
  `taskpriority_updated` datetime DEFAULT NULL,
  `taskpriority_title` varchar(200) NOT NULL,
  `taskpriority_position` int(11) NOT NULL,
  `taskpriority_color` varchar(100) NOT NULL DEFAULT 'default' COMMENT 'default|primary|success|info|warning|danger|lime|brown',
  `taskpriority_system_default` varchar(10) NOT NULL DEFAULT 'no' COMMENT 'yes | no'
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='[do not truncate]  expected to have 2 system default statuses (ID: 1 & 2) ''new'' & ''converted'' statuses ' ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `tasks_priority`
--

INSERT INTO `tasks_priority` (`taskpriority_id`, `taskpriority_created`, `taskpriority_creatorid`, `taskpriority_updated`, `taskpriority_title`, `taskpriority_position`, `taskpriority_color`, `taskpriority_system_default`) VALUES
(1, NULL, 0, '2024-01-30 15:58:58', 'Normal', 1, 'lime', 'yes'),
(2, NULL, 0, '2024-01-30 15:58:58', 'Low', 2, 'success', 'no'),
(3, NULL, 0, '2024-01-30 15:58:58', 'High', 3, 'warning', 'no'),
(4, NULL, 0, '2024-01-30 15:58:58', 'Urgent', 4, 'danger', 'no');

-- --------------------------------------------------------

--
-- Table structure for table `tasks_status`
--

CREATE TABLE `tasks_status` (
  `taskstatus_id` int(11) NOT NULL,
  `taskstatus_created` datetime DEFAULT NULL,
  `taskstatus_creatorid` int(11) DEFAULT NULL,
  `taskstatus_updated` datetime DEFAULT NULL,
  `taskstatus_title` varchar(200) NOT NULL,
  `taskstatus_position` int(11) NOT NULL,
  `taskstatus_color` varchar(100) NOT NULL DEFAULT 'default' COMMENT 'default|primary|success|info|warning|danger|lime|brown',
  `taskstatus_system_default` varchar(10) NOT NULL DEFAULT 'no' COMMENT 'yes | no'
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='[do not truncate]  expected to have 2 system default statuses (ID: 1 & 2) ''new'' & ''converted'' statuses ' ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `tasks_status`
--

INSERT INTO `tasks_status` (`taskstatus_id`, `taskstatus_created`, `taskstatus_creatorid`, `taskstatus_updated`, `taskstatus_title`, `taskstatus_position`, `taskstatus_color`, `taskstatus_system_default`) VALUES
(1, NULL, 0, '2021-09-26 11:13:40', 'New', 1, 'default', 'yes'),
(2, NULL, 0, '2021-09-26 11:13:40', 'Completed', 4, 'success', 'yes'),
(3, NULL, 0, '2021-09-26 11:13:40', 'In Progress', 2, 'info', 'no'),
(4, NULL, 0, '2021-09-26 11:13:40', 'Awaiting Feedback', 3, 'warning', 'no');

-- --------------------------------------------------------

--
-- Table structure for table `tax`
--

CREATE TABLE `tax` (
  `tax_id` int(11) NOT NULL,
  `tax_taxrateid` int(11) NOT NULL COMMENT 'Reference to tax rates table',
  `tax_created` datetime NOT NULL,
  `tax_updated` datetime NOT NULL,
  `tax_name` varchar(100) DEFAULT NULL,
  `tax_rate` decimal(10,2) DEFAULT NULL,
  `tax_type` varchar(50) DEFAULT 'summary' COMMENT 'summary|inline',
  `tax_lineitem_id` int(11) DEFAULT NULL COMMENT 'for inline taxes',
  `taxresource_type` varchar(50) DEFAULT NULL COMMENT 'invoice|estimate|lineitem',
  `taxresource_id` int(11) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='[truncate]' ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `taxrates`
--

CREATE TABLE `taxrates` (
  `taxrate_id` int(11) NOT NULL,
  `taxrate_uniqueid` varchar(200) NOT NULL COMMENT 'Used in <js> for identification',
  `taxrate_created` datetime NOT NULL,
  `taxrate_updated` datetime NOT NULL,
  `taxrate_creatorid` int(11) NOT NULL,
  `taxrate_name` varchar(100) NOT NULL,
  `taxrate_value` decimal(10,2) NOT NULL,
  `taxrate_type` varchar(100) NOT NULL DEFAULT 'user' COMMENT 'system|user|temp|client',
  `taxrate_clientid` int(11) DEFAULT NULL,
  `taxrate_estimateid` int(11) DEFAULT NULL,
  `taxrate_invoiceid` int(11) DEFAULT NULL,
  `taxrate_status` varchar(20) NOT NULL DEFAULT 'enabled' COMMENT 'enabled|disabled'
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='[truncate]' ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `taxrates`
--

INSERT INTO `taxrates` (`taxrate_id`, `taxrate_uniqueid`, `taxrate_created`, `taxrate_updated`, `taxrate_creatorid`, `taxrate_name`, `taxrate_value`, `taxrate_type`, `taxrate_clientid`, `taxrate_estimateid`, `taxrate_invoiceid`, `taxrate_status`) VALUES
(1, 'zero-rated-tax-rate', '2024-01-30 15:58:58', '2024-01-30 15:58:58', 0, 'No Tax', 0.00, 'system', NULL, NULL, NULL, 'enabled');

-- --------------------------------------------------------

--
-- Table structure for table `tickets`
--

CREATE TABLE `tickets` (
  `ticket_id` int(11) NOT NULL,
  `ticket_created` datetime DEFAULT NULL,
  `ticket_updated` datetime DEFAULT NULL,
  `ticket_creatorid` int(11) NOT NULL,
  `ticket_categoryid` int(11) NOT NULL DEFAULT 9,
  `ticket_clientid` int(11) DEFAULT NULL,
  `ticket_projectid` int(11) DEFAULT NULL,
  `ticket_subject` varchar(250) DEFAULT NULL,
  `ticket_message` text DEFAULT NULL,
  `ticket_priority` varchar(50) NOT NULL DEFAULT 'normal' COMMENT 'normal | high | urgent',
  `ticket_last_updated` datetime DEFAULT NULL,
  `ticket_status` tinyint(4) NOT NULL DEFAULT 1 COMMENT 'numeric status id',
  `ticket_active_state` varchar(20) DEFAULT 'active' COMMENT 'active|archived',
  `ticket_custom_field_1` tinytext DEFAULT NULL,
  `ticket_custom_field_2` tinytext DEFAULT NULL,
  `ticket_custom_field_3` tinytext DEFAULT NULL,
  `ticket_custom_field_4` tinytext DEFAULT NULL,
  `ticket_custom_field_5` tinytext DEFAULT NULL,
  `ticket_custom_field_6` tinytext DEFAULT NULL,
  `ticket_custom_field_7` tinytext DEFAULT NULL,
  `ticket_custom_field_8` tinytext DEFAULT NULL,
  `ticket_custom_field_9` tinytext DEFAULT NULL,
  `ticket_custom_field_10` tinytext DEFAULT NULL,
  `ticket_custom_field_11` tinytext DEFAULT NULL,
  `ticket_custom_field_12` tinytext DEFAULT NULL,
  `ticket_custom_field_13` tinytext DEFAULT NULL,
  `ticket_custom_field_14` tinytext DEFAULT NULL,
  `ticket_custom_field_15` tinytext DEFAULT NULL,
  `ticket_custom_field_16` tinytext DEFAULT NULL,
  `ticket_custom_field_17` tinytext DEFAULT NULL,
  `ticket_custom_field_18` tinytext DEFAULT NULL,
  `ticket_custom_field_19` tinytext DEFAULT NULL,
  `ticket_custom_field_20` tinytext DEFAULT NULL,
  `ticket_custom_field_21` tinytext DEFAULT NULL,
  `ticket_custom_field_22` tinytext DEFAULT NULL,
  `ticket_custom_field_23` tinytext DEFAULT NULL,
  `ticket_custom_field_24` tinytext DEFAULT NULL,
  `ticket_custom_field_25` tinytext DEFAULT NULL,
  `ticket_custom_field_26` tinytext DEFAULT NULL,
  `ticket_custom_field_27` tinytext DEFAULT NULL,
  `ticket_custom_field_28` tinytext DEFAULT NULL,
  `ticket_custom_field_29` tinytext DEFAULT NULL,
  `ticket_custom_field_30` tinytext DEFAULT NULL,
  `ticket_custom_field_31` tinytext DEFAULT NULL,
  `ticket_custom_field_32` tinytext DEFAULT NULL,
  `ticket_custom_field_33` tinytext DEFAULT NULL,
  `ticket_custom_field_34` tinytext DEFAULT NULL,
  `ticket_custom_field_35` tinytext DEFAULT NULL,
  `ticket_custom_field_36` tinytext DEFAULT NULL,
  `ticket_custom_field_37` tinytext DEFAULT NULL,
  `ticket_custom_field_38` tinytext DEFAULT NULL,
  `ticket_custom_field_39` tinytext DEFAULT NULL,
  `ticket_custom_field_40` tinytext DEFAULT NULL,
  `ticket_custom_field_41` tinytext DEFAULT NULL,
  `ticket_custom_field_42` tinytext DEFAULT NULL,
  `ticket_custom_field_43` tinytext DEFAULT NULL,
  `ticket_custom_field_44` tinytext DEFAULT NULL,
  `ticket_custom_field_45` tinytext DEFAULT NULL,
  `ticket_custom_field_46` tinytext DEFAULT NULL,
  `ticket_custom_field_47` tinytext DEFAULT NULL,
  `ticket_custom_field_48` tinytext DEFAULT NULL,
  `ticket_custom_field_49` tinytext DEFAULT NULL,
  `ticket_custom_field_50` tinytext DEFAULT NULL,
  `ticket_custom_field_51` tinytext DEFAULT NULL,
  `ticket_custom_field_52` tinytext DEFAULT NULL,
  `ticket_custom_field_53` tinytext DEFAULT NULL,
  `ticket_custom_field_54` tinytext DEFAULT NULL,
  `ticket_custom_field_55` tinytext DEFAULT NULL,
  `ticket_custom_field_56` tinytext DEFAULT NULL,
  `ticket_custom_field_57` tinytext DEFAULT NULL,
  `ticket_custom_field_58` tinytext DEFAULT NULL,
  `ticket_custom_field_59` tinytext DEFAULT NULL,
  `ticket_custom_field_60` tinytext DEFAULT NULL,
  `ticket_custom_field_61` tinytext DEFAULT NULL,
  `ticket_custom_field_62` tinytext DEFAULT NULL,
  `ticket_custom_field_63` tinytext DEFAULT NULL,
  `ticket_custom_field_64` tinytext DEFAULT NULL,
  `ticket_custom_field_65` tinytext DEFAULT NULL,
  `ticket_custom_field_66` tinytext DEFAULT NULL,
  `ticket_custom_field_67` tinytext DEFAULT NULL,
  `ticket_custom_field_68` tinytext DEFAULT NULL,
  `ticket_custom_field_69` tinytext DEFAULT NULL,
  `ticket_custom_field_70` tinytext DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='[truncate]' ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `tickets_status`
--

CREATE TABLE `tickets_status` (
  `ticketstatus_id` int(11) NOT NULL,
  `ticketstatus_created` datetime DEFAULT NULL,
  `ticketstatus_creatorid` int(11) DEFAULT NULL,
  `ticketstatus_updated` datetime DEFAULT NULL,
  `ticketstatus_title` varchar(200) NOT NULL,
  `ticketstatus_position` int(11) NOT NULL,
  `ticketstatus_color` varchar(100) NOT NULL DEFAULT 'default' COMMENT 'default|primary|success|info|warning|danger|lime|brown',
  `ticketstatus_use_for_client_replied` varchar(10) NOT NULL DEFAULT 'no' COMMENT 'yes | no',
  `ticketstatus_use_for_team_replied` varchar(10) NOT NULL DEFAULT 'no' COMMENT 'yes | no',
  `ticketstatus_system_default` varchar(10) NOT NULL DEFAULT 'no' COMMENT 'yes | no'
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='[do not truncate]  expected to have 2 system default statuses (ID: 1 & 2) ''new'' & ''converted'' statuses ' ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `tickets_status`
--

INSERT INTO `tickets_status` (`ticketstatus_id`, `ticketstatus_created`, `ticketstatus_creatorid`, `ticketstatus_updated`, `ticketstatus_title`, `ticketstatus_position`, `ticketstatus_color`, `ticketstatus_use_for_client_replied`, `ticketstatus_use_for_team_replied`, `ticketstatus_system_default`) VALUES
(1, '2022-12-11 12:20:22', 0, '2022-12-14 16:22:30', 'Open', 1, 'info', 'yes', 'no', 'yes'),
(2, '2022-12-11 12:21:19', 0, '2022-12-14 14:31:03', 'Closed', 4, 'default', 'no', 'no', 'yes'),
(3, '2022-12-11 12:23:56', 0, '2022-12-14 14:23:53', 'On Hold', 2, 'warning', 'no', 'no', 'no'),
(4, '2022-12-11 12:24:30', 0, '2022-12-14 14:24:40', 'Answered', 3, 'success', 'no', 'yes', 'no');

-- --------------------------------------------------------

--
-- Table structure for table `ticket_replies`
--

CREATE TABLE `ticket_replies` (
  `ticketreply_id` int(11) NOT NULL,
  `ticketreply_created` datetime NOT NULL,
  `ticketreply_updated` datetime NOT NULL,
  `ticketreply_creatorid` int(11) NOT NULL,
  `ticketreply_clientid` int(11) DEFAULT NULL,
  `ticketreply_ticketid` int(11) NOT NULL,
  `ticketreply_text` text NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='[truncate]' ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `timelines`
--

CREATE TABLE `timelines` (
  `timeline_id` int(11) NOT NULL,
  `timeline_eventid` int(11) NOT NULL,
  `timeline_resourcetype` varchar(50) DEFAULT NULL COMMENT 'invoices | projects | estimates | etc',
  `timeline_resourceid` int(11) DEFAULT NULL COMMENT 'the id of the item affected'
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='[truncate]' ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `timers`
--

CREATE TABLE `timers` (
  `timer_id` int(11) NOT NULL,
  `timer_created` datetime DEFAULT NULL,
  `timer_updated` datetime DEFAULT NULL,
  `timer_creatorid` int(11) DEFAULT NULL,
  `timer_started` int(11) DEFAULT NULL COMMENT 'unix time stam for when the timer was started',
  `timer_stopped` int(11) DEFAULT 0 COMMENT 'unix timestamp for when the timer was stopped',
  `timer_time` int(11) DEFAULT 0 COMMENT 'seconds',
  `timer_taskid` int(11) DEFAULT NULL,
  `timer_projectid` int(11) DEFAULT 0 COMMENT 'needed for repository filtering',
  `timer_clientid` int(11) DEFAULT 0 COMMENT 'needed for repository filtering',
  `timer_status` varchar(20) DEFAULT 'running' COMMENT 'running | stopped',
  `timer_billing_status` varchar(50) DEFAULT 'not_invoiced' COMMENT 'invoiced | not_invoiced',
  `timer_billing_invoiceid` int(11) DEFAULT NULL COMMENT 'invoice id, if billed'
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='[truncate]' ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `units`
--

CREATE TABLE `units` (
  `unit_id` int(11) NOT NULL,
  `unit_created` datetime DEFAULT NULL,
  `unit_update` datetime DEFAULT NULL,
  `unit_creatorid` int(11) DEFAULT 1,
  `unit_name` varchar(50) NOT NULL,
  `unit_system_default` varchar(50) NOT NULL DEFAULT 'no' COMMENT 'yes|no',
  `unit_time_default` varchar(50) DEFAULT 'no' COMMENT 'yes|no (used to identify time unit)'
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='[truncate]' ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `updates`
--

CREATE TABLE `updates` (
  `update_id` int(11) NOT NULL,
  `update_created` datetime NOT NULL,
  `update_updated` datetime NOT NULL,
  `update_version` decimal(10,2) DEFAULT NULL,
  `update_mysql_filename` varchar(100) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='tracks updates sql file execution' ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `updating`
--

CREATE TABLE `updating` (
  `updating_id` int(11) NOT NULL,
  `updating_created` datetime NOT NULL,
  `updating_updated` datetime NOT NULL,
  `updating_type` varchar(100) NOT NULL COMMENT 'modal|cronjob|url',
  `updating_name` varchar(100) DEFAULT NULL COMMENT 'used for updating the record',
  `updating_function_name` varchar(150) DEFAULT NULL COMMENT '[required]  for cronjob updating. This is the name of the function',
  `updating_update_version` varchar(10) DEFAULT NULL COMMENT 'which version this update is for',
  `updating_request_path` varchar(250) DEFAULT NULL COMMENT 'e.g. /updating/action/update-currency-settings',
  `updating_update_path` varchar(250) DEFAULT NULL COMMENT 'e.g. /updating/action/update-currency-settings',
  `updating_notes` tinytext DEFAULT NULL,
  `updating_payload_1` text DEFAULT NULL,
  `updating_payload_2` text DEFAULT NULL,
  `updating_payload_3` text DEFAULT NULL,
  `updating_started_date` datetime DEFAULT NULL,
  `updating_completed_date` datetime DEFAULT NULL,
  `updating_system_log` text DEFAULT NULL COMMENT 'any comments generated by the system when running this update',
  `updating_status` varchar(50) DEFAULT 'new' COMMENT 'new|processing|failed|completed'
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `unique_id` varchar(150) DEFAULT NULL,
  `created` datetime DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `deleted` datetime DEFAULT NULL COMMENT 'date when acccount was deleted',
  `creatorid` int(11) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `first_name` varchar(100) NOT NULL,
  `last_name` varchar(100) NOT NULL,
  `phone` varchar(100) DEFAULT NULL,
  `position` varchar(255) DEFAULT NULL,
  `clientid` int(11) DEFAULT NULL COMMENT 'for client users',
  `account_owner` varchar(10) DEFAULT 'no' COMMENT 'yes | no',
  `primary_admin` varchar(10) DEFAULT 'no' COMMENT 'yes | no (only 1 primary admin - created during setup)',
  `avatar_directory` varchar(100) DEFAULT NULL,
  `avatar_filename` varchar(100) DEFAULT NULL,
  `type` varchar(150) NOT NULL COMMENT 'client | team |contact',
  `status` varchar(20) DEFAULT 'active' COMMENT 'active|suspended|deleted',
  `role_id` int(11) NOT NULL DEFAULT 2 COMMENT 'for team users',
  `last_seen` datetime DEFAULT NULL,
  `theme` varchar(100) DEFAULT 'default',
  `last_ip_address` varchar(100) DEFAULT NULL,
  `social_facebook` varchar(200) DEFAULT NULL,
  `social_twitter` varchar(200) DEFAULT NULL,
  `social_linkedin` varchar(200) DEFAULT NULL,
  `social_github` varchar(200) DEFAULT NULL,
  `social_dribble` varchar(200) DEFAULT NULL,
  `pref_language` varchar(200) DEFAULT 'english' COMMENT 'english|french|etc',
  `pref_email_notifications` varchar(10) DEFAULT 'yes' COMMENT 'yes | no',
  `pref_leftmenu_position` varchar(50) DEFAULT 'collapsed' COMMENT 'collapsed | open',
  `pref_statspanel_position` varchar(50) DEFAULT 'collapsed' COMMENT 'collapsed | open',
  `pref_filter_own_tasks` varchar(50) DEFAULT 'no' COMMENT 'Show only a users tasks in the tasks list',
  `pref_hide_completed_tasks` varchar(50) DEFAULT 'no' COMMENT 'yes | no',
  `pref_filter_own_projects` varchar(50) DEFAULT 'no' COMMENT 'Show only a users projects in the projects list',
  `pref_filter_show_archived_projects` varchar(50) DEFAULT 'no' COMMENT 'Show archived projects',
  `pref_filter_show_archived_tasks` varchar(50) DEFAULT 'no' COMMENT 'Show archived projects',
  `pref_filter_show_archived_leads` varchar(50) DEFAULT 'no' COMMENT 'Show archived projects',
  `pref_filter_show_archived_tickets` varchar(50) DEFAULT 'no' COMMENT 'Show archived tickets',
  `pref_filter_own_leads` varchar(50) DEFAULT 'no' COMMENT 'Show only a users projects in the leads list',
  `pref_view_tasks_layout` varchar(50) DEFAULT 'kanban' COMMENT 'list|kanban',
  `pref_view_leads_layout` varchar(50) DEFAULT 'kanban' COMMENT 'list|kanban',
  `pref_view_projects_layout` varchar(50) DEFAULT 'list' COMMENT 'list|card|milestone|pipeline|category|gnatt',
  `pref_theme` varchar(100) DEFAULT 'default',
  `remember_token` varchar(150) DEFAULT NULL,
  `remember_filters_tickets_status` varchar(20) DEFAULT 'disabled' COMMENT 'enabled|disabled',
  `remember_filters_tickets_payload` text DEFAULT NULL,
  `remember_filters_projects_status` varchar(20) DEFAULT 'disabled' COMMENT 'enabled|disabled',
  `remember_filters_projects_payload` text DEFAULT NULL,
  `remember_filters_invoices_status` varchar(20) DEFAULT 'disabled' COMMENT 'enabled|disabled',
  `remember_filters_invoices_payload` text DEFAULT NULL,
  `remember_filters_estimates_status` varchar(20) DEFAULT 'disabled' COMMENT 'enabled|disabled',
  `remember_filters_estimates_payload` text DEFAULT NULL,
  `remember_filters_contracts_status` varchar(20) DEFAULT 'disabled' COMMENT 'enabled|disabled',
  `remember_filters_contracts_payload` text DEFAULT NULL,
  `remember_filters_payments_status` varchar(20) DEFAULT 'disabled' COMMENT 'enabled|disabled',
  `remember_filters_payments_payload` text DEFAULT NULL,
  `remember_filters_proposals_status` varchar(20) DEFAULT 'disabled' COMMENT 'enabled|disabled',
  `remember_filters_proposals_payload` text DEFAULT NULL,
  `remember_filters_clients_status` varchar(20) DEFAULT 'disabled' COMMENT 'enabled|disabled',
  `remember_filters_clients_payload` text DEFAULT NULL,
  `remember_filters_leads_status` varchar(20) DEFAULT 'disabled' COMMENT 'enabled|disabled',
  `remember_filters_leads_payload` text DEFAULT NULL,
  `remember_filters_tasks_status` varchar(20) DEFAULT 'disabled' COMMENT 'enabled|disabled',
  `remember_filters_tasks_payload` text DEFAULT NULL,
  `remember_filters_subscriptions_status` varchar(20) DEFAULT 'disabled' COMMENT 'enabled|disabled',
  `remember_filters_subscriptions_payload` text DEFAULT NULL,
  `remember_filters_products_status` varchar(20) DEFAULT 'disabled' COMMENT 'enabled|disabled',
  `remember_filters_products_payload` text DEFAULT NULL,
  `remember_filters_expenses_status` varchar(20) DEFAULT 'disabled' COMMENT 'enabled|disabled',
  `remember_filters_expenses_payload` text DEFAULT NULL,
  `remember_filters_timesheets_status` varchar(20) DEFAULT 'disabled' COMMENT 'enabled|disabled',
  `remember_filters_timesheets_payload` text DEFAULT NULL,
  `forgot_password_token` varchar(150) DEFAULT NULL COMMENT 'random token',
  `forgot_password_token_expiry` datetime DEFAULT NULL,
  `force_password_change` varchar(10) DEFAULT 'no' COMMENT 'yes|no',
  `notifications_system` varchar(10) DEFAULT 'no' COMMENT 'no| yes | yes_email [everyone] NB: database defaults for all notifications are ''no'' actual values must be set in the settings config file',
  `notifications_new_project` varchar(10) DEFAULT 'no' COMMENT 'no| yes_email [client]',
  `notifications_projects_activity` varchar(10) DEFAULT 'no' COMMENT 'no | yes | yes_email [everyone]',
  `notifications_billing_activity` varchar(10) DEFAULT 'no' COMMENT 'no | yes | yes_email |[team]',
  `notifications_new_assignement` varchar(10) DEFAULT 'no' COMMENT 'no | yes | yes_email [team]',
  `notifications_leads_activity` varchar(10) DEFAULT 'no' COMMENT 'no | yes | yes_email [team]',
  `notifications_tasks_activity` varchar(10) DEFAULT 'no' COMMENT 'no | yes | yes_email  [everyone]',
  `notifications_tickets_activity` varchar(10) DEFAULT 'no' COMMENT 'no | yes | yes_email  [everyone]',
  `notifications_reminders` varchar(10) DEFAULT 'yes_email' COMMENT 'yes_email | no',
  `thridparty_stripe_customer_id` varchar(150) DEFAULT NULL COMMENT 'optional - when customer pays via ',
  `dashboard_access` varchar(150) DEFAULT 'yes' COMMENT 'yes|no',
  `welcome_email_sent` varchar(150) DEFAULT 'no' COMMENT 'yes|no',
  `space_uniqueid` varchar(150) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='[truncate] except user id 0 & 1' ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `unique_id`, `created`, `updated`, `deleted`, `creatorid`, `email`, `password`, `first_name`, `last_name`, `phone`, `position`, `clientid`, `account_owner`, `primary_admin`, `avatar_directory`, `avatar_filename`, `type`, `status`, `role_id`, `last_seen`, `theme`, `last_ip_address`, `social_facebook`, `social_twitter`, `social_linkedin`, `social_github`, `social_dribble`, `pref_language`, `pref_email_notifications`, `pref_leftmenu_position`, `pref_statspanel_position`, `pref_filter_own_tasks`, `pref_hide_completed_tasks`, `pref_filter_own_projects`, `pref_filter_show_archived_projects`, `pref_filter_show_archived_tasks`, `pref_filter_show_archived_leads`, `pref_filter_show_archived_tickets`, `pref_filter_own_leads`, `pref_view_tasks_layout`, `pref_view_leads_layout`, `pref_view_projects_layout`, `pref_theme`, `remember_token`, `remember_filters_tickets_status`, `remember_filters_tickets_payload`, `remember_filters_projects_status`, `remember_filters_projects_payload`, `remember_filters_invoices_status`, `remember_filters_invoices_payload`, `remember_filters_estimates_status`, `remember_filters_estimates_payload`, `remember_filters_contracts_status`, `remember_filters_contracts_payload`, `remember_filters_payments_status`, `remember_filters_payments_payload`, `remember_filters_proposals_status`, `remember_filters_proposals_payload`, `remember_filters_clients_status`, `remember_filters_clients_payload`, `remember_filters_leads_status`, `remember_filters_leads_payload`, `remember_filters_tasks_status`, `remember_filters_tasks_payload`, `remember_filters_subscriptions_status`, `remember_filters_subscriptions_payload`, `remember_filters_products_status`, `remember_filters_products_payload`, `remember_filters_expenses_status`, `remember_filters_expenses_payload`, `remember_filters_timesheets_status`, `remember_filters_timesheets_payload`, `forgot_password_token`, `forgot_password_token_expiry`, `force_password_change`, `notifications_system`, `notifications_new_project`, `notifications_projects_activity`, `notifications_billing_activity`, `notifications_new_assignement`, `notifications_leads_activity`, `notifications_tasks_activity`, `notifications_tickets_activity`, `notifications_reminders`, `thridparty_stripe_customer_id`, `dashboard_access`, `welcome_email_sent`, `space_uniqueid`) VALUES
(1, '65ce88fe2b62e4.65019590', '2024-02-15 21:58:22', '2024-02-24 18:33:00', NULL, 0, 'abc@abc.com', '$2y$10$glrJsKtILnV7SKTt9ZsVsOmPrSQnH6gmK10GNQA5u/Dr0DZTfnjCS', 'Lamtans', '.', NULL, NULL, NULL, 'no', 'yes', NULL, NULL, 'team', 'active', 1, '2024-02-24 18:33:00', 'default', '2400:adc1:15d:1300:c4bc:cb06:243b:59db', NULL, NULL, NULL, NULL, NULL, 'english', 'yes', 'open', 'collapsed', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'kanban', 'kanban', 'list', 'default', 'vz4XKuhn511YYUMtXEigzERKQUMWGmxCMlKXVZbTmuGO71lZ39wTQgPsllcI', 'disabled', NULL, 'disabled', NULL, 'disabled', NULL, 'disabled', NULL, 'disabled', NULL, 'disabled', NULL, 'disabled', NULL, 'disabled', NULL, 'disabled', NULL, 'disabled', NULL, 'disabled', NULL, 'disabled', NULL, 'disabled', NULL, 'disabled', NULL, NULL, NULL, 'no', 'yes_email', 'no', 'yes_email', 'yes_email', 'yes_email', 'yes_email', 'yes_email', 'yes_email', 'yes_email', NULL, 'yes', 'no', NULL),
(2, '65ce8980706a13.14308432', '2024-02-15 23:00:32', '2024-02-15 23:00:32', NULL, 1, 'taha18944@gmail.com', '$2y$10$qMEU6Ap3X.Wh.X9cNeuineB7SaBHN/g.opgkCMJ6rSYHl1/CWXuUe', 'Talha', 'anwer', NULL, NULL, 1, 'yes', 'no', NULL, NULL, 'client', 'active', 2, NULL, 'default', NULL, NULL, NULL, NULL, NULL, NULL, 'english', 'yes', 'collapsed', 'collapsed', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'kanban', 'kanban', 'list', 'default', NULL, 'disabled', NULL, 'disabled', NULL, 'disabled', NULL, 'disabled', NULL, 'disabled', NULL, 'disabled', NULL, 'disabled', NULL, 'disabled', NULL, 'disabled', NULL, 'disabled', NULL, 'disabled', NULL, 'disabled', NULL, 'disabled', NULL, 'disabled', NULL, NULL, NULL, 'yes', 'yes_email', 'yes_email', 'yes_email', 'yes_email', 'yes_email', 'no', 'yes_email', 'yes_email', 'yes_email', NULL, 'no', 'no', NULL),
(3, '65cfe68d3dc9e9.51599823', '2024-02-16 23:49:49', '2024-02-16 23:49:49', NULL, 1, 'test@test12.com', '$2y$10$96gMKPzbh/5/ho5myYmI1e6.f8GYdG/Ppp/TNuPDrVDj6ssX057Ym', 'ddd', 'fdsds', '7872309108', NULL, 2, 'yes', 'no', NULL, NULL, 'client', 'active', 2, NULL, 'default', NULL, NULL, NULL, NULL, NULL, NULL, 'english', 'yes', 'collapsed', 'collapsed', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'kanban', 'kanban', 'list', 'default', NULL, 'disabled', NULL, 'disabled', NULL, 'disabled', NULL, 'disabled', NULL, 'disabled', NULL, 'disabled', NULL, 'disabled', NULL, 'disabled', NULL, 'disabled', NULL, 'disabled', NULL, 'disabled', NULL, 'disabled', NULL, 'disabled', NULL, 'disabled', NULL, NULL, NULL, 'yes', 'yes_email', 'yes_email', 'yes_email', 'yes_email', 'yes_email', 'no', 'yes_email', 'yes_email', 'yes_email', NULL, 'no', 'no', NULL),
(4, '65d0faf5c40a22.80030011', '2024-02-17 18:29:09', '2024-02-17 18:29:09', NULL, 1, 'dontknow@hotmail.com', '$2y$10$jQNRWQlG.4nIwL9d35G4f.G8nr2GZH4kJxlfZn/fOQ2M1ISdoHhAS', 'lamtans01', 'test', NULL, NULL, NULL, 'no', 'no', NULL, NULL, 'team', 'active', 3, NULL, 'default', NULL, NULL, NULL, NULL, NULL, NULL, 'english', 'yes', 'collapsed', 'collapsed', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'kanban', 'kanban', 'list', 'default', NULL, 'disabled', NULL, 'disabled', NULL, 'disabled', NULL, 'disabled', NULL, 'disabled', NULL, 'disabled', NULL, 'disabled', NULL, 'disabled', NULL, 'disabled', NULL, 'disabled', NULL, 'disabled', NULL, 'disabled', NULL, 'disabled', NULL, 'disabled', NULL, NULL, NULL, 'yes', 'yes_email', 'no', 'yes_email', 'yes_email', 'yes_email', 'yes_email', 'yes_email', 'yes_email', 'yes_email', NULL, 'no', 'no', '65d0faf5c4b856.43453283');

-- --------------------------------------------------------

--
-- Table structure for table `webforms`
--

CREATE TABLE `webforms` (
  `webform_id` int(11) NOT NULL,
  `webform_uniqueid` varchar(100) DEFAULT NULL,
  `webform_created` datetime NOT NULL,
  `webform_updated` datetime NOT NULL,
  `webform_creatorid` int(11) NOT NULL,
  `webform_title` varchar(100) DEFAULT NULL,
  `webform_type` varchar(100) DEFAULT NULL COMMENT 'lead|etc',
  `webform_builder_payload` text DEFAULT NULL COMMENT 'json object from form builder',
  `webform_thankyou_message` text DEFAULT NULL,
  `webform_notify_assigned` varchar(10) DEFAULT 'no' COMMENT 'yes|no',
  `webform_notify_admin` varchar(10) DEFAULT 'no' COMMENT 'yes|no',
  `webform_submissions` tinyint(4) DEFAULT 0,
  `webform_user_captcha` varchar(10) DEFAULT 'no' COMMENT 'yes|no',
  `webform_submit_button_text` varchar(100) DEFAULT NULL,
  `webform_background_color` varchar(100) DEFAULT '#FFFFFF' COMMENT 'white default',
  `webform_lead_title` varchar(100) DEFAULT NULL,
  `webform_status` varchar(100) DEFAULT 'enabled' COMMENT 'enabled|disabled'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `webforms_assigned`
--

CREATE TABLE `webforms_assigned` (
  `webformassigned_id` int(11) NOT NULL,
  `webformassigned_created` datetime NOT NULL,
  `webformassigned_updated` datetime NOT NULL,
  `webformassigned_formid` int(11) DEFAULT NULL,
  `webformassigned_userid` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `webhooks`
--

CREATE TABLE `webhooks` (
  `webhooks_id` int(11) NOT NULL,
  `webhooks_created` datetime NOT NULL,
  `webhooks_updated` datetime NOT NULL,
  `webhooks_creatorid` int(11) DEFAULT 0,
  `webhooks_gateway_name` varchar(100) DEFAULT NULL COMMENT 'stripe|paypal|etc',
  `webhooks_type` varchar(100) DEFAULT NULL COMMENT 'type of call, as sent by gateway',
  `webhooks_payment_type` varchar(30) DEFAULT NULL COMMENT 'onetime|subscription',
  `webhooks_payment_amount` decimal(10,2) DEFAULT NULL COMMENT '(optional)',
  `webhooks_payment_transactionid` varchar(150) DEFAULT NULL COMMENT 'payment transaction id',
  `webhooks_matching_reference` varchar(100) DEFAULT NULL COMMENT 'e.g. Stripe (checkout session id) | Paypal ( random string) that is used to match the webhook/ipn to the initial payment_session',
  `webhooks_matching_attribute` varchar(100) DEFAULT NULL COMMENT 'mainly used to record what is happening with a subscription (e.g cancelled|renewed)',
  `webhooks_payload` text DEFAULT NULL COMMENT '(optional) json payload',
  `webhooks_comment` text DEFAULT NULL COMMENT '(optional)',
  `webhooks_started_at` datetime DEFAULT NULL COMMENT 'when the cronjob started this webhook',
  `webhooks_completed_at` datetime DEFAULT NULL COMMENT 'when the cronjob completed this webhook',
  `webhooks_attempts` tinyint(4) DEFAULT 0 COMMENT 'the number of times this webhook has been attempted',
  `webhooks_status` varchar(20) DEFAULT 'new' COMMENT 'new | processing | failed | completed   (set to processing by the cronjob, to avoid duplicate processing)'
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='Record all actionable webhooks, for later execution by a cronjob' ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `webmail_templates`
--

CREATE TABLE `webmail_templates` (
  `webmail_template_id` int(11) NOT NULL,
  `webmail_template_created` datetime NOT NULL,
  `webmail_template_updated` datetime NOT NULL,
  `webmail_template_creatorid` int(11) NOT NULL,
  `webmail_template_name` varchar(150) DEFAULT NULL,
  `webmail_template_body` text DEFAULT NULL,
  `webmail_template_type` text DEFAULT NULL COMMENT 'clients|leads'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci ROW_FORMAT=DYNAMIC;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `attachments`
--
ALTER TABLE `attachments`
  ADD PRIMARY KEY (`attachment_id`) USING BTREE;

--
-- Indexes for table `automation_assigned`
--
ALTER TABLE `automation_assigned`
  ADD PRIMARY KEY (`automationassigned_id`) USING BTREE;

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`category_id`) USING BTREE,
  ADD KEY `category_type` (`category_type`) USING BTREE,
  ADD KEY `category_creatorid` (`category_creatorid`) USING BTREE;

--
-- Indexes for table `category_users`
--
ALTER TABLE `category_users`
  ADD PRIMARY KEY (`categoryuser_id`) USING BTREE;

--
-- Indexes for table `checklists`
--
ALTER TABLE `checklists`
  ADD PRIMARY KEY (`checklist_id`) USING BTREE,
  ADD KEY `checklistresource_type` (`checklistresource_type`) USING BTREE,
  ADD KEY `checklistresource_id` (`checklistresource_id`) USING BTREE,
  ADD KEY `checklist_creatorid` (`checklist_creatorid`) USING BTREE,
  ADD KEY `checklist_clientid` (`checklist_clientid`) USING BTREE,
  ADD KEY `checklist_status` (`checklist_status`) USING BTREE;

--
-- Indexes for table `clients`
--
ALTER TABLE `clients`
  ADD PRIMARY KEY (`client_id`) USING BTREE,
  ADD KEY `client_creatorid` (`client_creatorid`) USING BTREE,
  ADD KEY `client_categoryid` (`client_categoryid`) USING BTREE,
  ADD KEY `client_status` (`client_status`) USING BTREE,
  ADD KEY `client_created_from_leadid` (`client_created_from_leadid`) USING BTREE,
  ADD KEY `client_app_modules` (`client_app_modules`) USING BTREE,
  ADD KEY `client_importid` (`client_importid`) USING BTREE;

--
-- Indexes for table `comments`
--
ALTER TABLE `comments`
  ADD PRIMARY KEY (`comment_id`) USING BTREE,
  ADD KEY `comment_creatorid` (`comment_creatorid`) USING BTREE,
  ADD KEY `comment_clientid` (`comment_clientid`) USING BTREE,
  ADD KEY `commentresource_type` (`commentresource_type`) USING BTREE,
  ADD KEY `commentresource_id` (`commentresource_id`) USING BTREE;

--
-- Indexes for table `contracts`
--
ALTER TABLE `contracts`
  ADD PRIMARY KEY (`doc_id`) USING BTREE;

--
-- Indexes for table `contract_templates`
--
ALTER TABLE `contract_templates`
  ADD PRIMARY KEY (`contract_template_id`) USING BTREE,
  ADD KEY `contract_template_creatorid` (`contract_template_creatorid`) USING BTREE;

--
-- Indexes for table `cs_affiliate_earnings`
--
ALTER TABLE `cs_affiliate_earnings`
  ADD PRIMARY KEY (`cs_affiliate_earning_id`) USING BTREE;

--
-- Indexes for table `cs_affiliate_projects`
--
ALTER TABLE `cs_affiliate_projects`
  ADD PRIMARY KEY (`cs_affiliate_project_id`) USING BTREE;

--
-- Indexes for table `cs_events`
--
ALTER TABLE `cs_events`
  ADD PRIMARY KEY (`cs_event_id`) USING BTREE;

--
-- Indexes for table `customfields`
--
ALTER TABLE `customfields`
  ADD PRIMARY KEY (`customfields_id`) USING BTREE;

--
-- Indexes for table `email_log`
--
ALTER TABLE `email_log`
  ADD PRIMARY KEY (`emaillog_id`) USING BTREE;

--
-- Indexes for table `email_queue`
--
ALTER TABLE `email_queue`
  ADD PRIMARY KEY (`emailqueue_id`) USING BTREE,
  ADD KEY `emailqueue_type` (`emailqueue_type`) USING BTREE,
  ADD KEY `emailqueue_resourcetype` (`emailqueue_resourcetype`) USING BTREE,
  ADD KEY `emailqueue_resourceid` (`emailqueue_resourceid`) USING BTREE,
  ADD KEY `emailqueue_pdf_resource_type` (`emailqueue_pdf_resource_type`) USING BTREE,
  ADD KEY `emailqueue_pdf_resource_id` (`emailqueue_pdf_resource_id`) USING BTREE,
  ADD KEY `emailqueue_status` (`emailqueue_status`) USING BTREE;

--
-- Indexes for table `email_templates`
--
ALTER TABLE `email_templates`
  ADD PRIMARY KEY (`emailtemplate_id`) USING BTREE,
  ADD KEY `emailtemplate_type` (`emailtemplate_type`) USING BTREE,
  ADD KEY `emailtemplate_category` (`emailtemplate_category`) USING BTREE;

--
-- Indexes for table `estimates`
--
ALTER TABLE `estimates`
  ADD PRIMARY KEY (`bill_estimateid`) USING BTREE,
  ADD KEY `bill_clientid` (`bill_clientid`) USING BTREE,
  ADD KEY `bill_creatorid` (`bill_creatorid`) USING BTREE,
  ADD KEY `bill_categoryid` (`bill_categoryid`) USING BTREE,
  ADD KEY `bill_status` (`bill_status`) USING BTREE,
  ADD KEY `bill_type` (`bill_type`) USING BTREE,
  ADD KEY `bill_visibility` (`bill_visibility`) USING BTREE,
  ADD KEY `bill_viewed_by_client` (`bill_viewed_by_client`) USING BTREE;

--
-- Indexes for table `events`
--
ALTER TABLE `events`
  ADD PRIMARY KEY (`event_id`) USING BTREE,
  ADD KEY `eventresource_type` (`eventresource_type`) USING BTREE,
  ADD KEY `eventresource_id` (`eventresource_id`) USING BTREE,
  ADD KEY `event_creatorid` (`event_creatorid`) USING BTREE,
  ADD KEY `event_type` (`event_item`) USING BTREE,
  ADD KEY `event_parent_type` (`event_parent_type`) USING BTREE,
  ADD KEY `event_parent_id` (`event_parent_id`) USING BTREE,
  ADD KEY `event_item_id` (`event_item_id`) USING BTREE;

--
-- Indexes for table `events_tracking`
--
ALTER TABLE `events_tracking`
  ADD PRIMARY KEY (`eventtracking_id`) USING BTREE,
  ADD KEY `eventtracking_userid` (`eventtracking_userid`) USING BTREE,
  ADD KEY `eventtracking_eventid` (`eventtracking_eventid`) USING BTREE,
  ADD KEY `eventtracking_status` (`eventtracking_status`) USING BTREE,
  ADD KEY `parent_type` (`parent_type`) USING BTREE,
  ADD KEY `parent_id` (`parent_id`) USING BTREE,
  ADD KEY `resource_type` (`resource_type`) USING BTREE,
  ADD KEY `resource_id` (`resource_id`) USING BTREE;

--
-- Indexes for table `expenses`
--
ALTER TABLE `expenses`
  ADD PRIMARY KEY (`expense_id`) USING BTREE,
  ADD KEY `expense_clientid` (`expense_clientid`) USING BTREE,
  ADD KEY `expense_projectid` (`expense_projectid`) USING BTREE,
  ADD KEY `expense_creatorid` (`expense_creatorid`) USING BTREE,
  ADD KEY `expense_billable` (`expense_billable`) USING BTREE,
  ADD KEY `expense_billing_status` (`expense_billing_status`) USING BTREE,
  ADD KEY `expense_billable_invoiceid` (`expense_billable_invoiceid`) USING BTREE;

--
-- Indexes for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`) USING BTREE;

--
-- Indexes for table `files`
--
ALTER TABLE `files`
  ADD PRIMARY KEY (`file_id`) USING BTREE,
  ADD KEY `file_creatorid` (`file_creatorid`) USING BTREE,
  ADD KEY `file_clientid` (`file_clientid`) USING BTREE,
  ADD KEY `fileresource_type` (`fileresource_type`) USING BTREE,
  ADD KEY `fileresource_id` (`fileresource_id`) USING BTREE;

--
-- Indexes for table `file_folders`
--
ALTER TABLE `file_folders`
  ADD PRIMARY KEY (`filefolder_id`) USING BTREE;

--
-- Indexes for table `invoices`
--
ALTER TABLE `invoices`
  ADD PRIMARY KEY (`bill_invoiceid`) USING BTREE,
  ADD KEY `invoice_clientid` (`bill_clientid`) USING BTREE,
  ADD KEY `invoice_projectid` (`bill_projectid`) USING BTREE,
  ADD KEY `invoice_creatorid` (`bill_creatorid`) USING BTREE,
  ADD KEY `invoice_categoryid` (`bill_categoryid`) USING BTREE,
  ADD KEY `invoice_status` (`bill_status`) USING BTREE,
  ADD KEY `invoice_recurring` (`bill_recurring`) USING BTREE,
  ADD KEY `bill_type` (`bill_type`) USING BTREE,
  ADD KEY `bill_invoice_type` (`bill_invoice_type`) USING BTREE,
  ADD KEY `bill_subscriptionid` (`bill_subscriptionid`) USING BTREE,
  ADD KEY `bill_recurring_parent_id` (`bill_recurring_parent_id`) USING BTREE,
  ADD KEY `bill_visibility` (`bill_visibility`) USING BTREE,
  ADD KEY `bill_cron_status` (`bill_cron_status`) USING BTREE,
  ADD KEY `bill_viewed_by_client` (`bill_viewed_by_client`) USING BTREE;

--
-- Indexes for table `items`
--
ALTER TABLE `items`
  ADD PRIMARY KEY (`item_id`) USING BTREE,
  ADD KEY `item_categoryid` (`item_categoryid`) USING BTREE;

--
-- Indexes for table `jobs`
--
ALTER TABLE `jobs`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD KEY `jobs_queue_index` (`queue`(191)) USING BTREE;

--
-- Indexes for table `kb_categories`
--
ALTER TABLE `kb_categories`
  ADD PRIMARY KEY (`kbcategory_id`) USING BTREE;

--
-- Indexes for table `knowledgebase`
--
ALTER TABLE `knowledgebase`
  ADD PRIMARY KEY (`knowledgebase_id`) USING BTREE,
  ADD KEY `knowledgebase_categoryid` (`knowledgebase_categoryid`) USING BTREE;

--
-- Indexes for table `leads`
--
ALTER TABLE `leads`
  ADD PRIMARY KEY (`lead_id`) USING BTREE,
  ADD KEY `lead_creatorid` (`lead_creatorid`) USING BTREE,
  ADD KEY `lead_categoryid` (`lead_categoryid`) USING BTREE,
  ADD KEY `lead_email` (`lead_email`) USING BTREE,
  ADD KEY `lead_status` (`lead_status`) USING BTREE,
  ADD KEY `lead_converted_clientid` (`lead_converted_clientid`) USING BTREE,
  ADD KEY `lead_active_state` (`lead_active_state`) USING BTREE,
  ADD KEY `lead_visibility` (`lead_visibility`) USING BTREE;

--
-- Indexes for table `leads_assigned`
--
ALTER TABLE `leads_assigned`
  ADD PRIMARY KEY (`leadsassigned_id`) USING BTREE,
  ADD KEY `leadsassigned_userid` (`leadsassigned_userid`) USING BTREE,
  ADD KEY `leadsassigned_leadid` (`leadsassigned_leadid`) USING BTREE;

--
-- Indexes for table `leads_sources`
--
ALTER TABLE `leads_sources`
  ADD PRIMARY KEY (`leadsources_id`) USING BTREE;

--
-- Indexes for table `leads_status`
--
ALTER TABLE `leads_status`
  ADD PRIMARY KEY (`leadstatus_id`) USING BTREE;

--
-- Indexes for table `lineitems`
--
ALTER TABLE `lineitems`
  ADD PRIMARY KEY (`lineitem_id`) USING BTREE,
  ADD KEY `lineitemresource_linked_type` (`lineitemresource_linked_type`) USING BTREE,
  ADD KEY `lineitemresource_linked_id` (`lineitemresource_linked_id`) USING BTREE,
  ADD KEY `lineitemresource_type` (`lineitemresource_type`) USING BTREE,
  ADD KEY `lineitemresource_id` (`lineitemresource_id`) USING BTREE,
  ADD KEY `lineitem_type` (`lineitem_type`) USING BTREE;

--
-- Indexes for table `logs`
--
ALTER TABLE `logs`
  ADD PRIMARY KEY (`log_id`) USING BTREE;

--
-- Indexes for table `messages`
--
ALTER TABLE `messages`
  ADD PRIMARY KEY (`message_id`) USING BTREE,
  ADD KEY `message_status` (`message_status`) USING BTREE,
  ADD KEY `message_creatorid` (`message_creatorid`) USING BTREE,
  ADD KEY `message_creator_uniqueid` (`message_creator_uniqueid`) USING BTREE,
  ADD KEY `message_target_uniqueid` (`message_target_uniqueid`) USING BTREE,
  ADD KEY `message_type` (`message_type`) USING BTREE,
  ADD KEY `message_source` (`message_source`) USING BTREE,
  ADD KEY `message_target` (`message_target`) USING BTREE;

--
-- Indexes for table `messages_tracking`
--
ALTER TABLE `messages_tracking`
  ADD PRIMARY KEY (`messagestracking_id`) USING BTREE,
  ADD KEY `messagetracking_target` (`messagestracking_target`) USING BTREE,
  ADD KEY `messagestracking_target` (`messagestracking_target`) USING BTREE,
  ADD KEY `messagestracking_user_unique_id` (`messagestracking_user_unique_id`) USING BTREE;

--
-- Indexes for table `milestones`
--
ALTER TABLE `milestones`
  ADD PRIMARY KEY (`milestone_id`) USING BTREE,
  ADD KEY `milestone_projectid` (`milestone_projectid`) USING BTREE,
  ADD KEY `milestone_creatorid` (`milestone_creatorid`) USING BTREE,
  ADD KEY `milestone_type` (`milestone_type`) USING BTREE;

--
-- Indexes for table `milestone_categories`
--
ALTER TABLE `milestone_categories`
  ADD PRIMARY KEY (`milestonecategory_id`) USING BTREE;

--
-- Indexes for table `notes`
--
ALTER TABLE `notes`
  ADD PRIMARY KEY (`note_id`) USING BTREE,
  ADD KEY `note_creatorid` (`note_creatorid`) USING BTREE,
  ADD KEY `noteresource_type` (`noteresource_type`) USING BTREE,
  ADD KEY `noteresource_id` (`noteresource_id`) USING BTREE;

--
-- Indexes for table `payments`
--
ALTER TABLE `payments`
  ADD PRIMARY KEY (`payment_id`) USING BTREE,
  ADD KEY `payment_creatorid` (`payment_creatorid`) USING BTREE,
  ADD KEY `payment_invoiceid` (`payment_invoiceid`) USING BTREE,
  ADD KEY `payment_clientid` (`payment_clientid`) USING BTREE,
  ADD KEY `payment_projectid` (`payment_projectid`) USING BTREE,
  ADD KEY `payment_gateway` (`payment_gateway`) USING BTREE,
  ADD KEY `payment_subscriptionid` (`payment_subscriptionid`) USING BTREE;

--
-- Indexes for table `payment_sessions`
--
ALTER TABLE `payment_sessions`
  ADD PRIMARY KEY (`session_id`) USING BTREE,
  ADD KEY `session_gateway_name` (`session_gateway_name`) USING BTREE,
  ADD KEY `session_gateway_ref` (`session_gateway_ref`) USING BTREE;

--
-- Indexes for table `product_tasks`
--
ALTER TABLE `product_tasks`
  ADD PRIMARY KEY (`product_task_id`) USING BTREE;

--
-- Indexes for table `product_tasks_dependencies`
--
ALTER TABLE `product_tasks_dependencies`
  ADD PRIMARY KEY (`product_task_dependency_id`) USING BTREE,
  ADD KEY `product_task_dependency_taskid` (`product_task_dependency_taskid`) USING BTREE,
  ADD KEY `product_task_dependency_blockerid` (`product_task_dependency_blockerid`) USING BTREE,
  ADD KEY `product_task_dependency_type` (`product_task_dependency_type`) USING BTREE;

--
-- Indexes for table `projects`
--
ALTER TABLE `projects`
  ADD PRIMARY KEY (`project_id`) USING BTREE,
  ADD KEY `FK_projects` (`project_clientid`) USING BTREE,
  ADD KEY `project_creatorid` (`project_creatorid`) USING BTREE,
  ADD KEY `project_categoryid` (`project_categoryid`) USING BTREE,
  ADD KEY `project_status` (`project_status`) USING BTREE,
  ADD KEY `project_visibility` (`project_visibility`) USING BTREE,
  ADD KEY `project_type` (`project_type`) USING BTREE,
  ADD KEY `project_active_state` (`project_active_state`) USING BTREE,
  ADD KEY `project_billing_type` (`project_billing_type`) USING BTREE,
  ADD KEY `clientperm_tasks_view` (`clientperm_tasks_view`) USING BTREE,
  ADD KEY `project_progress_manually` (`project_progress_manually`) USING BTREE,
  ADD KEY `clientperm_tasks_collaborate` (`clientperm_tasks_collaborate`) USING BTREE,
  ADD KEY `clientperm_tasks_create` (`clientperm_tasks_create`) USING BTREE,
  ADD KEY `clientperm_timesheets_view` (`clientperm_timesheets_view`) USING BTREE,
  ADD KEY `clientperm_expenses_view` (`clientperm_expenses_view`) USING BTREE,
  ADD KEY `assignedperm_milestone_manage` (`assignedperm_milestone_manage`) USING BTREE,
  ADD KEY `assignedperm_tasks_collaborate` (`assignedperm_tasks_collaborate`) USING BTREE;

--
-- Indexes for table `projects_assigned`
--
ALTER TABLE `projects_assigned`
  ADD PRIMARY KEY (`projectsassigned_id`) USING BTREE,
  ADD KEY `projectsassigned_projectid` (`projectsassigned_projectid`) USING BTREE,
  ADD KEY `projectsassigned_userid` (`projectsassigned_userid`) USING BTREE;

--
-- Indexes for table `projects_manager`
--
ALTER TABLE `projects_manager`
  ADD PRIMARY KEY (`projectsmanager_id`) USING BTREE,
  ADD KEY `projectsmanager_userid` (`projectsmanager_userid`) USING BTREE,
  ADD KEY `projectsmanager_projectid` (`projectsmanager_projectid`) USING BTREE;

--
-- Indexes for table `proposals`
--
ALTER TABLE `proposals`
  ADD PRIMARY KEY (`doc_id`) USING BTREE;

--
-- Indexes for table `proposal_templates`
--
ALTER TABLE `proposal_templates`
  ADD PRIMARY KEY (`proposal_template_id`) USING BTREE,
  ADD KEY `proposal_template_creatorid` (`proposal_template_creatorid`) USING BTREE;

--
-- Indexes for table `reminders`
--
ALTER TABLE `reminders`
  ADD PRIMARY KEY (`reminder_id`) USING BTREE,
  ADD KEY `reminderresource_type` (`reminderresource_type`) USING BTREE,
  ADD KEY `reminderresource_id` (`reminderresource_id`) USING BTREE,
  ADD KEY `reminder_status` (`reminder_status`) USING BTREE,
  ADD KEY `reminder_sent` (`reminder_sent`) USING BTREE;

--
-- Indexes for table `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`role_id`) USING BTREE,
  ADD KEY `role_type` (`role_type`) USING BTREE;

--
-- Indexes for table `settings`
--
ALTER TABLE `settings`
  ADD PRIMARY KEY (`settings_id`) USING BTREE;

--
-- Indexes for table `settings2`
--
ALTER TABLE `settings2`
  ADD PRIMARY KEY (`settings2_id`) USING BTREE;

--
-- Indexes for table `subscriptions`
--
ALTER TABLE `subscriptions`
  ADD PRIMARY KEY (`subscription_id`) USING BTREE,
  ADD KEY `subscription_gateway_id` (`subscription_gateway_id`) USING BTREE,
  ADD KEY `subscription_gateway_product` (`subscription_gateway_product`) USING BTREE,
  ADD KEY `subscription_gateway_price` (`subscription_gateway_price`) USING BTREE,
  ADD KEY `subscription_creatorid` (`subscription_creatorid`) USING BTREE,
  ADD KEY `subscription_clientid` (`subscription_clientid`) USING BTREE,
  ADD KEY `subscription_projectid` (`subscription_projectid`) USING BTREE,
  ADD KEY `subscription_categoryid` (`subscription_categoryid`) USING BTREE,
  ADD KEY `subscription_status` (`subscription_status`) USING BTREE,
  ADD KEY `subscription_visibility` (`subscription_visibility`) USING BTREE;

--
-- Indexes for table `tableconfig`
--
ALTER TABLE `tableconfig`
  ADD PRIMARY KEY (`tableconfig_id`) USING BTREE,
  ADD KEY `tableconfig_userid` (`tableconfig_userid`) USING BTREE,
  ADD KEY `tableconfig_table_name` (`tableconfig_table_name`) USING BTREE;

--
-- Indexes for table `tags`
--
ALTER TABLE `tags`
  ADD PRIMARY KEY (`tag_id`) USING BTREE,
  ADD KEY `tag_creatorid` (`tag_creatorid`) USING BTREE,
  ADD KEY `tagresource_type` (`tagresource_type`) USING BTREE,
  ADD KEY `tag_visibility` (`tag_visibility`) USING BTREE,
  ADD KEY `tagresource_id` (`tagresource_id`) USING BTREE;

--
-- Indexes for table `tasks`
--
ALTER TABLE `tasks`
  ADD PRIMARY KEY (`task_id`) USING BTREE,
  ADD KEY `task_creatorid` (`task_creatorid`) USING BTREE,
  ADD KEY `task_clientid` (`task_clientid`) USING BTREE,
  ADD KEY `task_billable` (`task_billable`) USING BTREE,
  ADD KEY `task_milestoneid` (`task_milestoneid`) USING BTREE,
  ADD KEY `taskresource_id` (`task_projectid`) USING BTREE,
  ADD KEY `task_visibility` (`task_visibility`) USING BTREE,
  ADD KEY `task_client_visibility` (`task_client_visibility`) USING BTREE,
  ADD KEY `task_importid` (`task_importid`) USING BTREE,
  ADD KEY `task_active_state` (`task_active_state`) USING BTREE,
  ADD KEY `task_billable_status` (`task_billable_status`) USING BTREE,
  ADD KEY `task_billable_invoiceid` (`task_billable_invoiceid`) USING BTREE,
  ADD KEY `task_billable_lineitemid` (`task_billable_lineitemid`) USING BTREE,
  ADD KEY `task_recurring` (`task_recurring`) USING BTREE,
  ADD KEY `task_recurring_parent_id` (`task_recurring_parent_id`) USING BTREE,
  ADD KEY `task_recurring_finished` (`task_recurring_finished`) USING BTREE;

--
-- Indexes for table `tasks_assigned`
--
ALTER TABLE `tasks_assigned`
  ADD PRIMARY KEY (`tasksassigned_id`) USING BTREE,
  ADD KEY `tasksassigned_taskid` (`tasksassigned_taskid`) USING BTREE,
  ADD KEY `tasksassigned_userid` (`tasksassigned_userid`) USING BTREE;

--
-- Indexes for table `tasks_dependencies`
--
ALTER TABLE `tasks_dependencies`
  ADD PRIMARY KEY (`tasksdependency_id`) USING BTREE,
  ADD KEY `tasksdependency_projectid` (`tasksdependency_projectid`) USING BTREE,
  ADD KEY `tasksdependency_clientid` (`tasksdependency_clientid`) USING BTREE,
  ADD KEY `tasksdependency_taskid` (`tasksdependency_taskid`) USING BTREE,
  ADD KEY `tasksdependency_blockerid` (`tasksdependency_blockerid`) USING BTREE,
  ADD KEY `tasksdependency_type` (`tasksdependency_type`) USING BTREE;

--
-- Indexes for table `tasks_priority`
--
ALTER TABLE `tasks_priority`
  ADD PRIMARY KEY (`taskpriority_id`) USING BTREE;

--
-- Indexes for table `tasks_status`
--
ALTER TABLE `tasks_status`
  ADD PRIMARY KEY (`taskstatus_id`) USING BTREE;

--
-- Indexes for table `tax`
--
ALTER TABLE `tax`
  ADD PRIMARY KEY (`tax_id`) USING BTREE,
  ADD KEY `taxresource_type` (`taxresource_type`) USING BTREE,
  ADD KEY `taxresource_id` (`taxresource_id`) USING BTREE;

--
-- Indexes for table `taxrates`
--
ALTER TABLE `taxrates`
  ADD PRIMARY KEY (`taxrate_id`) USING BTREE;

--
-- Indexes for table `tickets`
--
ALTER TABLE `tickets`
  ADD PRIMARY KEY (`ticket_id`) USING BTREE,
  ADD KEY `ticket_creatorid` (`ticket_creatorid`) USING BTREE,
  ADD KEY `ticket_categoryid` (`ticket_categoryid`) USING BTREE,
  ADD KEY `ticket_clientid` (`ticket_clientid`) USING BTREE,
  ADD KEY `ticket_projectid` (`ticket_projectid`) USING BTREE,
  ADD KEY `ticket_priority` (`ticket_priority`) USING BTREE,
  ADD KEY `ticket_status` (`ticket_status`) USING BTREE;

--
-- Indexes for table `tickets_status`
--
ALTER TABLE `tickets_status`
  ADD PRIMARY KEY (`ticketstatus_id`) USING BTREE;

--
-- Indexes for table `ticket_replies`
--
ALTER TABLE `ticket_replies`
  ADD PRIMARY KEY (`ticketreply_id`) USING BTREE,
  ADD KEY `ticketreply_creatorid` (`ticketreply_creatorid`) USING BTREE,
  ADD KEY `ticketreply_ticketid` (`ticketreply_ticketid`) USING BTREE,
  ADD KEY `ticketreply_clientid` (`ticketreply_clientid`) USING BTREE;

--
-- Indexes for table `timelines`
--
ALTER TABLE `timelines`
  ADD PRIMARY KEY (`timeline_id`) USING BTREE,
  ADD KEY `timeline_eventid` (`timeline_eventid`) USING BTREE,
  ADD KEY `timeline_resourcetype` (`timeline_resourcetype`) USING BTREE,
  ADD KEY `timeline_resourceid` (`timeline_resourceid`) USING BTREE;

--
-- Indexes for table `timers`
--
ALTER TABLE `timers`
  ADD PRIMARY KEY (`timer_id`) USING BTREE,
  ADD KEY `timer_creatorid` (`timer_creatorid`) USING BTREE,
  ADD KEY `timer_taskid` (`timer_taskid`) USING BTREE,
  ADD KEY `timer_projectid` (`timer_projectid`) USING BTREE,
  ADD KEY `timer_clientid` (`timer_clientid`) USING BTREE,
  ADD KEY `timer_status` (`timer_status`) USING BTREE,
  ADD KEY `timer_billing_status` (`timer_billing_status`) USING BTREE,
  ADD KEY `timer_billing_invoiceid` (`timer_billing_invoiceid`) USING BTREE;

--
-- Indexes for table `units`
--
ALTER TABLE `units`
  ADD PRIMARY KEY (`unit_id`) USING BTREE;

--
-- Indexes for table `updates`
--
ALTER TABLE `updates`
  ADD PRIMARY KEY (`update_id`) USING BTREE;

--
-- Indexes for table `updating`
--
ALTER TABLE `updating`
  ADD PRIMARY KEY (`updating_id`) USING BTREE;

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD KEY `clientid` (`clientid`) USING BTREE,
  ADD KEY `primary_contact` (`account_owner`) USING BTREE,
  ADD KEY `type` (`type`) USING BTREE,
  ADD KEY `role_id` (`role_id`) USING BTREE,
  ADD KEY `email` (`email`) USING BTREE,
  ADD KEY `dashboard_access` (`dashboard_access`) USING BTREE;

--
-- Indexes for table `webforms`
--
ALTER TABLE `webforms`
  ADD PRIMARY KEY (`webform_id`) USING BTREE;

--
-- Indexes for table `webforms_assigned`
--
ALTER TABLE `webforms_assigned`
  ADD PRIMARY KEY (`webformassigned_id`) USING BTREE;

--
-- Indexes for table `webhooks`
--
ALTER TABLE `webhooks`
  ADD PRIMARY KEY (`webhooks_id`) USING BTREE;

--
-- Indexes for table `webmail_templates`
--
ALTER TABLE `webmail_templates`
  ADD PRIMARY KEY (`webmail_template_id`) USING BTREE;

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `attachments`
--
ALTER TABLE `attachments`
  MODIFY `attachment_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `automation_assigned`
--
ALTER TABLE `automation_assigned`
  MODIFY `automationassigned_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `category_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '[do not truncate] - only delete where category_system_default = no', AUTO_INCREMENT=61;

--
-- AUTO_INCREMENT for table `category_users`
--
ALTER TABLE `category_users`
  MODIFY `categoryuser_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `checklists`
--
ALTER TABLE `checklists`
  MODIFY `checklist_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=27;

--
-- AUTO_INCREMENT for table `clients`
--
ALTER TABLE `clients`
  MODIFY `client_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `comments`
--
ALTER TABLE `comments`
  MODIFY `comment_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `contracts`
--
ALTER TABLE `contracts`
  MODIFY `doc_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `contract_templates`
--
ALTER TABLE `contract_templates`
  MODIFY `contract_template_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `cs_affiliate_earnings`
--
ALTER TABLE `cs_affiliate_earnings`
  MODIFY `cs_affiliate_earning_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `cs_affiliate_projects`
--
ALTER TABLE `cs_affiliate_projects`
  MODIFY `cs_affiliate_project_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `cs_events`
--
ALTER TABLE `cs_events`
  MODIFY `cs_event_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `customfields`
--
ALTER TABLE `customfields`
  MODIFY `customfields_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=481;

--
-- AUTO_INCREMENT for table `email_log`
--
ALTER TABLE `email_log`
  MODIFY `emaillog_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `email_queue`
--
ALTER TABLE `email_queue`
  MODIFY `emailqueue_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `email_templates`
--
ALTER TABLE `email_templates`
  MODIFY `emailtemplate_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'x', AUTO_INCREMENT=156;

--
-- AUTO_INCREMENT for table `estimates`
--
ALTER TABLE `estimates`
  MODIFY `bill_estimateid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `events`
--
ALTER TABLE `events`
  MODIFY `event_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=49;

--
-- AUTO_INCREMENT for table `events_tracking`
--
ALTER TABLE `events_tracking`
  MODIFY `eventtracking_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `expenses`
--
ALTER TABLE `expenses`
  MODIFY `expense_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `files`
--
ALTER TABLE `files`
  MODIFY `file_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `file_folders`
--
ALTER TABLE `file_folders`
  MODIFY `filefolder_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `invoices`
--
ALTER TABLE `invoices`
  MODIFY `bill_invoiceid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `items`
--
ALTER TABLE `items`
  MODIFY `item_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `jobs`
--
ALTER TABLE `jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `kb_categories`
--
ALTER TABLE `kb_categories`
  MODIFY `kbcategory_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `knowledgebase`
--
ALTER TABLE `knowledgebase`
  MODIFY `knowledgebase_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `leads`
--
ALTER TABLE `leads`
  MODIFY `lead_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `leads_assigned`
--
ALTER TABLE `leads_assigned`
  MODIFY `leadsassigned_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `leads_sources`
--
ALTER TABLE `leads_sources`
  MODIFY `leadsources_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `leads_status`
--
ALTER TABLE `leads_status`
  MODIFY `leadstatus_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `lineitems`
--
ALTER TABLE `lineitems`
  MODIFY `lineitem_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `logs`
--
ALTER TABLE `logs`
  MODIFY `log_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `messages`
--
ALTER TABLE `messages`
  MODIFY `message_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `messages_tracking`
--
ALTER TABLE `messages_tracking`
  MODIFY `messagestracking_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `milestones`
--
ALTER TABLE `milestones`
  MODIFY `milestone_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `milestone_categories`
--
ALTER TABLE `milestone_categories`
  MODIFY `milestonecategory_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `notes`
--
ALTER TABLE `notes`
  MODIFY `note_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `payments`
--
ALTER TABLE `payments`
  MODIFY `payment_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '[truncate]';

--
-- AUTO_INCREMENT for table `payment_sessions`
--
ALTER TABLE `payment_sessions`
  MODIFY `session_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `product_tasks`
--
ALTER TABLE `product_tasks`
  MODIFY `product_task_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `product_tasks_dependencies`
--
ALTER TABLE `product_tasks_dependencies`
  MODIFY `product_task_dependency_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `projects`
--
ALTER TABLE `projects`
  MODIFY `project_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `projects_assigned`
--
ALTER TABLE `projects_assigned`
  MODIFY `projectsassigned_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '[truncate]';

--
-- AUTO_INCREMENT for table `projects_manager`
--
ALTER TABLE `projects_manager`
  MODIFY `projectsmanager_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `proposals`
--
ALTER TABLE `proposals`
  MODIFY `doc_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `proposal_templates`
--
ALTER TABLE `proposal_templates`
  MODIFY `proposal_template_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `reminders`
--
ALTER TABLE `reminders`
  MODIFY `reminder_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `roles`
--
ALTER TABLE `roles`
  MODIFY `role_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `settings`
--
ALTER TABLE `settings`
  MODIFY `settings_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `settings2`
--
ALTER TABLE `settings2`
  MODIFY `settings2_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `subscriptions`
--
ALTER TABLE `subscriptions`
  MODIFY `subscription_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tableconfig`
--
ALTER TABLE `tableconfig`
  MODIFY `tableconfig_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `tags`
--
ALTER TABLE `tags`
  MODIFY `tag_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tasks`
--
ALTER TABLE `tasks`
  MODIFY `task_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tasks_assigned`
--
ALTER TABLE `tasks_assigned`
  MODIFY `tasksassigned_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '[truncate]';

--
-- AUTO_INCREMENT for table `tasks_dependencies`
--
ALTER TABLE `tasks_dependencies`
  MODIFY `tasksdependency_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tasks_priority`
--
ALTER TABLE `tasks_priority`
  MODIFY `taskpriority_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `tasks_status`
--
ALTER TABLE `tasks_status`
  MODIFY `taskstatus_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `tax`
--
ALTER TABLE `tax`
  MODIFY `tax_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `taxrates`
--
ALTER TABLE `taxrates`
  MODIFY `taxrate_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `tickets`
--
ALTER TABLE `tickets`
  MODIFY `ticket_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tickets_status`
--
ALTER TABLE `tickets_status`
  MODIFY `ticketstatus_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `ticket_replies`
--
ALTER TABLE `ticket_replies`
  MODIFY `ticketreply_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `timelines`
--
ALTER TABLE `timelines`
  MODIFY `timeline_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `timers`
--
ALTER TABLE `timers`
  MODIFY `timer_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `units`
--
ALTER TABLE `units`
  MODIFY `unit_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `updates`
--
ALTER TABLE `updates`
  MODIFY `update_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `updating`
--
ALTER TABLE `updating`
  MODIFY `updating_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `webforms`
--
ALTER TABLE `webforms`
  MODIFY `webform_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `webforms_assigned`
--
ALTER TABLE `webforms_assigned`
  MODIFY `webformassigned_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `webhooks`
--
ALTER TABLE `webhooks`
  MODIFY `webhooks_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `webmail_templates`
--
ALTER TABLE `webmail_templates`
  MODIFY `webmail_template_id` int(11) NOT NULL AUTO_INCREMENT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
