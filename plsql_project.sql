DECLARE
   
   CREATE TABLE user_info(
		account_name VARCHAR2(25) NOT NULL PRIMARY KEY,
		email  VARCHAR2(50) NOT NULL,
		password VARCHAR2(15) NOT NULL ,
		f_name VARCHAR2(15) NOT NULL ,
		l_name VARCHAR2(15) NOT NULL
	);
	
	
CREATE SEQUENCE game_sequence
    MINVALUE 1
    MAXVALUE 9999
    START WITH 1
    INCREMENT BY 1
    CACHE 20;	


CREATE SEQUENCE shuffle_sequence
    MINVALUE 1
    MAXVALUE 52
    START WITH 1
    INCREMENT BY 1
    CACHE 20;
	
   CREATE TABLE game_info(
		g_id INTEGER NOT NULL PRIMARY KEY,
		g_date Date NOT NULL,
		g_player1 VARCHAR2(25) NOT NULL,
		g_player2 VARCHAR2(25),
		g_player3 VARCHAR2(25),
		resume char(1) DEFAULT 'F'
	);
	
  CREATE TABLE player_game_info(
		account_name VARCHAR2(25) NOT NULL PRIMARY KEY,
		game_id NOT NULL UNIQUE KEY,
		wins INTEGER,
		loss INTEGER,
		aborted_games INTEGER,
		win_percentage NUMBER(3,2),
		loss_percentage NUMBER(3,2)
	);
	
  CREATE TABLE game_players_cards(
       g_id INTEGER NOT NULL PRIMARY KEY,
	   g_player VARCHAR2(25) NOT NULL,
	   card_id INTEGER 
	);
	--check code
	CREATE TABLE Deck_Cards(
		card_id INTEGER IDENTITY(1,1) PRIMARY KEY NOT NULL,
		card_name VARCHAR2(10) NOT NULL,
		card_min_val INTEGER NOT NULL,
		card_max_val INTEGER NOT NULL);
	
	CREATE TABLE ShuffledDeck(
	    shuffle_id INTEGER PRIMARY KEY NOT NULL,
		card_name VARCHAR2(10) NOT NULL
	);
	
--INSERT CARD AND THEIR VALUES
INSERT INTO Deck_Cards VALUES (1,'D.A', 1, 11);
INSERT INTO Deck_Cards VALUES (2,'D.2', 2, 2);
INSERT INTO Deck_Cards VALUES (3,'D.3', 3, 3);
INSERT INTO Deck_Cards VALUES (4,'D.4', 4, 4);
INSERT INTO Deck_Cards VALUES (5,'D.5', 5, 5);
INSERT INTO Deck_Cards VALUES (6,'D.6', 6, 6);
INSERT INTO Deck_Cards VALUES (7,'D.7', 7, 7);
INSERT INTO Deck_Cards VALUES (8,'D.8', 8, 8);
INSERT INTO Deck_Cards VALUES (9,'D.9', 9, 9);
INSERT INTO Deck_Cards VALUES (10,'D.10', 10, 10);
INSERT INTO Deck_Cards VALUES (11,'D.J', 10, 10);
INSERT INTO Deck_Cards VALUES (12,'D.Q', 10, 10);
INSERT INTO Deck_Cards VALUES (13,'D.K', 10, 10);

INSERT INTO Deck_Cards VALUES (14,'H.A', 1, 11);
INSERT INTO Deck_Cards VALUES (15,'H.2', 2, 2);
INSERT INTO Deck_Cards VALUES (16,'H.3', 3, 3);
INSERT INTO Deck_Cards VALUES (17,'H.4', 4, 4);
INSERT INTO Deck_Cards VALUES (18,'H.5', 5, 5);
INSERT INTO Deck_Cards VALUES (19,'H.6', 6, 6);
INSERT INTO Deck_Cards VALUES (20,'H.7', 7, 7);
INSERT INTO Deck_Cards VALUES (21,'H.8', 8, 8);
INSERT INTO Deck_Cards VALUES (22,'H.9', 9, 9);
INSERT INTO Deck_Cards VALUES (23,'H.10', 10, 10);
INSERT INTO Deck_Cards VALUES (24,'H.J', 10, 10);
INSERT INTO Deck_Cards VALUES (25,'H.Q', 10, 10);
INSERT INTO Deck_Cards VALUES (26,'H.K', 10, 10);

