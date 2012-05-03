<?php

class Friendlibs extends CI_Model {

	// list of available stories
	public function getStoryTemplatesDB() {
		try {
			//SELECT * from Templates
			$query = $this -> db -> get('Templates');
			return $query -> result();
			
		} catch (Exception $e) {
			return 0;
		}
	}

	// list of available stories
	public function getStoriesOutstandingDB($userId) {
		try {	
			$this -> db -> select();
			$this -> db -> from('UserStories');
			$this -> db -> where('UserStories.User_ID1', $userId);
			$this -> db -> where('UserStories.User_ID1_Status', false);
	
			// add template name
			$this -> db -> join('Templates', 'Templates.ID = UserStories.Template_ID');
	
			return $this -> db -> get() -> result();
		
		} catch (Exception $e) {
			return 0;
		}		
	}

	// returns the blank words a user needs to enter to begin or complete a story
	public function getBlanksForStoryDB($userId, $storyId) {
		try {
			// select the story in question
			$this -> db -> select();
			$this -> db -> from('UserStories');
			$this -> db -> where('UserStories.ID', $storyId);
			$story = $this -> db -> get() -> result();
	
			// get the blanks
			$this -> db -> select();
			$this -> db -> from('TemplateBlanks');
			$this -> db -> where('TemplateBlanks.Template_ID', $story[0] -> Template_ID);
			$wordBlanks = $this -> db -> get() -> result();
	
			// get the number of blanks
			$wordBlankCount = count($wordBlanks);
	
			// calcluate the number of words each user needs to input
			$wordBlankCountA = $wordBlankCount / 2;
			$wordBlankCountB = $wordBlankCount - $wordBlankCountA;
	
			if ($story[0] -> User_ID1 == $userId) {
				// get the first half
				return array_slice($wordBlanks, 0, $wordBlankCountA);
			} else {
				// get the second half
				return array_slice($wordBlanks, $wordBlankCountA);
			}
		} catch (Exception $e) {
			return 0;
		}
	}

	public function createNewStoryDB($templateId, $userId1, $userId2) {
		try {
			// insert new reccord
			$data = array(
				'Template_ID' => $templateId, 
				'User_ID1' => $userId1, 
				'User_ID2' => $userId2, 
				'User_ID1_Status' => false, 
				'User_ID2_Status' => false
			);
	
			$this -> db -> insert('UserStories', $data);
	
			// return resulting storyId
			return $this -> db -> insert_id();
			
		} catch (Exception $e) {
			return 0;
		}
	}

	public function submitStoryDB($userId, $storyId, $words) {
		try {
			// parse words array
			$words = json_decode($words);

			// insert each word into the user words table
			foreach ($words as $word) {

				// create an array with the data to be inserted
				$data = array(
					'User_ID' => $userId, 
					'Story_ID' => $storyId, 
					'Word_ID' => $word -> wordId, 
					'Word' => $word -> word
				);

				$this -> db -> insert('UserWords', $data);
			}

			// set status to completed

			// get user 1 id to see if it matches to current user
			$this -> db -> select('User_ID1');
			$this -> db -> from('UserStories');
			$this -> db -> where('UserStories.ID', $storyId);
			$result = $this -> db -> get() -> result();
			$userId1 = $result[0] -> User_ID1;

			if ($userId1 == $userId) {
				// update status for userId1
				$data = array('User_ID1_Status' => true);
				$this -> db -> update('UserStories', $data);
			} else {
				// update status for userId2
				$data = array('User_ID2_Status' => true);
				$this -> db -> update('UserStories', $data);
			}
			return 1;
			
		} catch (Exception $e) {
			return 0;
		}
	}

	// get a list of completed stories initiated by that user
	public function getCompletedStoriesDB($userId) {
		try {
			//array of stories
			//storyId, storyName, partnerId, partnerName
			$this -> db -> select();
			$this -> db -> from('UserStories');
			$this -> db -> where('UserStories.User_ID1', $userId);
			$this -> db -> where('UserStories.User_ID1_Status', true);
			$this -> db -> where('UserStories.User_ID2_Status', true);
	
			return $this -> db -> get() -> result();
			
		} catch (Exception $e) {
			return 0;
		}
	}

	// fully assembled story
	public function getCompletedStoryDB($storyId) {
		try {
			// get the template ID for this story
			$this -> db -> select('Template_ID');
			$this -> db -> from('UserStories');
			$result = $this -> db -> get() -> result();
			$templateId = $result[0] -> Template_ID;
	
			// get the base story text
			$this -> db -> select('StoryText');
			$this -> db -> from('Templates');
			$this -> db -> where('Templates.ID', $templateId);
			$result = $this -> db -> get() -> result();
			$story = $result[0] -> StoryText;
	
			// get the template blanks
			$this -> db -> select();
			$this -> db -> from('TemplateBlanks');
			$this -> db -> where('TemplateBlanks.Template_ID', $templateId);
			$result = $this -> db -> get() -> result();
			$blanks = $result;
	
			// iterate through template words
			foreach ($blanks as $blank) {
				$wordId = $blank -> Word_ID;
	
				// get the user entered word for this blank
				$this -> db -> select('Word');
				$this -> db -> from('UserWords');
				$this -> db -> where('Word_ID', $wordId);
				$result = $this -> db -> get() -> result();
	
				if (count($result) > 0) {
					// insert the word into this story
					$userWord = $result[0] -> Word;
					$story = preg_replace('[_]', $userWord, $story, 1);
				}
			}
			
			return $story;
			
		} catch (Exception $e) {
			return 0;
		}			
	}

	public function getTemplateBlanksDB($templateId) {
		try {
			$this -> db -> select();
			$this -> db -> from('TemplateBlanks');
			$this -> db -> where('Template_ID', $templateId);
			return $this -> db -> get() -> result();

		} catch (Exception $e) {
			return 0;
		}			
	}

}
?>
