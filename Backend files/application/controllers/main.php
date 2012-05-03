<?php

class Main extends CI_Controller {
	public function __construct() {
		parent::__construct();
		$this -> load -> model('Friendlibs');
	}

	public function getStoryTemplates() {
		$templates = $this -> Friendlibs -> getStoryTemplatesDB();
		echo json_encode($templates);
	}

	public function getStoriesOutstanding() {
		$userId = $this -> input -> post('userId');
		$stories = $this -> Friendlibs -> getStoriesOutstandingDB($userId);
		echo json_encode($stories);
	}

	public function getBlanksForStory() {
		$userId = $this -> input -> post('userId');
		$storyId = $this -> input -> post('storyId');
		$blanks = $this -> Friendlibs -> getBlanksForStoryDB($userId, $storyId);
		echo json_encode($blanks);
	}
	
	public function createNewStory() {
		$templateId = $this -> input -> post('templateId');
		$userId1 = $this -> input -> post('userId1');
		$userId2 = $this -> input -> post('userId2');
		$result = $this -> Friendlibs -> createNewStoryDB($templateId, $userId1, $userId2);
		echo json_encode($result);
	}	

	public function submitStory() {
		$userId = $this -> input -> post('userId');
		$storyId = $this -> input -> post('storyId');
		$words = $this -> input -> post('words');
		$result = $this -> Friendlibs -> submitStoryDB($userId, $storyId, $words);
		echo json_encode($result);
	}

	public function getCompletedStories() {
		$userId = $this -> input -> post('userId');
		$stories = $this -> Friendlibs -> getCompletedStoriesDB($userId);
		echo json_encode($stories);
	}

	public function getCompletedStory() {
		$storyId = $this -> input -> post('storyId');
		$story = $this -> Friendlibs -> getCompletedStoryDB($storyId);
		echo json_encode($story);
	}

	public function getTemplateBlanks() {
		$templateId = $this -> input -> post('templateId');
		//$templateId = 1;
		$blanks = $this -> Friendlibs -> getTemplateBlanksDB($templateId);
		echo json_encode($blanks);
	}

	/*****TESTS******/

	public function getStoryTemplatesTest() {
		$templates = $this -> Friendlibs -> getStoryTemplatesDB();
		echo json_encode($templates);
	}

	public function getStoriesOutstandingTest() {
		$userId = 1;
		$stories = $this -> Friendlibs -> getStoriesOutstandingDB($userId);
		echo json_encode($stories);
	}

	public function getBlanksForStoryTest() {
		$userId = 1;
		$storyId = 3;
		$blanks = $this -> Friendlibs -> getBlanksForStoryDB($userId, $storyId);
		echo json_encode($blanks);
	}
	
	public function createNewStoryTest() {
		$templateId = 1;
		$userId1 = 1;
		$userId2 = 2;
		$result = $this -> Friendlibs -> createNewStoryDB($templateId, $userId1, $userId2);
		echo json_encode($result);
	}
	
	public function submitStoryTest() {
        $word1 = array(
            'wordId' => 1,
            'word' => 'dms',
        );
		$words = array($word1);
		$words = json_encode($words);
		$userId = 1;
		$storyId = 7;
		$result = $this -> Friendlibs -> submitStoryDB($userId, $storyId, $words);
		echo json_encode($result);
	}

	public function getCompletedStoriesTest() {
		$userId = 1;
		$stories = $this -> Friendlibs -> getCompletedStoriesDB($userId);
		echo json_encode($stories);
	}

	public function getCompletedStoryTest() {
		$storyId = 6;
		$story = $this -> Friendlibs -> getCompletedStoryDB($storyId);
		echo json_encode($story);
	}

	public function getTemplateBlanksTest() {
		$templateId = 1;
		//$templateId = 1;
		$blanks = $this -> Friendlibs -> getTemplateBlanksDB($templateId);
		echo json_encode($blanks);
	}

	/**************/

	public function index() {
	}

}
?>