INSERT INTO Deck_Cards VALUES (27,'C.A', 1, 11);
INSERT INTO Deck_Cards VALUES (28,'C.2', 2, 2);
INSERT INTO Deck_Cards VALUES (29,'C.3', 3, 3);
INSERT INTO Deck_Cards VALUES (30,'C.4', 4, 4);
INSERT INTO Deck_Cards VALUES (31,'C.5', 5, 5);
INSERT INTO Deck_Cards VALUES (32,'C.6', 6, 6);
INSERT INTO Deck_Cards VALUES (33,'C.7', 7, 7);
INSERT INTO Deck_Cards VALUES (34,'C.8', 8, 8);
INSERT INTO Deck_Cards VALUES (35,'C.9', 9, 9);
INSERT INTO Deck_Cards VALUES (36,'C.10', 10, 10);
INSERT INTO Deck_Cards VALUES (37,'C.J', 10, 10);
INSERT INTO Deck_Cards VALUES (38,'C.Q', 10, 10);
INSERT INTO Deck_Cards VALUES (39,'C.K', 10, 10);

INSERT INTO Deck_Cards VALUES (40,'S.A', 1, 11);
INSERT INTO Deck_Cards VALUES (41,'S.2', 2, 2);
INSERT INTO Deck_Cards VALUES (42,'S.3', 3, 3);
INSERT INTO Deck_Cards VALUES (43,'S.4', 4, 4);
INSERT INTO Deck_Cards VALUES (44,'S.5', 5, 5);
INSERT INTO Deck_Cards VALUES (45,'S.6', 6, 6);
INSERT INTO Deck_Cards VALUES (46,'S.7', 7, 7);
INSERT INTO Deck_Cards VALUES (47,'S.8', 8, 8);
INSERT INTO Deck_Cards VALUES (48,'S.9', 9, 9);
INSERT INTO Deck_Cards VALUES (49,'S.10', 10, 10);
INSERT INTO Deck_Cards VALUES (50,'S.J', 10, 10);
INSERT INTO Deck_Cards VALUES (51,'S.Q', 10, 10);
INSERT INTO Deck_Cards VALUES (52,'S.K', 10, 10);

  






--Display Current Game Statistics
CREATE OR REPLACE PROCEDURE display_CurentGame_Stats
 (p_game_id IN game_statistics.g_id%TYPE) 
IS
  v_game_info game_statistics%ROWTYPE;
  ex_invalid_player_c_info exception;
BEGIN
   SELECT * FROM game_info WHERE game_id = p_game_id;
   DBMS_OUTPUT.PUT_LINE ('Game ID -  ' || v_game_info.g_id);
   DBMS_OUTPUT.PUT_LINE ('Winner - ' || v_game_info.winner);
   DBMS_OUTPUT.PUT_LINE ('Losers -  ' || v_game_info.loser);
EXCEPTION
   WHEN NO_DATA_FOUND THEN 
   DBMS_OUTPUT.PUT_LINE ('Game not found!');
END display_CurentGame_Stats;

----------game_start------------
CREATE OR REPLACE PROCEDURE get_game_h_info
 (p_game_id  IN game_info.g_id%TYPE,
  p_date IN game_info.g_date%TYPE,
  p_player IN game_info.g_player%TYPE
  ) 
IS
	r_game_record game_info%ROWTYPE;
	ex_invalid_player_c_info exception;
BEGIN
	IF (p_game_id.length = 0 OR p_date.length = 0 OR p_player.length = 0) THEN
	SELECT * INTO r_game_record from game_info WHERE g_id = p_game_id or g_date = p_date or g_player = p_player;
	ELSE 
	SELECT * INTO r_game_record from game_info WHERE g_player = p_player AND g_date = p_date AND g_id = p_game_id;
	END IF;
