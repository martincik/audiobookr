CREATE TABLE `audio_book_categories` (
  `id` int(11) NOT NULL auto_increment,
  `category_id` int(11) NOT NULL,
  `audio_book_id` int(11) NOT NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=78327 DEFAULT CHARSET=utf8;

CREATE TABLE `audio_books` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(255) default NULL,
  `last_updated` datetime default NULL,
  `keywords` varchar(255) default NULL,
  `short_description` varchar(255) default NULL,
  `long_description` varchar(255) default NULL,
  `sku` varchar(255) default NULL,
  `isbn` varchar(255) default NULL,
  `currency` varchar(255) default NULL,
  `our_price` decimal(10,2) default '0.00',
  `retail_price` decimal(10,2) default '0.00',
  `buy_url` varchar(255) default NULL,
  `thumb_nail_url` varchar(255) default NULL,
  `large_image_url` varchar(255) default NULL,
  `sample_mwp_url` varchar(255) default NULL,
  `sample_real_url` varchar(255) default NULL,
  `average_customer_rating` float default NULL,
  `author` varchar(255) default NULL,
  `publisher` varchar(255) default NULL,
  `audio_length` varchar(255) default NULL,
  `is_available_worldwide` tinyint(1) default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=39405 DEFAULT CHARSET=utf8;

CREATE TABLE `categories` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(255) default NULL,
  `parent_id` int(11) default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  `perma_name` varchar(255) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=265 DEFAULT CHARSET=utf8;

CREATE TABLE `schema_migrations` (
  `version` varchar(255) NOT NULL,
  UNIQUE KEY `unique_schema_migrations` (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO schema_migrations (version) VALUES ('20090407183005');

INSERT INTO schema_migrations (version) VALUES ('20090407183905');

INSERT INTO schema_migrations (version) VALUES ('20090410081419');

INSERT INTO schema_migrations (version) VALUES ('20090413190529');