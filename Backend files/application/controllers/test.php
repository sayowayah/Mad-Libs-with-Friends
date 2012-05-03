<?php	 	 

class Test extends CI_Controller {
    public function __construct() {
        parent::__construct();
        $this->load->model('Courses');
    }
    
    public function course($id) {
        $output = $this->Courses->FetchClass($id);
        var_dump($output);
    }
    
    public function search($departments, $terms) {
        $departments = array('CHEM');
        $faculty = array('F5f54e8708840989bc525ae860c6bd6a8');
        $terms = array();
        $days = array();
        $start_times = array();
        $end_times = array();
        $credits = array();
        $gened = NULL; 
        $output = $this->Courses->FetchClassList($departments, $faculty, $terms, $days, $start_times, $end_times, $credits, $gened);
    
    }
    
    public function index() {
        //$output = $this->Courses->FetchByKeyword(802);
        //$output = $this->Courses->FetchByCategory('Faculty');
        //$output = $this->Courses->FetchByCategory('Departments');
        //$output = $this->Courses->FetchGenEd();
        $param = array('dpt' => "COMPSCI", 'fac' => "F98d2c536d93571eff451df8bd44823d8", 'term' => 1, 'gened' => 2);
        //$output = $this->Courses->testing2($array);
    	$output = $this->Courses->FetchClassExclFaculty(1106);
        //$output = $this->Courses->FetchClassListNew($param);
        //$output = $this->Courses->testing3(6125,NULL);
		//$output = $this->Courses->FetchFacultyID("Smith");
		//$output = $this->Courses->FetchDepartmentsList();

		 // create course sessions array, pass to view
        /*$startTimes = explode(",", $courseData[0]->Start);
        $endTimes = explode(",", $courseData[0]->End);
        $buildings = explode(",", $courseData[0]->Building);
        $terms = explode(",", $courseData[0]->Term);
        $days = explode(",", $courseData[0]->Day);
        $rooms = explode(",", $courseData[0]->Room);
        */
        //$output = $startTimes;
        // create an empty array to store the course sessions (i.e. time, day, building...)
        //$sessions = array();
        
        // get the number of sessions based on available start times (so you can iterate through them)
        //$numberOfSessions = count($startTimes);
        
        // assemble faculty array, pass to view
        //for ($i=0; $i<$numberOfSessions; $i++)
        //{
         //   $sessions[$i] = $startTimes[$i] . ' - ' . $endTimes[$i] . ' - ' . $buildings[$i] . ' - ' . $terms[$i] . ' - ' . $days[$i] . ' - ' . $rooms[$i];
        //}


        var_dump($output);
        exit;
    }
}
?>