EXCEPTION
   WHEN NO_DATA_FOUND THEN 
   DBMS_OUTPUT.PUT_LINE ('The User does not exist!');
END get_game_h_info;

CREATE OR REPLACE PROCEDURE abort_game ( game_id IN game_info.g_id%TYPE, player_name IN game_info.g_player%TYPE)
IS
BEGIN
	UPDATE game_info SET resume = 'F' WHERE g_id = game_info AND g_player = player_name;
END abort_game;


CREATE OR REPLACE PROCEDURE purge_game ( game_date IN game_info.g_date%TYPE)
IS
BEGIN
	DELETE FROM game_info WHERE g_date = game_date;
END abort_game;


CREATE OR REPLACE PROCEDURE record_cards (game_id IN game_info.game_id%TYPE, player_id IN user_info.account_name%TYPE, card_id IN Deck_Cards.card_id%TYPE,i)
IS
BEGIN
	
 INSERT INTO game_players_cards VALUES (game_id, player_id,card_id);
END record_cards;


CREATE OR REPLACE PROCEDURE resume_game (game_id IN game_info.game_id%TYPE, player_id IN OUT user_info.account_name%TYPE, card_id IN OUT Deck_Cards.card_id%TYPE )
IS
	excep_no_game_found EXCEPTION;
	rec_game_his game_info%ROWTYPE;
	rec_game_play_his game_info%ROWTYPE;
	v_count INTEGER;
BEGIN
	SELECT * INTO rec_game_his FROM game_info WHERE g_id = game_id AND resume = 'T';
	WHEN NO_DATA_FOUND RAISE(excep_no_game_found);
	SELECT count(*) into v_count from Deck_Cards;
	FOR i in 1..v_count LOOP
	  COLL(i) := SELECT g_id  FROM game_players_cards where g_id =  game_id AND game_ORDER = i;
	  COLL(i) := SELECT  player_name  FROM game_players_cards where g_id =  game_id AND game_ORDER = i;
	  COLL(i) :=  SELECT card_id  FROM game_players_cards where g_id =  game_id AND game_ORDER = i;
	END LOOP;
	EXCEPTION
	WHEN excep_no_game_found THEN
		DBMS_OUTPUT.PUT_LINE('Game does not exist or has ended');
END resume_game;


CREATE OR REPLACE PROCEDURE display_game_score (player_id IN OUT user_info.account_name%TYPE, card_id IN OUT Deck_Cards.card_id%TYPE )
IS
	excep_no_game_found EXCEPTION;
	rec_game_his game_info%ROWTYPE;
	rec_game_play_his game_info%ROWTYPE;
	v_count INTEGER;
BEGIN
	SELECT * INTO rec_game_his FROM game_info WHERE g_id = game_id AND resume = 'T';
	WHEN NO_DATA_FOUND RAISE(excep_no_game_found);
	SELECT count(*) into v_count from Deck_Cards;
	FOR i in 1..v_count LOOP
	  COLL(i) := SELECT g_id  FROM game_players_cards where g_id =  game_id AND game_ORDER = i;
	  COLL(i) := SELECT  player_name  FROM game_players_cards where g_id =  game_id AND game_ORDER = i;
	  COLL(i) :=  SELECT card_id  FROM game_players_cards where g_id =  game_id AND game_ORDER = i;
	END LOOP;
	EXCEPTION
	WHEN excep_no_game_found THEN
		DBMS_OUTPUT.PUT_LINE('Game does not exist or has ended');
END resume_cards;


CREATE OR REPLACE PACKAGE deck_package IS 
 
  --shuffle deck header--
  PROCEDURE shuffle_deck;
  
  --get card value header--
  FUNCTION get_card_value;
  
END deck_package;

