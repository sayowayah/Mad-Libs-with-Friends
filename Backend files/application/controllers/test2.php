<?php	 	 

class Main extends CI_Controller {
    public function __construct() {
        parent::__construct();
        $this->load->model('Courses');
    }
    
    public function course($id) {
        //$output = $this->Courses->FetchClass($id);
        $courseData = $this->Courses->FetchClassExclFaculty($id);
        $courseFaculty = $this->Courses->FetchClassFaculty($id);
        
        // create course sessions array, pass to view
        $startTimes = explode(",", $courseData[0]->Start);
        $endTimes = explode(",", $courseData[0]->End);
        $buildings = explode(",", $courseData[0]->Building);
        $terms = explode(",", $courseData[0]->Term);
        $days = explode(",", $courseData[0]->Day);
        $rooms = explode(",", $courseData[0]->Room);
        
        // create an empty array to store the course sessions (i.e. time, day, building...)
        $sessions = array();
        
        // get the number of sessions based on available start times (so you can iterate through them)
        $numberOfSessions = count($startTimes);
        
        // assemble faculty array, pass to view
        for ($i=0; $i<$numberOfSessions; $i++)
        {
            // convert the term ID's into strings
            if ($terms[$i] == 1)
            {
                $termName = 'Fall';
            }
            if ($terms[$i] == 2)
            {
                $termName = 'Spring';
            }     

            // build up the concatenated string
            $sessions[$i] = $startTimes[$i] . ' to ' . $endTimes[$i] . ' - ' . $termName . ' - ' . $days[$i] . ' days - ' . $buildings[$i] . ' (room ' . $rooms[$i] . ')';
        }
        
        // do the same for faculty
        $firstNames = explode(",", $courseFaculty[0]->FirstName);
        $lastNames = explode(",", $courseFaculty[0]->LastName);
        
        $faculty = array();
        $numberOfFaculty = count($firstNames);
        
        // assemble faculty array, pass to view
        for ($i=0; $i<$numberOfFaculty; $i++)
        {
            $faculty[$i] = $lastNames[$i] . ', ' . $firstNames[$i];
        }        
        //var_dump($startTimes);
        
        // store a reccord of the class page visit in user's local storage
        
		$this->load->view('templates/header', array('output' => $output[0]->Course_Name));
		$this->load->view('course', array('course' => $courseData, 'faculty' => $faculty, 'courseId' => $id, 'sessions' => $sessions));
		$this->load->view('templates/footer');
        //var_dump($output);
    }
    
    public function savecourse($id) {
        session_start();
        
        // check if the course is already in the session variable (i.e. visited)
        // set the key value pair to 0 if it is not a saved course
        
        if (!isset($_SESSION['viewedCourses'][$id]))
        $_SESSION['viewedCourses'][$id] = 1;
        
        browse();
    }
	
    public function browse() {
    	//$output = $this->Courses->FetchByCategory('Departments');
		
		$this->load->vi+++ew('templates/header', array('output' => 'Browse By'));
		$this->load->view('browse');
//		$this->load->view('browse', array('output' => $output));
		$this->load->view('templates/footer');
    }
	
    public function search() {
        $dept = $this->Courses->FetchByCategory('Departments');
        $gened = $this->Courses->FetchByCategory('GenEd');
        $start_times = $this->Courses->FetchStartingTimes();
        $faculty = $this->Courses->FetchByCategory('Faculty');
        
		$this->load->view('templates/header', array('output' => 'Advanced Search'));
		$this->load->view('search', array('departments' => $dept, 'geneds' => $gened, 'start_times' => $start_times, 'faculty' => $faculty));
		$this->load->view('templates/footer');
    }
    
    public function keyword() {
        $keyword = $this->input->post('keyword');
        $output = $this->Courses->FetchByKeyword($keyword);
        
        $this->load->view('templates/header', array('output' => 'Course List'));
        $this->load->view('courselist', array('courseList' => $output, 'type' => 'fetch'));//
        $this->load->view('templates/footer');;
    }
    
	public function resultslist() {
		$gened = NULL;
		$dpt = NULL;
		$faculty = NULL;
		$term = NULL;		
	
		// if POST value is not default value ("standard"), then put value into variable
		if ($_POST['department'] !== "standard") {
			$dpt = $this->input->post('department');
		}
		if ($_POST['faculty'] !== "standard") {
			$faculty = $this->input->post('faculty');
		}
		$term = $this->input->post('term');
		$gened = $this->input->post('gened');

		$param = array(
			'dpt' => $dpt, 
			'gened' => $gened,
			'term' => $term,
			'fac' => $faculty);
		
		$courseList = $this->Courses->FetchClassListNew($param);
        $this->load->view('templates/header', array('output' => 'Course List'));
		$this->load->view('courselist', array('courseList' => $courseList, 'type' => 'fetch', 'log' => $dpt));
		$this->load->view('templates/footer');
	}


	 public function courselist($departments, $faculty) {
        $terms = array();
        $days = array();
        $start_times = array();
        $end_times = array();
        $credits = array();
        $gened = NULL; 
        $courseList = $this->Courses->FetchClassList(rawurldecode($departments), $faculty, $terms, $days, $start_times, $end_times, $credits, $gened);

        $this->load->view('templates/header', array('output' => 'Course List'));
		$this->load->view('courselist', array('courseList' => $courseList, 'type' => 'fetch'));
		$this->load->view('templates/footer');
		
        //var_dump($output);
        //exit;
    }

	 public function history() {		
        $this->load->view('templates/header', array('output' => 'Saved Courses'));
		$this->load->view('history', array('type' => 'history'));
		$this->load->view('templates/footer');
    }

    public function saved() {        
        $this->load->view('templates/header', array('output' => 'Saved Courses'));
        $this->load->view('saved', array('type' => 'saved'));
        $this->load->view('templates/footer');
    }     
    
     
    public function schedule() {
        $this->load->view('templates/header', array('output' => 'Your Schedule'));
        $this->load->view('schedule', array('type' => 'schedule'));
        $this->load->view('templates/footer');
    } 


	 public function browseby($parameter) {

        $gyms = $this->Courses->FetchByCategory($parameter);
        
        echo json_encode($gyms);
        //json with padding
        
        /*$this->load->view('templates/header', array('output' => 'Browse By '.$parameter));
		$this->load->view('categorylist', array('categoryList' => $categoryList, 'type' => $parameter));
		$this->load->view('templates/footer');*/
	 }

/*  
     public function gened() {
        $categoryList = $this->Courses->FetchGenEd();
        
        $this->load->view('templates/header', array('output' => 'Browse Gen. Ed. Requirements'));
        $this->load->view('categorylist', array('categoryList' => $categoryList, 'type' => 'GenEd'));
        $this->load->view('templates/footer');
        //var_dump($categoryList);
        //exit;    
     }
*/	
    // TODO should make more use of index, instead of always relying on main 
    public function index() {
        //$output = $this->Courses->FetchByKeyword(802);
        //$output = $this->Courses->FetchByCategory('Faculty');
        //$output = $this->Courses->FetchByCategory('Departments');
        //$output = $this->Courses->FetchGenEd();
        $departments = array();
        $faculty = array();
        $terms = array();
        $days = array();
        $start_times = array();
        $end_times = array();
        $credits = array();
        $gened = NULL; 
        $output = $this->Courses->FetchClassList($departments, $faculty, $terms, $days, $start_times, $end_times, $credits, $gened);
        var_dump($output);
        exit;
    }
}
?>
