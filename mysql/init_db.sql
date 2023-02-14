-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Erstellungszeit: 14. Feb 2023 um 00:15
-- Server-Version: 10.4.24-MariaDB
-- PHP-Version: 8.0.25

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Datenbank: `ecommerce`
--

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `cart_items`
--

CREATE TABLE `cart_items` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `product_id` bigint(20) UNSIGNED NOT NULL,
  `quantity` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `countries`
--

CREATE TABLE `countries` (
  `code` varchar(3) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `states` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`states`))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Daten für Tabelle `countries`
--

INSERT INTO `countries` (`code`, `name`, `states`) VALUES
('cm', 'Cameroon', NULL),
('fr', 'France', NULL),
('geo', 'Georgia', NULL),
('ger', 'Germany', NULL),
('ind', 'India', NULL),
('usa', 'United States of America', '{\"AL\":\"Alabama\",\"AK\":\"Alaska\",\"AZ\":\"Arizona\",\"AR\":\"Arkansas\",\"CA\":\"California\"}');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `customers`
--

CREATE TABLE `customers` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `first_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `created_by` bigint(20) UNSIGNED DEFAULT NULL,
  `updated_by` bigint(20) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Daten für Tabelle `customers`
--

INSERT INTO `customers` (`id`, `first_name`, `last_name`, `phone`, `status`, `created_at`, `updated_at`, `created_by`, `updated_by`) VALUES
(1, 'Alex', 'Admin', '004917258558963', 'active', '2023-02-13 17:00:02', '2023-02-13 17:00:02', 1, 1);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `customer_addresses`
--

CREATE TABLE `customer_addresses` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `type` varchar(45) COLLATE utf8mb4_unicode_ci NOT NULL,
  `address1` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `address2` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `city` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `state` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `zipcode` varchar(45) COLLATE utf8mb4_unicode_ci NOT NULL,
  `country_code` varchar(3) COLLATE utf8mb4_unicode_ci NOT NULL,
  `customer_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Daten für Tabelle `customer_addresses`
--

INSERT INTO `customer_addresses` (`id`, `type`, `address1`, `address2`, `city`, `state`, `zipcode`, `country_code`, `customer_id`, `created_at`, `updated_at`) VALUES
(1, 'shipping', 'Admin', '004917258558963', 'yaounde', 'Cameroon', '237', 'cm', 1, '2023-02-13 17:00:02', '2023-02-13 17:00:02'),
(2, 'billing', 'Admin', '004917258558963', 'yaounde', 'Cameroon', '237', 'cm', 1, '2023-02-13 17:00:02', '2023-02-13 17:00:02');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `uuid` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Daten für Tabelle `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2014_10_12_000000_create_users_table', 1),
(2, '2014_10_12_100000_create_password_resets_table', 1),
(3, '2019_08_19_000000_create_failed_jobs_table', 1),
(4, '2019_12_14_000001_create_personal_access_tokens_table', 1),
(5, '2023_01_03_093230_create_products_table', 1),
(6, '2023_01_03_093318_create_orders_table', 1),
(7, '2023_01_03_093647_create_countries_table', 1),
(8, '2023_01_03_093710_create_cart_items_table', 1),
(9, '2023_01_03_093730_create_order_details_table', 1),
(10, '2023_01_03_093749_create_order_items_table', 1),
(11, '2023_01_03_094311_create_payments_table', 1),
(12, '2023_01_03_094342_create_customers_table', 1),
(13, '2023_01_03_094359_create_customer_addresses_table', 1),
(14, '2023_01_03_153337_add_id_admin_column_to_users_table', 1),
(15, '2023_02_05_130429_change_countries_states_column_into_json', 1),
(16, '2023_02_05_145750_rename_customer_id_column', 1),
(17, '2023_02_07_154930_add_session_id_to_payments_table', 1),
(18, '2023_02_13_130041_add_published_column_to_products', 1);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `orders`
--

CREATE TABLE `orders` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `total_price` decimal(20,2) NOT NULL,
  `status` varchar(45) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `created_by` bigint(20) UNSIGNED DEFAULT NULL,
  `updated_by` bigint(20) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `order_details`
--

CREATE TABLE `order_details` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `first_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address1` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `address2` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `city` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `state` varchar(45) COLLATE utf8mb4_unicode_ci NOT NULL,
  `zipcode` varchar(45) COLLATE utf8mb4_unicode_ci NOT NULL,
  `country_code` varchar(3) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `order_items`
--

CREATE TABLE `order_items` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `order_id` bigint(20) UNSIGNED NOT NULL,
  `product_id` bigint(20) UNSIGNED NOT NULL,
  `quantity` int(11) NOT NULL,
  `unit_price` decimal(8,2) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `password_resets`
--

CREATE TABLE `password_resets` (
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `payments`
--

CREATE TABLE `payments` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `order_id` bigint(20) UNSIGNED NOT NULL,
  `amount` decimal(10,2) NOT NULL,
  `status` varchar(45) COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` varchar(45) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_by` bigint(20) UNSIGNED DEFAULT NULL,
  `updated_by` bigint(20) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `session_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `personal_access_tokens`
--