CREATE OR REPLACE PACKAGE BODY deck_package IS
	
  --shuffle deck body--
  PROCEDURE shuffle_deck    
	IS
	  v_card_rec Deck_Cards%ROWTYPE;
	  v_count INTEGER;
	BEGIN
	   DELETE FROM ShuffledDeck; 
	   select * into v_card_rec from Deck_Cards ORDER BY dbms_random.value;
	SELECT count(*) into v_count from Deck_Cards;
	   FOR i in 1.. v_count LOOP
		INSERT INTO ShuffledDeck VALUES (shuffle_sequence.nextval,v_card_rec.card_name);
	   END LOOP;		   
  END shuffle_deck;
  
  --get card value body--
  FUNCTION get_card_value
	  ( face_value IN VARCHAR		
		  hand_value IN NUMBER )	
	  RETURN number 			
	  IS
	
  DECLARE
	  value NUMBER;				
	
  BEGIN
      if face_value in ('C.A' ,'D.A','H.A','S.A')   
	        IF (hand_value < 11) THEN
		        SELECT card_max_val INTO value FROM Deck_Cards WHERE card_name = face_value;
		  	ELSE	
			    SELECT card_min_val INTO value FROM Deck_Cards WHERE card_name = face_value;
  			END IF;
	  ELSE 
		    SELECT card_min_val INTO value FROM Deck_Cards WHERE card_name = face_value;
	  END IF;
	  RETURN value;
	
  EXCEPTION
  
	  WHEN OTHERS THEN
		  DBMS_OUTPUT.PUT_LINE(TO_CHAR(SQLCODE)||
	  		": ERROR IN FUNCTION get_card_value - " || SQLERRM);
END;
  
END deck_package;



CREATE OR REPLACE PACKAGE game_initial IS 

  --Game Initialization Header--
  PROCEDURE  game_inital
 (p_player_num  IN OUT INTEGER DEFAULT 1,
  p_hint  IN BOOLEAN DEFAULT TRUE);
  
  --check player info header--
  FUNCTION check_player_info;
  
  --check user info header--
  FUNCTION check_user_info;

    --create user header--
	PROCEDURE create_user_info
		 (p_account_name  IN OUT user_info.account_name%TYPE,
		  p_email IN OUT user_info.email%TYPE,
		  p_password IN OUT user_info.password%TYPE,
		  p_f_name IN OUT user_info.f_name%TYPE,
		  p_l_name IN OUT user_info.l_name%TYPE) ;
		  
	--reader user header--
	PROCEDURE read_user_info
		 (p_account_name  IN user_info.account_name%TYPE);	
		 
    --update user header--
	PROCEDURE update_user_info
		 (p_account_name  IN OUT user_info.account_name%TYPE,
		  p_email IN OUT user_info.email%TYPE,
		  p_f_name IN OUT user_info.f_name%TYPE,
		  p_l_name IN OUT user_info.l_name%TYPE);
		
	--change password header--	
	PROCEDURE change_user_pwd
		 (p_account_name  IN OUT user_info.account_name%TYPE,
		  p_password IN OUT user_info.password%TYPE);

	--delete user header--	  
	PROCEDURE delete_user_info
		 (p_account_name  IN user_info.account_name%TYPE);
	 
END game_initial;

