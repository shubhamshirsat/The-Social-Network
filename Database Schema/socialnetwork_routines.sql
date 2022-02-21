-- MySQL dump 10.13  Distrib 8.0.11, for Win64 (x86_64)
--
-- Host: localhost    Database: socialnetwork
-- ------------------------------------------------------
-- Server version	8.0.11

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
 SET NAMES utf8 ;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Dumping events for database 'socialnetwork'
--

--
-- Dumping routines for database 'socialnetwork'
--
/*!50003 DROP PROCEDURE IF EXISTS `acceptRequest` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `acceptRequest`(in senderID int, in receiverID int)
BEGIN
	update friend_request set status = 'Accepted' where sender_id = senderID and receiver_id = receiverID;
	insert into friends(sender_id,receiver_id,status,timestamp) values(senderID,receiverID,'Unblock',current_timestamp);
	call getFriends(receiverID);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `createAccount` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `createAccount`(in f_name varchar(25), in l_name varchar(25), in mail varchar(60), in mob varchar(15), in birth date, in gen varchar(6), in pass varchar(25), in ag int, in path varchar(256))
begin
DECLARE id  INT;

INSERT INTO user(first_name, last_name, email, mobile, dob, gender, password, age, created_date) values(f_name,l_name,mail,mob,birth,gen,pass,20,current_timestamp);
select user_id into id from user where email = mail;
insert into profile(user_id,image_path,about,profession,place,updated_date) values(id,path,'','','',current_timestamp);
select user.user_id, first_name, last_name, email, mobile, dob, gender, age, created_date, image_path, about, profession, place, workplace from user inner join profile on user.user_id = profile.user_id where user.user_id = id;

end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getFriends` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `getFriends`(IN id INT)
BEGIN
SELECT user.user_id,first_name, last_name,image_path FROM user INNER JOIN friends INNER JOIN profile WHERE user.user_id = friends.receiver_id AND user.user_id = profile.user_id  AND friends.sender_id = id UNION SELECT user.user_id,first_name, last_name,image_path FROM user INNER JOIN friends INNER JOIN profile WHERE user.user_id = friends.sender_id AND user.user_id = profile.user_id AND friends.receiver_id =id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `hitLikes` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `hitLikes`(in userid long, in postUserid long, in timestmp timestamp )
BEGIN

update posts set post_likes = post_likes + 1 where user_id = postUserid and post_timestamp = timestmp;
insert into likesby(post_user_id,timestamp,like_by_user_id,status) values(postUserid,timestmp,userid,0);
SELECT post_id, user.user_id, image_path, first_name, last_name, post_type, post_text, post_url, post_likes, post_timestamp FROM user INNER JOIN friends INNER JOIN posts INNER JOIN profile WHERE user.user_id = friends.receiver_id AND posts.user_id = friends.receiver_id AND profile.user_id = friends.receiver_id AND friends.sender_id = userid UNION SELECT post_id, user.user_id, image_path, first_name, last_name, post_type, post_text, post_url, post_likes, post_timestamp FROM user INNER JOIN friends INNER JOIN posts INNER JOIN profile  WHERE user.user_id = friends.sender_id AND posts.user_id = friends.sender_id AND profile.user_id = friends.sender_id AND friends.receiver_id = userid UNION SELECT post_id, user.user_id, image_path, first_name, last_name, post_type, post_text, post_url, post_likes, post_timestamp FROM user INNER JOIN posts INNER JOIN profile WHERE user.user_id = posts.user_id AND profile.user_id = user.user_id AND posts.user_id = userid  ORDER BY post_timestamp DESC;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `mutualFriends` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `mutualFriends`(in login_user_id long, in other_user_id long)
BEGIN

			SELECT user.user_id, first_name, last_name, image_path from user inner join profile on (user.user_id = profile.user_id) where user.user_id IN
				(SELECT user_id from user where user_id IN 
					(select t1.user_id from (select user.user_id from user inner join friends where (user.user_id = friends.receiver_id and friends.sender_id = login_user_id) OR (user.user_id = friends.sender_id and friends.receiver_id = login_user_id)) t1 
					inner join 
					(select user.user_id from user inner join friends where (user.user_id = friends.receiver_id and friends.sender_id = other_user_id) OR (user.user_id = friends.sender_id and friends.receiver_id = other_user_id)) t2 on t1.user_id = t2.user_id));

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `saveAndGetMessage` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `saveAndGetMessage`(in senderID int, in receiverID int, in message varchar(1000), in url varchar(256))
BEGIN
insert into chats(sender_id,receiver_id,message,url,message_timestamp) values(senderID,receiverID,message,url,current_timestamp);
select * from chats where sender_id = senderID and receiver_id = receiverID OR sender_id = receiverID and receiver_id = senderID;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `SuggestedFriends` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `SuggestedFriends`(in login_user_id long, in login_user_place varchar(30), in login_user_workplace varchar(100))
BEGIN



	DECLARE done INT DEFAULT FALSE;
	DECLARE uid long;
    
    -- Loads logged in user's friend list
	DECLARE login_user_friendlist cursor for select user.user_id from user inner join friends where (user.user_id = friends.receiver_id and friends.sender_id = login_user_id) OR (user.user_id = friends.sender_id and friends.receiver_id = login_user_id);
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

	
    drop table if exists MutualFriendCount;
    drop table if exists recommended_user;		
    
    -- temporary table to store fitered user
	create temporary table recommended_user(userid int primary key);

	open login_user_friendlist;
	read_loop: LOOP
 
		fetch login_user_friendlist into uid;
 
			IF done THEN
				LEAVE read_loop;
			END IF;
   

		insert ignore into recommended_user(userid) 
    
		-- Retrives the filtered data( friends of friends is subtracted from my list) and insert into table

		select t1.user_id from 
		(select user.user_id from user inner join friends where (user.user_id = friends.receiver_id and friends.sender_id = uid) OR (user.user_id = friends.sender_id and friends.receiver_id = uid)) t1 
		left outer join 
		(select user.user_id from user inner join friends where (user.user_id = friends.receiver_id and friends.sender_id = login_user_id) OR (user.user_id = friends.sender_id and friends.receiver_id = login_user_id)) t2 
		on (t1.user_id = t2.user_id) 
		where (t2.user_id is null) and (t1.user_id <> login_user_id);
    
	END LOOP;

	-- inserts the filtered users (having same workplace and city, or same workplace and which are not logged in users friends)
	insert ignore into recommended_user(userid) 
	select user.user_id from user where user.user_id in (select user_id from profile where (place=login_user_place and workplace=login_user_workplace) OR (workplace = login_user_workplace)) and user.user_id not in (select user.user_id from user inner join friends where (user.user_id = friends.receiver_id and friends.sender_id = login_user_id) OR (user.user_id = friends.sender_id and friends.receiver_id = login_user_id)) and user.user_id <> login_user_id;



	-- INNER BLOCK TO COUNT MUTUAL FRIENDS OF EACH USER
    BEGIN
		
        declare complete int default false;
        declare rec_user_id int;
        declare mutual_friend_count int;
        
		declare cur_recommended_user cursor for select userid from recommended_user;
		declare continue handler for not found set complete = true;
        
        open cur_recommended_user;
        create temporary table MutualFriendCount(userid long, friend_count int);
        
        read_loop: LOOP

			fetch cur_recommended_user into rec_user_id;
            
            if complete then
				leave read_loop;
			end if;
        
			SELECT count(user_id) into mutual_friend_count from user where user_id IN 
            (select t1.user_id from (select user.user_id from user inner join friends where (user.user_id = friends.receiver_id and friends.sender_id = login_user_id) OR (user.user_id = friends.sender_id and friends.receiver_id = login_user_id)) t1 
            inner join 
            (select user.user_id from user inner join friends where (user.user_id = friends.receiver_id and friends.sender_id = rec_user_id) OR (user.user_id = friends.sender_id and friends.receiver_id = rec_user_id)) t2 on t1.user_id = t2.user_id);
        
        
			if mutual_friend_count > 1 then
					insert into MutualFriendCount(userid, friend_count) values(rec_user_id, mutual_friend_count);
			end if;
        
		end loop;
        close cur_recommended_user;
		
    END;    
    -- INNER BLOCK ENDS
    
     select user.user_id, first_name, last_name, friend_count, image_path from MutualFriendCount inner join user inner join profile on (MutualFriendCount.userid = user.user_id and user.user_id = profile.user_id) order by friend_count desc;
    
    drop table MutualFriendCount;
	drop table recommended_user;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `updatePost` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `updatePost`(in userid int, in postType varchar(12), in postText varchar(1000), in postURL varchar(512), in postLikes int)
BEGIN

INSERT INTO posts(user_id,post_type,post_text,post_url,post_likes,post_timestamp) values(userid, postType,postText,postURL,postLikes,current_timestamp);

SELECT post_id, user.user_id, image_path, first_name, last_name, post_type, post_text, post_url, post_likes, post_timestamp FROM user INNER JOIN friends INNER JOIN posts INNER JOIN profile WHERE user.user_id = friends.receiver_id AND posts.user_id = friends.receiver_id AND profile.user_id = friends.receiver_id AND friends.sender_id = userid UNION SELECT post_id, user.user_id, image_path, first_name, last_name, post_type, post_text, post_url, post_likes, post_timestamp FROM user INNER JOIN friends INNER JOIN posts INNER JOIN profile  WHERE user.user_id = friends.sender_id AND posts.user_id = friends.sender_id AND profile.user_id = friends.sender_id AND friends.receiver_id = userid UNION SELECT post_id, user.user_id, image_path, first_name, last_name, post_type, post_text, post_url, post_likes, post_timestamp FROM user INNER JOIN posts INNER JOIN profile WHERE user.user_id = posts.user_id AND profile.user_id = user.user_id AND posts.user_id = userid  ORDER BY post_timestamp DESC;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `updateProfile` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `updateProfile`(in path varchar(256), in abt varchar(256), in prof varchar(50), in plc varchar(30), in workplce varchar(50), in id int)
BEGIN
		update profile set image_path = path, about = abt, profession = prof, place = plc, workplace=workplce where user_id = id;
        select user.user_id, first_name, last_name, email, mobile, dob, gender, age, image_path, about, profession, place, workplace from user inner join profile on user.user_id = profile.user_id where user.user_id = id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-09-04  9:55:34