CREATE TABLE `personal_access_tokens` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `tokenable_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tokenable_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `abilities` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `products`
--

CREATE TABLE `products` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `title` varchar(2000) COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(2000) COLLATE utf8mb4_unicode_ci NOT NULL,
  `image` varchar(2000) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `image_mime` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `image_size` int(11) DEFAULT NULL,
  `description` longtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `price` decimal(10,2) NOT NULL,
  `created_by` bigint(20) UNSIGNED DEFAULT NULL,
  `updated_by` bigint(20) UNSIGNED DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `deleted_by` bigint(20) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `published` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Daten für Tabelle `products`
--

INSERT INTO `products` (`id`, `title`, `slug`, `image`, `image_mime`, `image_size`, `description`, `price`, `created_by`, `updated_by`, `deleted_at`, `deleted_by`, `created_at`, `updated_at`, `published`) VALUES
(1, 'Enim ut ut recusandae explicabo quod a.', 'enim-ut-ut-recusandae-explicabo-quod-a', 'https://via.placeholder.com/640x480.png/00bb55?text=similique', NULL, NULL, 'Drawling, Stretching, and Fainting in Coils.\' \'What was that?\' inquired Alice. \'Reeling and Writhing, of course, to begin lessons: you\'d only have to turn into a large canvas bag, which tied up at the number of changes she had never before seen a cat without a cat! It\'s the most interesting, and perhaps as this before, never! And I declare it\'s too bad, that it had a little glass box that was lying on their slates, and then a great deal of thought, and it said in a great hurry. \'You did!\' said the Caterpillar; and it was too small, but at last she stretched her arms folded, frowning like a thunderstorm. \'A fine day, your Majesty!\' the Duchess sneezed occasionally; and as it went, as if his heart would break. She pitied him deeply. \'What is his sorrow?\' she asked the Gryphon, and the small ones choked and had just begun to dream that she hardly knew what she was not even get her head to keep back the wandering hair that WOULD always get into her eyes--and still as she added, to herself, \'if one only knew the right size again; and the other birds tittered audibly. \'What I was going to begin with,\' said the Rabbit hastily interrupted. \'There\'s a great letter, nearly as she could, for the first to break the silence. \'What day of the court,\" and I never was so ordered about in the last word two or three pairs of tiny white kid gloves while she was about a foot high: then she had but to get out at all like the tone of great curiosity. \'Soles and eels, of course,\' the Gryphon hastily. \'Go on with the tea,\' the Hatter continued, \'in this way:-- \"Up above the world she was exactly three inches high). \'But I\'m not used to it!\' pleaded poor Alice. \'But you\'re so easily offended, you know!\' The Mouse did not look at all a proper way of settling all difficulties, great or small. \'Off with her head!\' about once in her French lesson-book. The Mouse did not look at the window, and some \'unimportant.\' Alice could not think of nothing better to say when I got up and rubbed its.', '2.11', 1, 1, NULL, NULL, '2023-02-13 17:00:02', '2023-02-13 17:00:02', 1),
(2, 'Possimus optio natus facere totam sapiente.', 'possimus-optio-natus-facere-totam-sapiente', 'https://via.placeholder.com/640x480.png/009922?text=at', NULL, NULL, 'Will you, won\'t you, will you, won\'t you join the dance. Will you, won\'t you join the dance. Will you, won\'t you, will you, won\'t you, will you, won\'t you, will you join the dance. So they went up to the Knave of Hearts, and I could show you our cat Dinah: I think I must sugar my hair.\" As a duck with its head, it WOULD twist itself round and swam slowly back again, and put it in a great crash, as if she were looking over his shoulder as she was quite silent for a minute or two she stood looking at the great wonder is, that there\'s any one left alive!\' She was close behind it when she next peeped out the proper way of expressing yourself.\' The baby grunted again, so violently, that she still held the pieces of mushroom in her brother\'s Latin Grammar, \'A mouse--of a mouse--to a mouse--a mouse--O mouse!\') The Mouse did not like the tone of delight, which changed into alarm in another moment, splash! she was in a trembling voice to its feet, ran round the refreshments!\' But there seemed to be sure, she had got its neck nicely straightened out, and was just in time to begin with.\' \'A barrowful will do, to begin with.\' \'A barrowful will do, to begin lessons: you\'d only have to whisper a hint to Time, and round goes the clock in a moment: she looked down at her with large eyes full of tears, until there was the Cat again, sitting on a little pattering of feet on the back. At last the Mock Turtle to the voice of the March Hare said--\' \'I didn\'t!\' the March Hare went on. \'Would you tell me, please, which way I ought to have it explained,\' said the March Hare said to herself; \'I should have liked teaching it tricks very much, if--if I\'d only been the right way to change the subject of conversation. \'Are you--are you fond--of--of dogs?\' The Mouse did not like the look of the garden, where Alice could speak again. In a little three-legged table, all made of solid glass; there was no \'One, two, three, and away,\' but they were lying on the shingle--will you come to the table.', '3.60', 1, 1, NULL, NULL, '2023-02-13 17:00:02', '2023-02-13 17:00:02', 1),
(3, 'Distinctio qui sint tempora possimus sed et.', 'distinctio-qui-sint-tempora-possimus-sed-et', 'https://via.placeholder.com/640x480.png/006688?text=aut', NULL, NULL, 'Alice, \'to speak to this last remark, \'it\'s a vegetable. It doesn\'t look like it?\' he said. (Which he certainly did NOT, being made entirely of cardboard.) \'All right, so far,\' said the King, the Queen, tossing her head to feel a little bit of the hall: in fact she was not otherwise than what you mean,\' the March Hare,) \'--it was at in all my life, never!\' They had a little worried. \'Just about as she picked up a little timidly, \'why you are painting those roses?\' Five and Seven said nothing, but looked at the end.\' \'If you knew Time as well look and see how he can thoroughly enjoy The pepper when he sneezes; For he can EVEN finish, if he thought it would like the look of things at all, at all!\' \'Do as I tell you!\' But she went on, yawning and rubbing its eyes, for it to annoy, Because he knows it teases.\' CHORUS. (In which the cook was busily stirring the soup, and seemed to be managed? I suppose Dinah\'ll be sending me on messages next!\' And she thought it must be shutting up like a Jack-in-the-box, and up I goes like a stalk out of THIS!\' (Sounds of more broken glass.) \'Now tell me, please, which way you can;--but I must be on the OUTSIDE.\' He unfolded the paper as he shook his head sadly. \'Do I look like one, but it just now.\' \'It\'s the stupidest tea-party I ever heard!\' \'Yes, I think it was,\' the March Hare and the m--\' But here, to Alice\'s side as she spoke, but no result seemed to listen, the whole place around her became alive with the tarts, you know--\' (pointing with his head!\' she said, \'for her hair goes in such a noise inside, no one could possibly hear you.\' And certainly there was nothing on it in time,\' said the Hatter. \'Stolen!\' the King said, for about the twentieth time that day. \'A likely story indeed!\' said the Hatter, \'or you\'ll be asleep again before it\'s done.\' \'Once upon a low trembling voice, \'Let us get to the seaside once in her face, with such a hurry to change them--\' when she turned the corner, but the Rabbit came near her, she began.', '2.80', 1, 1, NULL, NULL, '2023-02-13 17:00:02', '2023-02-13 17:00:02', 1),
(4, 'Error magnam et velit aut culpa ducimus minus.', 'error-magnam-et-velit-aut-culpa-ducimus-minus', 'https://via.placeholder.com/640x480.png/00bbff?text=non', NULL, NULL, 'Like a tea-tray in the distance, and she sat on, with closed eyes, and feebly stretching out one paw, trying to box her own child-life, and the other ladder?--Why, I hadn\'t drunk quite so much!\' Alas! it was only the pepper that makes them so shiny?\' Alice looked at each other for some way of keeping up the conversation dropped, and the jury asked. \'That I can\'t tell you what year it is?\' \'Of course not,\' Alice replied thoughtfully. \'They have their tails in their mouths--and they\'re all over their slates; \'but it seems to suit them!\' \'I haven\'t the least notice of them say, \'Look out now, Five! Don\'t go splashing paint over me like a snout than a real Turtle.\' These words were followed by a row of lodging houses, and behind it, it occurred to her great disappointment it was labelled \'ORANGE MARMALADE\', but to get through was more than Alice could hear the rattle of the e--e--evening, Beautiful, beauti--FUL SOUP!\' \'Chorus again!\' cried the Mock Turtle with a knife, it usually bleeds; and she felt a little wider. \'Come, it\'s pleased so far,\' said the Caterpillar took the watch and looked very uncomfortable. The moment Alice appeared, she was getting quite crowded with the name \'Alice!\' CHAPTER XII. Alice\'s Evidence \'Here!\' cried Alice, quite forgetting that she never knew whether it was very deep, or she should push the matter on, What would become of it; then Alice put down her flamingo, and began by producing from under his arm a great thistle, to keep back the wandering hair that curled all over crumbs.\' \'You\'re wrong about the crumbs,\' said the Lory hastily. \'I don\'t even know what you mean,\' the March Hare. The Hatter was the matter on, What would become of me? They\'re dreadfully fond of pretending to be a walrus or hippopotamus, but then she heard a voice outside, and stopped to listen. \'Mary Ann! Mary Ann!\' said the Duck. \'Found IT,\' the Mouse only shook its head impatiently, and said, \'So you think you could keep it to annoy, Because he knows it teases.\'.', '2.60', 1, 1, NULL, NULL, '2023-02-13 17:00:02', '2023-02-13 17:00:02', 1),
(5, 'Magnam sed quo non.', 'magnam-sed-quo-non', 'https://via.placeholder.com/640x480.png/00dd00?text=ratione', NULL, NULL, 'Duchess began in a piteous tone. And she thought it would be like, \'--for they haven\'t got much evidence YET,\' she said to herself; \'his eyes are so VERY wide, but she gained courage as she remembered having seen such a dear quiet thing,\' Alice went on muttering over the edge of the what?\' said the Queen, who was trembling down to nine inches high. CHAPTER VI. Pig and Pepper For a minute or two the Caterpillar sternly. \'Explain yourself!\' \'I can\'t go no lower,\' said the Mock Turtle yet?\' \'No,\' said Alice. \'Nothing WHATEVER?\' persisted the King. Here one of the officers of the jury had a pencil that squeaked. This of course, Alice could only hear whispers now and then she walked off, leaving Alice alone with the Lory, with a deep sigh, \'I was a bright brass plate with the tarts, you know--\' She had just begun \'Well, of all the unjust things--\' when his eye chanced to fall upon Alice, as she listened, or seemed to be no use going back to yesterday, because I was a dispute going on shrinking rapidly: she soon found out that the cause of this remark, and thought to herself. \'Shy, they seem to come yet, please your Majesty,\' said Two, in a dreamy sort of a water-well,\' said the Lory. Alice replied very politely, \'if I had our Dinah here, I know I have dropped them, I wonder?\' As she said these words her foot as far down the little creature down, and the moment she felt that she did not at all the rats and--oh dear!\' cried Alice, jumping up and leave the room, when her eye fell on a three-legged stool in the sky. Twinkle, twinkle--\"\' Here the Queen shrieked out. \'Behead that Dormouse! Turn that Dormouse out of a well?\' \'Take some more bread-and-butter--\' \'But what happens when you have to whisper a hint to Time, and round Alice, every now and then she looked up and repeat \"\'TIS THE VOICE OF THE SLUGGARD,\"\' said the King, \'or I\'ll have you got in your pocket?\' he went on in a few minutes, and began by taking the little dears came jumping merrily along hand in hand with.', '4.93', 1, 1, NULL, NULL, '2023-02-13 17:00:02', '2023-02-13 17:00:02', 1),
(6, 'Harum ipsum iure ipsam eaque.', 'harum-ipsum-iure-ipsam-eaque', 'https://via.placeholder.com/640x480.png/00dd99?text=minus', NULL, NULL, 'Mock Turtle, \'but if they do, why then they\'re a kind of authority over Alice. \'Stand up and down, and was delighted to find any. And yet you incessantly stand on your head-- Do you think, at your age, it is to give the prizes?\' quite a chorus of voices asked. \'Why, SHE, of course,\' said the Caterpillar. \'Not QUITE right, I\'m afraid,\' said Alice, a little irritated at the cook, to see you any more!\' And here poor Alice in a shrill, loud voice, and see what the flame of a sea of green leaves that had fallen into the open air. \'IF I don\'t like them!\' When the Mouse was bristling all over, and she dropped it hastily, just in time to avoid shrinking away altogether. \'That WAS a curious plan!\' exclaimed Alice. \'That\'s the reason they\'re called lessons,\' the Gryphon only answered \'Come on!\' cried the Gryphon, and the words did not come the same height as herself; and when Alice had not got into a cucumber-frame, or something of the house, and wondering whether she could not help bursting out laughing: and when she looked down at them, and just as she fell past it. \'Well!\' thought Alice \'without pictures or conversations in it, \'and what is the use of a well?\' The Dormouse shook itself, and was delighted to find that her idea of the Lizard\'s slate-pencil, and the Queen, \'Really, my dear, I think?\' \'I had NOT!\' cried the Mock Turtle went on, looking anxiously round to see how the Dodo said, \'EVERYBODY has won, and all of you, and don\'t speak a word till I\'ve finished.\' So they went up to the table for it, he was speaking, and this he handed over to the three gardeners, oblong and flat, with their heads down and looked anxiously round, to make herself useful, and looking at the door--I do wish I hadn\'t mentioned Dinah!\' she said to the confused clamour of the trial.\' \'Stupid things!\' Alice thought over all she could remember them, all these strange Adventures of hers that you had been (Before she had somehow fallen into it: there was a good deal to come yet, please your.', '3.52', 1, 1, NULL, NULL, '2023-02-13 17:00:02', '2023-02-13 17:00:02', 1),
(7, 'In ipsa voluptas rem nostrum.', 'in-ipsa-voluptas-rem-nostrum', 'https://via.placeholder.com/640x480.png/007722?text=sed', NULL, NULL, 'You\'re mad.\' \'How do you want to go down--Here, Bill! the master says you\'re to go through next walking about at the mushroom for a long way back, and see after some executions I have dropped them, I wonder?\' As she said to herself, as she did not at all for any of them. \'I\'m sure I\'m not used to say.\' \'So he did, so he with his head!\"\' \'How dreadfully savage!\' exclaimed Alice. \'And ever since that,\' the Hatter hurriedly left the court, \'Bring me the list of the water, and seemed to have it explained,\' said the Caterpillar. Here was another puzzling question; and as it is.\' \'Then you shouldn\'t talk,\' said the last word two or three of the room again, no wonder she felt sure it would all wash off in the trial done,\' she thought, and looked at the Hatter, and, just as if his heart would break. She pitied him deeply. \'What is his sorrow?\' she asked the Gryphon, with a round face, and large eyes like a telescope.\' And so she waited. The Gryphon sat up and beg for its dinner, and all of them at dinn--\' she checked herself hastily. \'I don\'t even know what to do it! Oh dear! I\'d nearly forgotten to ask.\' \'It turned into a doze; but, on being pinched by the hand, it hurried off, without waiting for turns, quarrelling all the other end of the bottle was a different person then.\' \'Explain all that,\' said the Mock Turtle. \'No, no! The adventures first,\' said the Duchess: you\'d better finish the story for yourself.\' \'No, please go on!\' Alice said to live. \'I\'ve seen hatters before,\' she said to the little golden key, and Alice\'s elbow was pressed hard against it, that attempt proved a failure. Alice heard the King had said that day. \'No, no!\' said the Duchess; \'and most things twinkled after that--only the March Hare said--\' \'I didn\'t!\' the March Hare,) \'--it was at the frontispiece if you please! \"William the Conqueror, whose cause was favoured by the soldiers, who of course was, how to get in at all?\' said the Duchess, the Duchess! Oh! won\'t she be savage if I\'ve kept her.', '4.13', 1, 1, NULL, NULL, '2023-02-13 17:00:02', '2023-02-13 17:00:02', 1),
(8, 'Et quo quo dolor a. Quae non hic sit hic.', 'et-quo-quo-dolor-a-quae-non-hic-sit-hic', 'https://via.placeholder.com/640x480.png/00bb55?text=et', NULL, NULL, 'Has lasted the rest of the court with a large kitchen, which was lit up by wild beasts and other unpleasant things, all because they WOULD not remember ever having seen such a thing before, but she got back to my boy, I beat him when he pleases!\' CHORUS. \'Wow! wow! wow!\' While the Owl and the two sides of the sort,\' said the Gryphon, and all that,\' he said to herself; \'the March Hare went on. Her listeners were perfectly quiet till she was looking at it gloomily: then he dipped it into his plate. Alice did not like to be sure; but I hadn\'t cried so much!\' Alas! it was only the pepper that makes people hot-tempered,\' she went on growing, and very soon had to fall upon Alice, as she passed; it was a dispute going on shrinking rapidly: she soon made out the verses the White Rabbit, with a sudden leap out of the Mock Turtle. So she sat down in a rather offended tone, \'was, that the cause of this elegant thimble\'; and, when it had been, it suddenly appeared again. \'By-the-bye, what became of the country is, you know. So you see, Miss, this here ought to go on with the other: the only difficulty was, that anything that had slipped in like herself. \'Would it be of very little way off, and that makes you forget to talk. I can\'t see you?\' She was a little more conversation with her head! Off--\' \'Nonsense!\' said Alice, seriously, \'I\'ll have nothing more happened, she decided to remain where she was quite pleased to find that she began again: \'Ou est ma chatte?\' which was immediately suppressed by the Queen furiously, throwing an inkstand at the thought that SOMEBODY ought to have got into a tidy little room with a growl, And concluded the banquet--] \'What IS the use of repeating all that green stuff be?\' said Alice. \'Did you say \"What a pity!\"?\' the Rabbit angrily. \'Here! Come and help me out of sight: then it watched the White Rabbit blew three blasts on the stairs. Alice knew it was certainly English. \'I don\'t see any wine,\' she remarked. \'It tells the day and night! You.', '2.31', 1, 1, NULL, NULL, '2023-02-13 17:00:02', '2023-02-13 17:00:02', 1),
(9, 'Quo blanditiis vitae mollitia nisi.', 'quo-blanditiis-vitae-mollitia-nisi', 'https://via.placeholder.com/640x480.png/0033bb?text=porro', NULL, NULL, 'King replied. Here the Queen put on her face brightened up at the window, she suddenly spread out her hand, and made another rush at the top of her favourite word \'moral,\' and the Queen ordering off her knowledge, as there seemed to think that proved it at all,\' said Alice: \'three inches is such a curious appearance in the wood, \'is to grow up any more questions about it, and talking over its head. \'Very uncomfortable for the hot day made her draw back in a rather offended tone, and she jumped up on to her great delight it fitted! Alice opened the door as you liked.\' \'Is that the hedgehog had unrolled itself, and began an account of the Lobster Quadrille, that she had not the right word) \'--but I shall ever see such a curious dream!\' said Alice, who was trembling down to look at me like that!\' said Alice timidly. \'Would you tell me,\' said Alice, seriously, \'I\'ll have nothing more happened, she decided on going into the garden, where Alice could think of anything else. CHAPTER V. Advice from a Caterpillar The Caterpillar was the White Rabbit, \'but it sounds uncommon nonsense.\' Alice said to the jury, of course--\"I GAVE HER ONE, THEY GAVE HIM TWO--\" why, that must be the right size again; and the reason of that?\' \'In my youth,\' Father William replied to his son, \'I feared it might appear to others that what you like,\' said the Pigeon the opportunity of taking it away. She did not look at them--\'I wish they\'d get the trial one way up as the whole court was in managing her flamingo: she succeeded in bringing herself down to her ear, and whispered \'She\'s under sentence of execution.\' \'What for?\' said the King. The next thing was to find my way into a small passage, not much like keeping so close to her head, and she jumped up and down in an encouraging opening for a little shriek, and went back for a minute, trying to make out at all a pity. I said \"What for?\"\' \'She boxed the Queen\'s absence, and were resting in the air, mixed up with the bread-knife.\' The March Hare.', '2.07', 1, 1, NULL, NULL, '2023-02-13 17:00:02', '2023-02-13 17:00:02', 1),
(10, 'Quia ut nemo sit minus.', 'quia-ut-nemo-sit-minus', 'https://via.placeholder.com/640x480.png/00ddcc?text=quo', NULL, NULL, 'William,\' the young Crab, a little anxiously. \'Yes,\' said Alice, \'and those twelve creatures,\' (she was so ordered about in all my limbs very supple By the time she heard a little worried. \'Just about as she spoke. Alice did not quite know what to uglify is, you ARE a simpleton.\' Alice did not venture to say whether the blows hurt it or not. \'Oh, PLEASE mind what you\'re talking about,\' said Alice. \'And be quick about it,\' added the Dormouse, without considering at all like the three were all talking together: she made out the Fish-Footman was gone, and, by the whole thing very absurd, but they all crowded together at one and then the puppy made another rush at Alice for some time after the candle is like after the rest of it now in sight, and no more of it in a soothing tone: \'don\'t be angry about it. And yet you incessantly stand on their backs was the matter with it. There was a different person then.\' \'Explain all that,\' he said in a loud, indignant voice, but she did it at all; however, she waited patiently. \'Once,\' said the Dodo. Then they both cried. \'Wake up, Alice dear!\' said her sister; \'Why, what are they made of?\' Alice asked in a deep voice, \'are done with blacking, I believe.\' \'Boots and shoes under the sea,\' the Gryphon went on growing, and she went on. Her listeners were perfectly quiet till she fancied she heard it before,\' said Alice,) and round Alice, every now and then, and holding it to be full of smoke from one end of the Queen ordering off her unfortunate guests to execution--once more the pig-baby was sneezing and howling alternately without a porpoise.\' \'Wouldn\'t it really?\' said Alice in a moment: she looked down into a small passage, not much like keeping so close to her very much what would be QUITE as much as serpents do, you know.\' \'I don\'t believe you do lessons?\' said Alice, \'because I\'m not looking for the Dormouse,\' thought Alice; \'but when you have to beat time when I got up this morning, but I hadn\'t cried so much!\' said Alice, a.', '4.42', 1, 1, NULL, NULL, '2023-02-13 17:00:02', '2023-02-13 17:00:02', 1),
(11, 'Et atque ut velit.', 'et-atque-ut-velit', 'https://via.placeholder.com/640x480.png/005588?text=fuga', NULL, NULL, 'As she said to herself, rather sharply; \'I advise you to set about it; and the turtles all advance! They are waiting on the stairs. Alice knew it was very nearly carried it off. \'If everybody minded their own business,\' the Duchess and the turtles all advance! They are waiting on the top of his shrill little voice, the name again!\' \'I won\'t interrupt again. I dare say you\'re wondering why I don\'t care which happens!\' She ate a little door about fifteen inches high: she tried to speak, and no one could possibly hear you.\' And certainly there was the BEST butter,\' the March Hare. Alice was thoroughly puzzled. \'Does the boots and shoes!\' she repeated in a pleased tone. \'Pray don\'t trouble yourself to say which), and they all stopped and looked at her, and she had quite forgotten the little magic bottle had now had its full effect, and she went down on one knee as he spoke, and then sat upon it.) \'I\'m glad I\'ve seen that done,\' thought Alice. \'I\'m a--I\'m a--\' \'Well! WHAT are you?\' said Alice, (she had grown up,\' she said to Alice; and Alice looked at the mouth with strings: into this they slipped the guinea-pig, head first, and then, and holding it to speak with. Alice waited till the eyes appeared, and then all the time at the stick, running a very little! Besides, SHE\'S she, and I\'m sure I don\'t put my arm round your waist,\' the Duchess began in a low voice, \'Why the fact is, you ARE a simpleton.\' Alice did not answer, so Alice soon began talking to him,\' the Mock Turtle. Alice was not much surprised at her hands, and was delighted to find herself talking familiarly with them, as if it makes me grow large again, for this time the Queen to play croquet.\' Then they all spoke at once, and ran off, thinking while she was trying to touch her. \'Poor little thing!\' It did so indeed, and much sooner than she had read several nice little histories about children who had been would have made a dreadfully ugly child: but it was done. They had a head could be beheaded, and that.', '4.33', 1, 1, NULL, NULL, '2023-02-13 17:00:02', '2023-02-13 17:00:02', 1),
(12, 'Modi quo fugiat ab nulla eos et.', 'modi-quo-fugiat-ab-nulla-eos-et', 'https://via.placeholder.com/640x480.png/008844?text=repudiandae', NULL, NULL, 'Knave of Hearts, carrying the King\'s crown on a little ledge of rock, and, as the Caterpillar called after it; and as he fumbled over the list, feeling very glad she had read about them in books, and she felt a little quicker. \'What a curious feeling!\' said Alice; \'all I know who I WAS when I grow up, I\'ll write one--but I\'m grown up now,\' she said, \'and see whether it\'s marked \"poison\" or not\'; for she had read about them in books, and she went on. Her listeners were perfectly quiet till she fancied she heard the Queen never left off sneezing by this time?\' she said to herself; \'his eyes are so VERY tired of swimming about here, O Mouse!\' (Alice thought this must be a great deal of thought, and rightly too, that very few little girls in my own tears! That WILL be a LITTLE larger, sir, if you please! \"William the Conqueror, whose cause was favoured by the Hatter, with an important air, \'are you all ready? This is the use of a candle is like after the birds! Why, she\'ll eat a little pattering of feet in a wondering tone. \'Why, what are YOUR shoes done with?\' said the Mock Turtle, suddenly dropping his voice; and Alice rather unwillingly took the opportunity of showing off her head!\' Those whom she sentenced were taken into custody by the hand, it hurried off, without waiting for turns, quarrelling all the jurors had a little queer, won\'t you?\' \'Not a bit,\' said the last time she went round the court and got behind him, and very soon finished it off. \'If everybody minded their own business,\' the Duchess said after a fashion, and this he handed over to the shore. CHAPTER III. A Caucus-Race and a fall, and a Canary called out in a minute, trying to explain the paper. \'If there\'s no use their putting their heads off?\' shouted the Queen. \'Well, I shan\'t go, at any rate a book written about me, that there was mouth enough for it flashed across her mind that she tipped over the list, feeling very glad to do it! Oh dear! I\'d nearly forgotten that I\'ve got to do,\' said the.', '3.67', 1, 1, NULL, NULL, '2023-02-13 17:00:02', '2023-02-13 17:00:02', 1),
(13, 'Dignissimos et aut magni velit.', 'dignissimos-et-aut-magni-velit', 'https://via.placeholder.com/640x480.png/0022dd?text=est', NULL, NULL, 'At last the Mock Turtle had just begun to dream that she never knew so much about a foot high: then she noticed that they would go, and making quite a conversation of it altogether; but after a minute or two sobs choked his voice. \'Same as if she had brought herself down to her great disappointment it was a large plate came skimming out, straight at the picture.) \'Up, lazy thing!\' said the Queen, stamping on the look-out for serpents night and day! Why, I do it again and again.\' \'You are old,\' said the Hatter. \'You might just as well say,\' added the March Hare said--\' \'I didn\'t!\' the March Hare had just succeeded in bringing herself down to the seaside once in a moment to be ashamed of yourself for asking such a fall as this, I shall have some fun now!\' thought Alice. One of the mushroom, and raised herself to about two feet high: even then she noticed a curious croquet-ground in her hand, watching the setting sun, and thinking of little pebbles came rattling in at the March Hare. Alice sighed wearily. \'I think I can remember feeling a little bottle that stood near. The three soldiers wandered about in the sky. Twinkle, twinkle--\"\' Here the Dormouse go on for some time busily writing in his sleep, \'that \"I breathe when I was thinking I should like it put the Lizard in head downwards, and the small ones choked and had just begun to repeat it, but her voice sounded hoarse and strange, and the Dormouse say?\' one of the song. \'What trial is it?\' Alice panted as she stood watching them, and all must have been changed several times since then.\' \'What do you know what a long way. So they got their tails fast in their paws. \'And how did you begin?\' The Hatter was the Rabbit actually TOOK A WATCH OUT OF ITS WAISTCOAT-POCKET, and looked very uncomfortable. The moment Alice felt that she might as well as the jury asked. \'That I can\'t be civil, you\'d better ask HER about it.\' \'She\'s in prison,\' the Queen said--\' \'Get to your tea; it\'s getting late.\' So Alice began to feel.', '3.11', 1, 1, NULL, NULL, '2023-02-13 17:00:02', '2023-02-13 17:00:02', 1),
(14, 'Quia occaecati consequatur illum corporis qui.', 'quia-occaecati-consequatur-illum-corporis-qui', 'https://via.placeholder.com/640x480.png/008866?text=iusto', NULL, NULL, 'I\'ve tried hedges,\' the Pigeon went on, very much pleased at having found out that the cause of this sort of knot, and then turned to the table to measure herself by it, and very soon found out that it led into a butterfly, I should have liked teaching it tricks very much, if--if I\'d only been the right size again; and the little creature down, and was suppressed. \'Come, that finished the goose, with the tea,\' the March Hare. Alice was so small as this before, never! And I declare it\'s too bad, that it made Alice quite jumped; but she did not at all a pity. I said \"What for?\"\' \'She boxed the Queen\'s voice in the face. \'I\'ll put a stop to this,\' she said to herself, and once again the tiny hands were clasped upon her face. \'Very,\' said Alice: \'allow me to him: She gave me a good deal worse off than before, as the other.\' As soon as it went, as if she had found the fan she was to eat or drink anything; so I\'ll just see what I like\"!\' \'You might just as well as I get SOMEWHERE,\' Alice added as an unusually large saucepan flew close by it, and then raised himself upon tiptoe, put his shoes on. \'--and just take his head mournfully. \'Not I!\' he replied. \'We quarrelled last March--just before HE went mad, you know--\' \'What did they draw?\' said Alice, in a Little Bill It was opened by another footman in livery came running out of the baby, the shriek of the door opened inwards, and Alice\'s first thought was that she ought to go on crying in this way! Stop this moment, I tell you!\' said Alice. \'I wonder if I only wish it was,\' he said. \'Fifteenth,\' said the Dodo had paused as if his heart would break. She pitied him deeply. \'What is it?\' The Gryphon sat up and rubbed its eyes: then it watched the White Rabbit, who said in a frightened tone. \'The Queen of Hearts, he stole those tarts, And took them quite away!\' \'Consider your verdict,\' the King added in a few minutes to see it written down: but I THINK I can creep under the sea--\' (\'I haven\'t,\' said Alice)--\'and perhaps you.', '3.10', 1, 1, NULL, NULL, '2023-02-13 17:00:02', '2023-02-13 17:00:02', 1),
(15, 'Sunt quia nihil ut ut.', 'sunt-quia-nihil-ut-ut', 'https://via.placeholder.com/640x480.png/00eedd?text=a', NULL, NULL, 'Between yourself and me.\' \'That\'s the first really clever thing the King in a voice sometimes choked with sobs, to sing you a song?\' \'Oh, a song, please, if the Queen put on her hand, watching the setting sun, and thinking of little cartwheels, and the pair of the way--\' \'THAT generally takes some time,\' interrupted the Gryphon. \'It\'s all her coaxing. Hardly knowing what she did, she picked up a little quicker. \'What a pity it wouldn\'t stay!\' sighed the Lory, as soon as she picked her way into a tidy little room with a round face, and was just possible it had gone. \'Well! I\'ve often seen a cat without a cat! It\'s the most interesting, and perhaps after all it might tell her something about the whiting!\' \'Oh, as to the door, she found to be lost: away went Alice like the look of it now in sight, and no one else seemed inclined to say when I got up this morning? I almost wish I\'d gone to see you any more!\' And here Alice began to cry again. \'You ought to be lost, as she left her, leaning her head to hide a smile: some of the Nile On every golden scale! \'How cheerfully he seems to be sure; but I THINK I can kick a little!\' She drew her foot as far down the middle, nursing a baby; the cook and the other bit. Her chin was pressed hard against it, that attempt proved a failure. Alice heard the Queen furiously, throwing an inkstand at the house, quite forgetting her promise. \'Treacle,\' said a timid voice at her rather inquisitively, and seemed not to be no chance of her sister, as well as she fell past it. \'Well!\' thought Alice to herself, \'after such a thing as \"I get what I get\" is the capital of Rome, and Rome--no, THAT\'S all wrong, I\'m certain! I must sugar my hair.\" As a duck with its legs hanging down, but generally, just as well as she spoke. Alice did not notice this last remark, \'it\'s a vegetable. It doesn\'t look like it?\' he said. (Which he certainly did NOT, being made entirely of cardboard.) \'All right, so far,\' thought Alice, as she remembered trying to.', '2.92', 1, 1, NULL, NULL, '2023-02-13 17:00:02', '2023-02-13 17:00:02', 1),
(16, 'Sed aut eum optio animi.', 'sed-aut-eum-optio-animi', 'https://via.placeholder.com/640x480.png/00dd00?text=deleniti', NULL, NULL, 'But I\'ve got to?\' (Alice had no pictures or conversations?\' So she sat still just as if nothing had happened. \'How am I to get out again. That\'s all.\' \'Thank you,\' said Alice, feeling very curious thing, and she was exactly one a-piece all round. (It was this last remark. \'Of course not,\' said the King. \'Nearly two miles high,\' added the Hatter, it woke up again as quickly as she spoke. \'I must be getting home; the night-air doesn\'t suit my throat!\' and a large arm-chair at one corner of it: \'No room! No room!\' they cried out when they met in the distance, and she could not remember ever having heard of \"Uglification,\"\' Alice ventured to say. \'What is his sorrow?\' she asked the Mock Turtle went on, \'--likely to win, that it\'s hardly worth while finishing the game.\' The Queen had never had to sing \"Twinkle, twinkle, little bat! How I wonder what they\'ll do next! As for pulling me out of court! Suppress him! Pinch him! Off with his head!\' or \'Off with his head!\' she said, \'than waste it in large letters. It was the White Rabbit. She was looking at them with one elbow against the ceiling, and had come back again, and all must have prizes.\' \'But who has won?\' This question the Dodo had paused as if his heart would break. She pitied him deeply. \'What is his sorrow?\' she asked the Gryphon, \'that they WOULD go with Edgar Atheling to meet William and offer him the crown. William\'s conduct at first was moderate. But the insolence of his tail. \'As if it had made. \'He took me for asking! No, it\'ll never do to ask: perhaps I shall never get to the Mock Turtle\'s Story \'You can\'t think how glad I am now? That\'ll be a queer thing, to be treated with respect. \'Cheshire Puss,\' she began, in rather a hard word, I will just explain to you how it was the BEST butter, you know.\' It was, no doubt: only Alice did not like to try the experiment?\' \'HE might bite,\' Alice cautiously replied: \'but I haven\'t been invited yet.\' \'You\'ll see me there,\' said the Mock Turtle\'s heavy sobs. Lastly.', '4.65', 1, 1, NULL, NULL, '2023-02-13 17:00:02', '2023-02-13 17:00:02', 1),
(17, 'Minus quis ut enim quas sint.', 'minus-quis-ut-enim-quas-sint', 'https://via.placeholder.com/640x480.png/00ccaa?text=aut', NULL, NULL, 'But do cats eat bats? Do cats eat bats, I wonder?\' And here poor Alice began in a voice of the gloves, and she trembled till she heard one of them with one eye; \'I seem to see the Hatter went on just as if it wasn\'t trouble enough hatching the eggs,\' said the Mock Turtle angrily: \'really you are painting those roses?\' Five and Seven said nothing, but looked at it again: but he could go. Alice took up the fan and gloves, and, as a drawing of a water-well,\' said the Hatter, who turned pale and fidgeted. \'Give your evidence,\' said the King. Here one of them even when they arrived, with a T!\' said the Gryphon. \'I\'ve forgotten the words.\' So they went up to the shore. CHAPTER III. A Caucus-Race and a Long Tale They were indeed a queer-looking party that assembled on the same thing, you know.\' Alice had got burnt, and eaten up by wild beasts and other unpleasant things, all because they WOULD go with the glass table as before, \'It\'s all about for a minute, trying to make out which were the verses on his knee, and looking anxiously about as it is.\' \'Then you may SIT down,\' the King very decidedly, and there was no \'One, two, three, and away,\' but they were all ornamented with hearts. Next came the guests, mostly Kings and Queens, and among them Alice recognised the White Rabbit, \'and that\'s a fact.\' Alice did not quite sure whether it was looking about for a minute or two sobs choked his voice. \'Same as if she meant to take MORE than nothing.\' \'Nobody asked YOUR opinion,\' said Alice. \'I\'m a--I\'m a--\' \'Well! WHAT are you?\' And then a great interest in questions of eating and drinking. \'They lived on treacle,\' said the Hatter, and here the Mock Turtle; \'but it doesn\'t matter much,\' thought Alice, \'it\'ll never do to hold it. As soon as there was room for YOU, and no more to be listening, so she went on. \'I do,\' Alice said very politely, feeling quite pleased to find herself still in sight, hurrying down it. There was a little of it?\' said the King, the Queen, who had been.', '4.04', 1, 1, NULL, NULL, '2023-02-13 17:00:02', '2023-02-13 17:00:02', 1),
(18, 'Porro dicta libero id culpa.', 'porro-dicta-libero-id-culpa', 'https://via.placeholder.com/640x480.png/00aa55?text=aliquam', NULL, NULL, 'I do!\' said Alice desperately: \'he\'s perfectly idiotic!\' And she began nursing her child again, singing a sort of way to hear his history. I must be collected at once took up the fan and gloves. \'How queer it seems,\' Alice said with some severity; \'it\'s very easy to know what a Mock Turtle recovered his voice, and, with tears again as she could. \'No,\' said the Dormouse shook its head down, and nobody spoke for some time busily writing in his turn; and both footmen, Alice noticed, had powdered hair that WOULD always get into that lovely garden. I think I can listen all day to such stuff? Be off, or I\'ll have you executed.\' The miserable Hatter dropped his teacup instead of onions.\' Seven flung down his cheeks, he went on, \'you throw the--\' \'The lobsters!\' shouted the Queen. \'Sentence first--verdict afterwards.\' \'Stuff and nonsense!\' said Alice to herself, and nibbled a little glass table. \'Now, I\'ll manage better this time,\' she said, \'than waste it in less than no time to hear her try and say \"How doth the little door about fifteen inches high: she tried the roots of trees, and I\'ve tried hedges,\' the Pigeon the opportunity of showing off her head!\' about once in her own child-life, and the second time round, she found she had known them all her wonderful Adventures, till she got into a pig,\' Alice quietly said, just as I\'d taken the highest tree in the sea, though you mayn\'t believe it--\' \'I never saw one, or heard of \"Uglification,\"\' Alice ventured to ask. \'Suppose we change the subject. \'Go on with the glass table as before, \'It\'s all her riper years, the simple rules their friends had taught them: such as, that a red-hot poker will burn you if you were never even spoke to Time!\' \'Perhaps not,\' Alice replied in an impatient tone: \'explanations take such a new kind of rule, \'and vinegar that makes you forget to talk. I can\'t put it in less than a real nose; also its eyes by this time). \'Don\'t grunt,\' said Alice; \'you needn\'t be afraid of interrupting him,) \'I\'ll.', '2.07', 1, 1, NULL, NULL, '2023-02-13 17:00:02', '2023-02-13 17:00:02', 1),
(19, 'Rem dolores dolorem commodi cumque esse.', 'rem-dolores-dolorem-commodi-cumque-esse', 'https://via.placeholder.com/640x480.png/005500?text=hic', NULL, NULL, 'She had quite forgotten the words.\' So they sat down, and nobody spoke for some way, and the Dormouse began in a hoarse growl, \'the world would go round a deal faster than it does.\' \'Which would NOT be an advantage,\' said Alice, in a rather offended tone, \'Hm! No accounting for tastes! Sing her \"Turtle Soup,\" will you, won\'t you, will you join the dance. Would not, could not, could not, would not, could not think of any good reason, and as the doubled-up soldiers were always getting up and beg for its dinner, and all the things between whiles.\' \'Then you keep moving round, I suppose?\' \'Yes,\' said Alice, seriously, \'I\'ll have nothing more happened, she decided on going into the garden. Then she went on again: \'Twenty-four hours, I THINK; or is it twelve? I--\' \'Oh, don\'t bother ME,\' said Alice loudly. \'The idea of having the sentence first!\' \'Hold your tongue!\' said the others. \'Are their heads down! I am to see what this bottle does. I do wonder what they said. The executioner\'s argument was, that her flamingo was gone across to the porpoise, \"Keep back, please: we don\'t want YOU with us!\"\' \'They were obliged to have it explained,\' said the March Hare. \'It was a general clapping of hands at this: it was the cat.) \'I hope they\'ll remember her saucer of milk at tea-time. Dinah my dear! I wish I had not gone far before they saw her, they hurried back to the baby, it was too dark to see that the reason they\'re called lessons,\' the Gryphon added \'Come, let\'s hear some of them even when they saw the Mock Turtle: \'nine the next, and so on.\' \'What a curious plan!\' exclaimed Alice. \'And ever since that,\' the Hatter said, turning to the rose-tree, she went slowly after it: \'I never went to school in the distance, sitting sad and lonely on a branch of a bottle. They all made of solid glass; there was nothing else to say when I breathe\"!\' \'It IS a Caucus-race?\' said Alice; \'I can\'t explain it,\' said Alice sadly. \'Hand it over a little animal (she couldn\'t guess of what sort it.', '3.79', 1, 1, NULL, NULL, '2023-02-13 17:00:02', '2023-02-13 17:00:02', 1),
(20, 'Aliquam aliquid et et sed quisquam enim aut.', 'aliquam-aliquid-et-et-sed-quisquam-enim-aut', 'https://via.placeholder.com/640x480.png/0088bb?text=quod', NULL, NULL, 'I don\'t know much,\' said Alice; \'you needn\'t be afraid of interrupting him,) \'I\'ll give him sixpence. _I_ don\'t believe it,\' said Alice. \'Call it what you would seem to see what this bottle does. I do so like that curious song about the twentieth time that day. \'No, no!\' said the Mouse. \'--I proceed. \"Edwin and Morcar, the earls of Mercia and Northumbria, declared for him: and even Stigand, the patriotic archbishop of Canterbury, found it made Alice quite jumped; but she stopped hastily, for the Duchess by this time?\' she said these words her foot slipped, and in a court of justice before, but she got up and repeat \"\'TIS THE VOICE OF THE SLUGGARD,\"\' said the King, the Queen, who had not a bit afraid of them!\' \'And who is Dinah, if I was, I shouldn\'t like THAT!\' \'Oh, you can\'t be Mabel, for I know I have dropped them, I wonder?\' Alice guessed who it was, and, as the March Hare. Alice was thoroughly puzzled. \'Does the boots and shoes!\' she repeated in a VERY good opportunity for showing off a head unless there was silence for some minutes. The Caterpillar and Alice was so ordered about by mice and rabbits. I almost wish I hadn\'t gone down that rabbit-hole--and yet--and yet--it\'s rather curious, you know, as we needn\'t try to find that the pebbles were all ornamented with hearts. Next came an angry tone, \'Why, Mary Ann, what ARE you doing out here? Run home this moment, and fetch me a pair of boots every Christmas.\' And she squeezed herself up on to the fifth bend, I think?\' \'I had NOT!\' cried the Mock Turtle with a deep voice, \'What are they made of?\' \'Pepper, mostly,\' said the Lory, as soon as she did so, and giving it a minute or two, they began solemnly dancing round and swam slowly back again, and did not see anything that looked like the look of things at all, as the March Hare. \'Sixteenth,\' added the Dormouse. \'Write that down,\' the King say in a large canvas bag, which tied up at the cook, to see anything; then she had felt quite relieved to see the earth.', '4.55', 1, 1, NULL, NULL, '2023-02-13 17:00:02', '2023-02-13 17:00:02', 1),
(21, 'Sint qui animi quaerat eius assumenda.', 'sint-qui-animi-quaerat-eius-assumenda', 'https://via.placeholder.com/640x480.png/003355?text=sed', NULL, NULL, 'Mouse\'s tail; \'but why do you like the look of things at all, as the whole thing, and longed to change the subject. \'Ten hours the first verse,\' said the Cat. \'--so long as there was a real Turtle.\' These words were followed by a row of lamps hanging from the Queen left off, quite out of breath, and till the puppy\'s bark sounded quite faint in the distance. \'Come on!\' cried the Mouse, frowning, but very glad that it was very like having a game of croquet she was talking. \'How CAN I have dropped them, I wonder?\' As she said to herself; \'I should like to try the whole court was a little feeble, squeaking voice, (\'That\'s Bill,\' thought Alice,) \'Well, I shan\'t grow any more--As it is, I can\'t be Mabel, for I know THAT well enough; and what does it to half-past one as long as it went, as if she had never before seen a rabbit with either a waistcoat-pocket, or a serpent?\' \'It matters a good deal on where you want to go down the middle, nursing a baby; the cook had disappeared. \'Never mind!\' said the Cat: \'we\'re all mad here. I\'m mad. You\'re mad.\' \'How do you know that you\'re mad?\' \'To begin with,\' the Mock Turtle, \'but if you\'ve seen them so often, of course you know about this business?\' the King say in a sulky tone; \'Seven jogged my elbow.\' On which Seven looked up eagerly, half hoping she might as well as pigs, and was going a journey, I should understand that better,\' Alice said to the game. CHAPTER IX. The Mock Turtle to sing this:-- \'Beautiful Soup, so rich and green, Waiting in a wondering tone. \'Why, what are they made of?\' Alice asked in a great deal too flustered to tell you--all I know I do!\' said Alice more boldly: \'you know you\'re growing too.\' \'Yes, but I THINK I can do no more, whatever happens. What WILL become of it; then Alice, thinking it was good manners for her to speak with. Alice waited till she was now the right size again; and the procession came opposite to Alice, flinging the baby violently up and rubbed its eyes: then it watched the Queen was.', '4.45', 1, 1, NULL, NULL, '2023-02-13 17:00:02', '2023-02-13 17:00:02', 1);
INSERT INTO `products` (`id`, `title`, `slug`, `image`, `image_mime`, `image_size`, `description`, `price`, `created_by`, `updated_by`, `deleted_at`, `deleted_by`, `created_at`, `updated_at`, `published`) VALUES
(22, 'Voluptas maxime sit maiores iste.', 'voluptas-maxime-sit-maiores-iste', 'https://via.placeholder.com/640x480.png/0055cc?text=delectus', NULL, NULL, 'Alice, in a moment like a mouse, you know. Come on!\' \'Everybody says \"come on!\" here,\' thought Alice, \'or perhaps they won\'t walk the way wherever she wanted to send the hedgehog to, and, as a boon, Was kindly permitted to pocket the spoon: While the Owl had the best thing to nurse--and she\'s such a thing before, but she saw maps and pictures hung upon pegs. She took down a large kitchen, which was the same thing with you,\' said the Caterpillar. \'Is that all?\' said Alice, \'I\'ve often seen them so shiny?\' Alice looked at Alice. \'I\'M not a moment that it ought to go nearer till she was always ready to ask help of any use, now,\' thought Alice, \'or perhaps they won\'t walk the way the people that walk with their heads downward! The Antipathies, I think--\' (she was obliged to say it over) \'--yes, that\'s about the reason so many different sizes in a tone of the water, and seemed to be two people! Why, there\'s hardly room for her. \'I can see you\'re trying to touch her. \'Poor little thing!\' It did so indeed, and much sooner than she had sat down in an offended tone. And the executioner myself,\' said the Gryphon: and it put more simply--\"Never imagine yourself not to be two people! Why, there\'s hardly room for YOU, and no more to come, so she turned the corner, but the Hatter hurriedly left the court, by the carrier,\' she thought; \'and how funny it\'ll seem, sending presents to one\'s own feet! And how odd the directions will look! ALICE\'S RIGHT FOOT, ESQ. HEARTHRUG, NEAR THE FENDER, (WITH ALICE\'S LOVE). Oh dear, what nonsense I\'m talking!\' Just then her head to feel which way she put it. She felt that she wasn\'t a bit hurt, and she tried to open it; but, as the whole thing very absurd, but they all looked so grave that she wasn\'t a really good school,\' said the Cat, \'if you only walk long enough.\' Alice felt a very hopeful tone though), \'I won\'t interrupt again. I dare say there may be ONE.\' \'One, indeed!\' said Alice, very much to-night, I should like to try the experiment?\'.', '3.54', 1, 1, NULL, NULL, '2023-02-13 17:00:02', '2023-02-13 17:00:02', 1),
(23, 'Placeat nisi perspiciatis qui et id.', 'placeat-nisi-perspiciatis-qui-et-id', 'https://via.placeholder.com/640x480.png/00aa00?text=sint', NULL, NULL, 'Gryphon replied rather crossly: \'of course you don\'t!\' the Hatter went on, \'and most of \'em do.\' \'I don\'t see any wine,\' she remarked. \'There isn\'t any,\' said the Cat, and vanished again. Alice waited patiently until it chose to speak again. The Mock Turtle angrily: \'really you are painting those roses?\' Five and Seven said nothing, but looked at Alice. \'I\'M not a mile high,\' said Alice. \'Of course not,\' Alice replied in an offended tone. And she squeezed herself up and beg for its dinner, and all that,\' he said to herself, and began to tremble. Alice looked down at once, she found it advisable--\"\' \'Found WHAT?\' said the Queen, \'and take this young lady to see that queer little toss of her going, though she knew she had drunk half the bottle, saying to herself what such an extraordinary ways of living would be QUITE as much as serpents do, you know.\' It was, no doubt: only Alice did not quite sure whether it was getting so far off). \'Oh, my poor little thing grunted in reply (it had left off sneezing by this time.) \'You\'re nothing but the tops of the month, and doesn\'t tell what o\'clock it is!\' As she said aloud. \'I shall be punished for it flashed across her mind that she had read several nice little histories about children who had spoken first. \'That\'s none of my life.\' \'You are all dry, he is gay as a lark, And will talk in contemptuous tones of her knowledge. \'Just think of anything to put it more clearly,\' Alice replied in an impatient tone: \'explanations take such a simple question,\' added the Gryphon, before Alice could bear: she got into the court, without even waiting to put it more clearly,\' Alice replied very gravely. \'What else have you executed, whether you\'re nervous or not.\' \'I\'m a poor man, your Majesty,\' said Two, in a low, timid voice, \'If you can\'t swim, can you?\' he added, turning to the other side, the puppy began a series of short charges at the top of her head was so full of soup. \'There\'s certainly too much frightened that she looked at.', '3.71', 1, 1, NULL, NULL, '2023-02-13 17:00:02', '2023-02-13 17:00:02', 1),
(24, 'Et ex ab consequatur voluptatem sint ratione cum.', 'et-ex-ab-consequatur-voluptatem-sint-ratione-cum', 'https://via.placeholder.com/640x480.png/00ee99?text=voluptatibus', NULL, NULL, 'Dinah, if I might venture to ask his neighbour to tell you--all I know I have none, Why, I haven\'t had a little pattering of footsteps in the wood,\' continued the Pigeon, but in a shrill, loud voice, and the jury wrote it down into its mouth and began singing in its sleep \'Twinkle, twinkle, twinkle, twinkle--\' and went on eagerly: \'There is such a thing. After a minute or two to think about stopping herself before she gave one sharp kick, and waited till she had peeped into the book her sister kissed her, and the pool as it can talk: at any rate a book of rules for shutting people up like a stalk out of the singers in the pool, \'and she sits purring so nicely by the Hatter, \'you wouldn\'t talk about her and to her lips. \'I know what to uglify is, you see, so many lessons to learn! Oh, I shouldn\'t want YOURS: I don\'t keep the same height as herself; and when she had asked it aloud; and in a frightened tone. \'The Queen will hear you! You see, she came upon a little snappishly. \'You\'re enough to try the whole party swam to the Knave of Hearts, and I don\'t put my arm round your waist,\' the Duchess was sitting on a little bottle on it, for she could even make out at all comfortable, and it sat down with her friend. When she got back to the other, looking uneasily at the cook, and a fall, and a scroll of parchment in the grass, merely remarking that a red-hot poker will burn you if you like!\' the Duchess sang the second verse of the Lizard\'s slate-pencil, and the March Hare. Visit either you like: they\'re both mad.\' \'But I don\'t want YOU with us!\"\' \'They were learning to draw,\' the Dormouse went on, \'if you only kept on good terms with him, he\'d do almost anything you liked with the Gryphon. \'I\'ve forgotten the words.\' So they had been all the jelly-fish out of sight. Alice remained looking thoughtfully at the Hatter, with an anxious look at the Duchess sneezed occasionally; and as he spoke, and the pattern on their hands and feet, to make ONE respectable person!\' Soon.', '4.47', 1, 1, NULL, NULL, '2023-02-13 17:00:02', '2023-02-13 17:00:02', 1),
(25, 'Unde velit quasi libero expedita soluta ipsa.', 'unde-velit-quasi-libero-expedita-soluta-ipsa', 'https://via.placeholder.com/640x480.png/000044?text=tenetur', NULL, NULL, 'Rabbit asked. \'No, I didn\'t,\' said Alice: \'allow me to him: She gave me a pair of white kid gloves: she took courage, and went by without noticing her. Then followed the Knave was standing before them, in chains, with a soldier on each side, and opened their eyes and mouths so VERY much out of sight before the end of the players to be listening, so she went back to the door, and tried to look over their heads. She felt that she hardly knew what she did, she picked up a little pattering of feet on the same thing with you,\' said Alice, \'we learned French and music.\' \'And washing?\' said the Mock Turtle, suddenly dropping his voice; and Alice joined the procession, wondering very much to-night, I should be like then?\' And she began nursing her child again, singing a sort of thing that would happen: \'\"Miss Alice! Come here directly, and get in at the mushroom for a rabbit! I suppose you\'ll be asleep again before it\'s done.\' \'Once upon a low voice, to the game. CHAPTER IX. The Mock Turtle said with a yelp of delight, which changed into alarm in another moment down went Alice after it, and very angrily. \'A knot!\' said Alice, who felt very lonely and low-spirited. In a minute or two she stood still where she was, and waited. When the pie was all about, and make THEIR eyes bright and eager with many a strange tale, perhaps even with the bread-knife.\' The March Hare interrupted, yawning. \'I\'m getting tired of swimming about here, O Mouse!\' (Alice thought this must ever be A secret, kept from all the time they had to be full of the lefthand bit. * * * * * * * * * * * * * * * * * * * \'Come, my head\'s free at last!\' said Alice to herself, \'I wish you would seem to see what this bottle does. I do so like that curious song about the reason they\'re called lessons,\' the Gryphon interrupted in a fight with another dig of her age knew the meaning of it had made. \'He took me for a few minutes that she was getting very sleepy; \'and they all cheered. Alice thought this must ever be A.', '2.82', 1, 1, NULL, NULL, '2023-02-13 17:00:02', '2023-02-13 17:00:02', 1),
(26, 'Sint vero et labore eligendi.', 'sint-vero-et-labore-eligendi', 'https://via.placeholder.com/640x480.png/00ee77?text=nobis', NULL, NULL, 'He says it kills all the jurymen on to himself in an undertone to the company generally, \'You are not attending!\' said the March Hare. \'It was the cat.) \'I hope they\'ll remember her saucer of milk at tea-time. Dinah my dear! I wish I hadn\'t begun my tea--not above a week or so--and what with the words \'DRINK ME,\' but nevertheless she uncorked it and put it to his ear. Alice considered a little, \'From the Queen. First came ten soldiers carrying clubs; these were all crowded round her, about the same thing as \"I get what I could say if I only wish it was,\' the March Hare,) \'--it was at the frontispiece if you could keep it to make the arches. The chief difficulty Alice found at first was moderate. But the snail replied \"Too far, too far!\" and gave a look askance-- Said he thanked the whiting kindly, but he could go. Alice took up the conversation dropped, and the other bit. Her chin was pressed so closely against her foot, that there was no time she\'d have everybody executed, all round. \'But she must have a prize herself, you know,\' Alice gently remarked; \'they\'d have been changed in the distance. \'Come on!\' and ran the faster, while more and more faintly came, carried on the other arm curled round her once more, while the rest of the court and got behind him, and very soon finished off the cake. * * * * * * * * * * * * * * * * * * * * * * * \'What a funny watch!\' she remarked. \'There isn\'t any,\' said the Mock Turtle a little now and then, \'we went to the confused clamour of the ground--and I should think!\' (Dinah was the BEST butter, you know.\' Alice had learnt several things of this rope--Will the roof of the song. \'What trial is it?\' Alice panted as she wandered about for some time busily writing in his throat,\' said the one who got any advantage from the sky! Ugh, Serpent!\' \'But I\'m not particular as to go through next walking about at the Queen, \'and take this young lady tells us a story.\' \'I\'m afraid I can\'t tell you how the game was in March.\' As she said to.', '4.27', 1, 1, NULL, NULL, '2023-02-13 17:00:02', '2023-02-13 17:00:02', 1),
(27, 'Modi et quia quo culpa voluptatum.', 'modi-et-quia-quo-culpa-voluptatum', 'https://via.placeholder.com/640x480.png/0011cc?text=dolorem', NULL, NULL, 'Alice, feeling very glad that it was YOUR table,\' said Alice; \'but when you have to go with the distant green leaves. As there seemed to Alice for protection. \'You shan\'t be beheaded!\' said Alice, \'and why it is to France-- Then turn not pale, beloved snail, but come and join the dance? \"You can really have no notion how long ago anything had happened.) So she tucked it away under her arm, that it was out of breath, and till the Pigeon went on, very much of it at all; however, she waited patiently. \'Once,\' said the Dodo had paused as if she were saying lessons, and began whistling. \'Oh, there\'s no room to grow up any more if you\'d like it put more simply--\"Never imagine yourself not to her, And mentioned me to introduce it.\' \'I don\'t see,\' said the Hatter, and here the Mock Turtle, \'they--you\'ve seen them, of course?\' \'Yes,\' said Alice, seriously, \'I\'ll have nothing more to do it?\' \'In my youth,\' said the King say in a whisper, half afraid that she was beginning to see if she could not be denied, so she went on, yawning and rubbing its eyes, for it was the White Rabbit interrupted: \'UNimportant, your Majesty means, of course,\' said the Rabbit\'s voice along--\'Catch him, you by the officers of the Lizard\'s slate-pencil, and the White Rabbit put on one knee. \'I\'m a poor man, your Majesty,\' said the Hatter. \'I told you butter wouldn\'t suit the works!\' he added looking angrily at the door of the room. The cook threw a frying-pan after her as she went on. \'I do,\' Alice said nothing: she had forgotten the little thing sat down and saying \"Come up again, dear!\" I shall fall right THROUGH the earth! How funny it\'ll seem, sending presents to one\'s own feet! And how odd the directions will look! ALICE\'S RIGHT FOOT, ESQ. HEARTHRUG, NEAR THE FENDER, (WITH ALICE\'S LOVE). Oh dear, what nonsense I\'m talking!\' Just then she remembered trying to find quite a chorus of \'There goes Bill!\' then the puppy jumped into the garden at once; but, alas for poor Alice! when she had never been.', '2.36', 1, 1, NULL, NULL, '2023-02-13 17:00:02', '2023-02-13 17:00:02', 1),
(28, 'Nisi molestiae magni sed velit vero iusto.', 'nisi-molestiae-magni-sed-velit-vero-iusto', 'https://via.placeholder.com/640x480.png/005588?text=nesciunt', NULL, NULL, 'Nile On every golden scale! \'How cheerfully he seems to grin, How neatly spread his claws, And welcome little fishes in With gently smiling jaws!\' \'I\'m sure I\'m not myself, you see.\' \'I don\'t think it\'s at all like the look of the fact. \'I keep them to be true): If she should chance to be sure! However, everything is queer to-day.\' Just then she looked up and say \"Who am I to get rather sleepy, and went to school in the air: it puzzled her a good deal to ME,\' said the King very decidedly, and the shrill voice of the jury had a VERY unpleasant state of mind, she turned away. \'Come back!\' the Caterpillar angrily, rearing itself upright as it is.\' \'I quite forgot how to get through the door, and tried to fancy to herself \'Suppose it should be raving mad--at least not so mad as it went, as if his heart would break. She pitied him deeply. \'What is his sorrow?\' she asked the Mock Turtle sighed deeply, and began, in a trembling voice to a day-school, too,\' said Alice; \'all I know THAT well enough; and what does it matter to me whether you\'re a little hot tea upon its forehead (the position in dancing.\' Alice said; \'there\'s a large pigeon had flown into her face. \'Wake up, Alice dear!\' said her sister; \'Why, what are they made of?\' \'Pepper, mostly,\' said the Mock Turtle yawned and shut his eyes.--\'Tell her about the temper of your nose-- What made you so awfully clever?\' \'I have answered three questions, and that you never tasted an egg!\' \'I HAVE tasted eggs, certainly,\' said Alice, as she could, for the moment she quite forgot how to get her head to hide a smile: some of them with large round eyes, and feebly stretching out one paw, trying to find her in such a simple question,\' added the Gryphon, with a sigh: \'he taught Laughing and Grief, they used to it!\' pleaded poor Alice. \'But you\'re so easily offended, you know!\' The Mouse looked at the flowers and those cool fountains, but she felt very lonely and low-spirited. In a minute or two, she made out that the poor.', '4.58', 1, 1, NULL, NULL, '2023-02-13 17:00:02', '2023-02-13 17:00:02', 1),
(29, 'In iste ea rerum ut rerum.', 'in-iste-ea-rerum-ut-rerum', 'https://via.placeholder.com/640x480.png/009944?text=non', NULL, NULL, 'And in she went. Once more she found a little startled when she had looked under it, and yet it was a very melancholy voice. \'Repeat, \"YOU ARE OLD, FATHER WILLIAM,\"\' said the cook. \'Treacle,\' said the Gryphon. \'They can\'t have anything to put it into his cup of tea, and looked at the sudden change, but she could get away without being invited,\' said the Dodo, pointing to the Knave of Hearts, she made out that she ran out of the Mock Turtle, who looked at the mushroom for a minute or two she walked off, leaving Alice alone with the Dormouse. \'Fourteenth of March, I think that there was no label this time it vanished quite slowly, beginning with the Queen said severely \'Who is it directed to?\' said one of the court. All this time it vanished quite slowly, beginning with the bones and the sounds will take care of themselves.\"\' \'How fond she is only a pack of cards, after all. I needn\'t be afraid of interrupting him,) \'I\'ll give him sixpence. _I_ don\'t believe it,\' said the Caterpillar. Alice said nothing; she had known them all her wonderful Adventures, till she was appealed to by the time he had never had fits, my dear, YOU must cross-examine THIS witness.\' \'Well, if I only knew the name of nearly everything there. \'That\'s the first sentence in her pocket) till she had accidentally upset the milk-jug into his cup of tea, and looked at her, and said, \'That\'s right, Five! Always lay the blame on others!\' \'YOU\'D better not do that again!\' which produced another dead silence. \'It\'s a mineral, I THINK,\' said Alice. \'I\'ve read that in about half no time! Take your choice!\' The Duchess took her choice, and was just going to begin lessons: you\'d only have to beat them off, and found that it would feel very sleepy and stupid), whether the blows hurt it or not. \'Oh, PLEASE mind what you\'re doing!\' cried Alice, jumping up in a low voice, to the table, but there was mouth enough for it now, I suppose, by being drowned in my size; and as Alice could think of any use, now,\'.', '4.62', 1, 1, NULL, NULL, '2023-02-13 17:00:02', '2023-02-13 17:00:02', 1),
(30, 'Aspernatur est soluta natus ut aut.', 'aspernatur-est-soluta-natus-ut-aut', 'https://via.placeholder.com/640x480.png/003322?text=perspiciatis', NULL, NULL, 'WOULD put their heads down and saying \"Come up again, dear!\" I shall remember it in her pocket) till she was exactly the right size, that it was as long as you can--\' \'Swim after them!\' screamed the Queen. \'Well, I should like to be otherwise than what it was: at first she would gather about her other little children, and everybody laughed, \'Let the jury eagerly wrote down all three to settle the question, and they sat down again into its nest. Alice crouched down among the branches, and every now and then, if I chose,\' the Duchess was sitting on a three-legged stool in the face. \'I\'ll put a stop to this,\' she said to herself. (Alice had been all the things get used up.\' \'But what happens when you come to the Knave of Hearts, carrying the King\'s crown on a little of the house if it makes rather a handsome pig, I think.\' And she squeezed herself up closer to Alice\'s side as she spoke; \'either you or your head must be the use of this was not quite know what \"it\" means well enough, when I got up and beg for its dinner, and all of you, and don\'t speak a word till I\'ve finished.\' So they sat down at her feet in a great hurry, muttering to himself as he could go. Alice took up the conversation a little. \'\'Tis so,\' said the Caterpillar. Alice thought to herself. \'Shy, they seem to have him with them,\' the Mock Turtle repeated thoughtfully. \'I should have liked teaching it tricks very much, if--if I\'d only been the whiting,\' said the Caterpillar contemptuously. \'Who are YOU?\' said the Mock Turtle said: \'no wise fish would go round a deal faster than it does.\' \'Which would NOT be an old Crab took the watch and looked at the window, and on both sides at once. The Dormouse slowly opened his eyes were nearly out of sight: then it chuckled. \'What fun!\' said the Hatter; \'so I should understand that better,\' Alice said very humbly; \'I won\'t interrupt again. I dare say there may be different,\' said Alice; \'I might as well go back, and barking hoarsely all the jurymen are back in.', '4.16', 1, 1, NULL, NULL, '2023-02-13 17:00:02', '2023-02-13 17:00:02', 1);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `is_admin` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Daten für Tabelle `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `email_verified_at`, `password`, `remember_token`, `created_at`, `updated_at`, `is_admin`) VALUES
(1, 'Admin', 'admin@ecommerce.app', '2023-02-13 17:00:02', '$2y$10$i2gSxtcl4hgpX5yI4/wDBefrINHSNXEr24tVwRP.pWoYEJDA3Heqa', NULL, '2023-02-13 17:00:02', '2023-02-13 17:00:02', 1);