CREATE OR REPLACE PACKAGE BODY game_initial IS
	--Game Initialization Body--
	CREATE OR REPLACE PROCEDURE  game_inital
	 (p_player_num  IN OUT INTEGER DEFAULT 1,
	  p_hint  IN BOOLEAN DEFAULT TRUE)
	IS
	  s_dept_id f_emps.department_id%TYPE;
	  v_player game_info.g_player%TYPE;
	  v_game_id game_info.game_id%TYPE;
	  ex_invalid_player_num exception;
	BEGIN
	   IF (p_player_num > 3) THEN
		 RAISE ex_invalid_player_num;
	   IF (p_hint = TRUE) THEN 
		 DBMS_OUTPUT.PUT_LINE ('Number of Players - ' || p_player_num);
		 
		 v_game_id = game_sequence.NEXTVAL;
		FOR i in 1...p_player_num LOOP	
		  check_player_info(&player_name,&password);
		  v_player1 := player_name;	
		  INSERT INTO game_info
			(game_id, g_date,g_player, resume)
			VALUES
			(v_game_id, TO_DATE(SYSDATE,'DD-MON-YYYY'),v_player ,'T');	
		 END LOOP;
		 
	EXCEPTION
	   WHEN ex_invalid_player_num THEN 
	   DBMS_OUTPUT.PUT_LINE ('Number of Players can not be more than 3!');
	END game_inital;
  
    --check player info body--
	CREATE OR REPLACE FUNCTION check_player_info(f_player_name IN user_info.account_name%TYPE, f_password IN user_info.password%TYPE)
	RETURN BOOLEAN 
	IS
	v_username user_info.account_name%TYPE;
	v_password user_info.password%TYPE;
	BEGIN
	--check if player exists
		IF(check_user_info(player_name) = TRUE)THEN
		--if player exists, then check the supplied username and password
			SELECT account_name , password into v_username, v_password FROM user_info WHERE account_name = f_player_name;
			--if row exists
			IF (f_player_name = v_username AND f_password = v_password) THEN 
				DBMS_OUTPUT.PUT_LINE('You have been logged in.');
				return TRUE;
				END IF;
		ELSE 
		DBMS_OUTPUT.PUT_LINE('Player not found. Please create account.');
		EXECUTE create_user_info(&p_account_name, &p_email, &p_password, &p_f_name, &p_l_name);
		END IF;
		EXCEPTION
		WHEN NO_DATA_FOUND THEN
		DBMS_OUTPUT.PUT_LINE('Wrong username or password.');
	END	check_player_info;  
	
  
	--check user info body--
	CREATE OR REPLACE FUNCTION check_user_info
	 (p_account_name  IN OUT user_info.account_name%TYPE) 
	 RETURN BOOLEAN 
	IS
	BEGIN
	   SELECT account_name FROM user_info WHERE account_name = p_account_name;
	   DBMS_OUTPUT.PUT_LINE ('The User ' || account_name || ' exist!');
	   return TRUE;
	EXCEPTION
	   WHEN NO_DATA_FOUND THEN 
	   DBMS_OUTPUT.PUT_LINE ('The User does not exist!');
	END check_user_info;  
	
	
	--Create User body--
	CREATE OR REPLACE PROCEDURE create_user_info
	 (p_account_name  IN OUT user_info.account_name%TYPE,
	  p_email IN OUT user_info.email%TYPE,
	  p_password IN OUT user_info.password%TYPE,
	  p_f_name IN OUT user_info.f_name%TYPE,
	  p_l_name IN OUT user_info.l_name%TYPE) 
	IS
	  ex_invalid_player_c_info exception;
	BEGIN
	   IF p_account_name.LENGTH == 0 or p_email.LENGTH == 0 or p_password.LENGTH == 0 or p_f_name.LENGTH == 0 or p_l_name.LENGTH == 0 THEN 
		 RAISE ex_invalid_player_c_info;
	   ELSE   
		 INSERT INTO user_info VALUES(p_account_name,p_email,p_password,p_f_name,p_l_name);
		 DBMS_OUTPUT.PUT_LINE ('The username ' || p_account_name || 'created successed!');
	   END IF;
	EXCEPTION
	   WHEN ex_invalid_player_c_info THEN 
	   DBMS_OUTPUT.PUT_LINE ('All of user infomation are required,please enter all of them!');
	END create_user_info;

	--Read User body--
	CREATE OR REPLACE PROCEDURE read_user_info
	 (p_account_name  IN user_info.account_name%TYPE) 
	IS
	  v_info user_info%ROWTYPE;
	BEGIN
	   SELECT * into v_info FROM user_info WHERE account_name = p_account_name;
	   DBMS_OUTPUT.PUT_LINE ('User Unique name -  ' || v_info.p_account);
	   DBMS_OUTPUT.PUT_LINE ('Email - ' || v_info.p_email);
	   DBMS_OUTPUT.PUT_LINE ('Password - ' || v_info.p_password);
	   DBMS_OUTPUT.PUT_LINE ('First Name ' || v_info.p_f_name);
	   DBMS_OUTPUT.PUT_LINE ('Last Name ' || v_info.p_l_name);
	EXCEPTION
	   WHEN NO_DATA_FOUND THEN 
	   DBMS_OUTPUT.PUT_LINE ('The User does not exist!');
	END read_user_info;

    --update User body--
	CREATE OR REPLACE PROCEDURE update_user_info
	 (p_account_name  IN OUT user_info.account_name%TYPE,
	  p_email IN OUT user_info.email%TYPE,
	  p_f_name IN OUT user_info.f_name%TYPE,
	  p_l_name IN OUT user_info.l_name%TYPE) 
	IS
	  ex_invalid_player_c_info exception;
	BEGIN
	   IF p_account_name.LENGTH == 0 or p_email.LENGTH == 0 or p_f_name.LENGTH == 0 or p_l_name.LENGTH == 0 THEN 
		 RAISE ex_invalid_player_c_info;
	   ELSE   
		 UPDATE user_info SET email = p_email ,f_name = p_f_name,l_name = p_l_name WHERE account_name = p_account_name;
	   END IF;
	EXCEPTION
	   WHEN ex_invalid_player_c_info THEN 
	   DBMS_OUTPUT.PUT_LINE ('All of user infomation are required,please enter all of them!');
	END update_user_info;

	--Change Password body--
	CREATE OR REPLACE PROCEDURE change_user_pwd
	 (p_account_name  IN OUT user_info.account_name%TYPE,
	  p_password IN OUT user_info.password%TYPE) 
	IS
	  ex_invalid_player_c_info exception;
	BEGIN
	   IF  p_account_name.LENGTH == 0 or p_password.LENGTH == 0 THEN 
		 RAISE ex_invalid_player_c_info;
	   ELSE   
		 UPDATE user_info SET password = p_password WHERE account_name = p_account_name;
	   END IF;
	EXCEPTION
	   WHEN ex_invalid_player_c_info THEN 
	   DBMS_OUTPUT.PUT_LINE ('All of user infomation are required,please enter all of them!');
	END change_user_pwd;

    --delete user body--
	CREATE OR REPLACE PROCEDURE delete_user_info
	 (p_account_name  IN user_info.account_name%TYPE) 
	IS
	  ex_invalid_player_c_info exception;
	BEGIN
	   DELETE FROM user_info WHERE account_name = p_account_name;
	EXCEPTION
	   WHEN NO_DATA_FOUND THEN 
	   DBMS_OUTPUT.PUT_LINE ('The User does not exist!');
	END delete_user_info;
	