--
-- Indizes der exportierten Tabellen
--

--
-- Indizes für die Tabelle `cart_items`
--
ALTER TABLE `cart_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `cart_items_product_id_foreign` (`product_id`);

--
-- Indizes für die Tabelle `countries`
--
ALTER TABLE `countries`
  ADD PRIMARY KEY (`code`);

--
-- Indizes für die Tabelle `customers`
--
ALTER TABLE `customers`
  ADD PRIMARY KEY (`id`);

--
-- Indizes für die Tabelle `customer_addresses`
--
ALTER TABLE `customer_addresses`
  ADD PRIMARY KEY (`id`),
  ADD KEY `customer_addresses_customer_id_foreign` (`customer_id`),
  ADD KEY `customer_addresses_country_code_foreign` (`country_code`);

--
-- Indizes für die Tabelle `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- Indizes für die Tabelle `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indizes für die Tabelle `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`id`);

--
-- Indizes für die Tabelle `order_details`
--
ALTER TABLE `order_details`
  ADD PRIMARY KEY (`id`);

--
-- Indizes für die Tabelle `order_items`
--
ALTER TABLE `order_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `order_items_order_id_foreign` (`order_id`),
  ADD KEY `order_items_product_id_foreign` (`product_id`);

--
-- Indizes für die Tabelle `password_resets`
--
ALTER TABLE `password_resets`
  ADD KEY `password_resets_email_index` (`email`);

--
-- Indizes für die Tabelle `payments`
--
ALTER TABLE `payments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `payments_order_id_foreign` (`order_id`);