END game_initial;


------------main----------
DECLARE
  v_m_menu_num INTEGER;
  v_u_menu_num INTEGER;
BEGIN
   DBMS_OUTPUT.PUT_LINE('Welcome to the BlackJack !!! -- JIAJUN XUE <nicoxue0324@gmail.com>');
   DBMS_OUTPUT.PUT_LINE('Game Initialize...');
   game_initial.game_inital(2,TRUE);
   DBMS_OUTPUT.PUT_LINE('------List Of The Main Menu-------');
   DBMS_OUTPUT.PUT_LINE('1.  Go To Play Game');
   DBMS_OUTPUT.PUT_LINE('2.  User Managements');   
   DBMS_OUTPUT.PUT_LINE('3.  Exit Game');
   DBMS_OUTPUT.PUT_LINE('Please enter the number: ',&v_m_menu_num);
   CASE v_m_menu_num
     WHEN 1 THEN 
	   deck_package.shuffle_deck;
	 WHEN 2 THEN
	   DBMS_OUTPUT.PUT_LINE('------List Of The User Menu-------');
	   DBMS_OUTPUT.PUT_LINE('1.  Create New User');
	   DBMS_OUTPUT.PUT_LINE('2.  Read User Info');   
	   DBMS_OUTPUT.PUT_LINE('3.  Update User Info');
	   DBMS_OUTPUT.PUT_LINE('4.  Change User Password');
	   DBMS_OUTPUT.PUT_LINE('5.  Delete User Info');
	   DBMS_OUTPUT.PUT_LINE('Please enter the number: ',&v_u_menu_num);  
       CASE v_u_menu_num
          WHEN 	   
	 WHEN 3 THEN
	 ELSE  DBMS_OUTPUT.PUT_LINE('Invalid Number')
   END
   
END;