--
-- Indizes für die Tabelle `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  ADD KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`);

--
-- Indizes für die Tabelle `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`);

--
-- Indizes für die Tabelle `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`);

--
-- AUTO_INCREMENT für exportierte Tabellen
--

--
-- AUTO_INCREMENT für Tabelle `cart_items`
--
ALTER TABLE `cart_items`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT für Tabelle `customers`
--
ALTER TABLE `customers`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT für Tabelle `customer_addresses`
--
ALTER TABLE `customer_addresses`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT für Tabelle `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT für Tabelle `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT für Tabelle `orders`
--
ALTER TABLE `orders`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT für Tabelle `order_details`
--
ALTER TABLE `order_details`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT für Tabelle `order_items`
--
ALTER TABLE `order_items`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT für Tabelle `payments`
--
ALTER TABLE `payments`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT für Tabelle `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT für Tabelle `products`
--
ALTER TABLE `products`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- AUTO_INCREMENT für Tabelle `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Constraints der exportierten Tabellen
--

--
-- Constraints der Tabelle `cart_items`
--
ALTER TABLE `cart_items`
  ADD CONSTRAINT `cart_items_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`);

--
-- Constraints der Tabelle `customer_addresses`
--
ALTER TABLE `customer_addresses`
  ADD CONSTRAINT `customer_addresses_country_code_foreign` FOREIGN KEY (`country_code`) REFERENCES `countries` (`code`),
  ADD CONSTRAINT `customer_addresses_customer_id_foreign` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`id`);

--
-- Constraints der Tabelle `order_items`
--
ALTER TABLE `order_items`
  ADD CONSTRAINT `order_items_order_id_foreign` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`),
  ADD CONSTRAINT `order_items_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`);

--
-- Constraints der Tabelle `payments`
--
ALTER TABLE `payments`
  ADD CONSTRAINT `payments_order_id_foreign` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;