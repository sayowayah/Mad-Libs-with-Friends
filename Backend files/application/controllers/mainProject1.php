<?php	 	 

// TODO should this really be separated from the model?  It seems like a lot of duplication
class Main extends CI_Controller {
    public function __construct() {
        parent::__construct();
        $this->load->model('Xfit');
    }
    
    public function getSources() {
        $sources = $this->Xfit->getSourcesDB();
        echo json_encode($sources);
    }
    
    public function getGyms() {
        $data = $this->Xfit->getGymsDB();
        echo json_encode($data);        
    }

    public function getExCategories() {
        $data = $this->Xfit->getExCategoriesDB();
        echo json_encode($data);        
    }
    
    public function getExs() {
        $data = $this->Xfit->getExsDB();
        echo json_encode($data);        
    }    

    public function getExByCategory() {
        $categoryId = $this->input->post('categoryId');
        $data = $this->Xfit->getExByCategoryDB($categoryId);
        echo json_encode($data);    
    }
    
    public function getExsForWod() {
        $wodId = $this->input->post('wodId');
        $data = $this->Xfit->getExsByWodDB($wodId);
        echo json_encode($data);    
    }

    // same as getExsForWod but for user wod    
    public function getExsforUserWod() {
        $userWodId = $this->input->post('userWodId');
        $data = $this->Xfit->getExsforUserWodDB($userWodId);
        echo json_encode($data);    
    }    

    public function getWodById() {
        $wodId = $this->input->post('wodId');
        // get wod data
        $data = $this->Xfit->getWodByIdDB($wodId);
        
        // get the exercise data
        $exercises = $this->Xfit->getExsforWodDB($wodId);
        
        //merge
        $data[0] -> exercises = $exercises;
        
        echo json_encode($data);    
    }  
    
    // same as getWodById but for a user wod
    public function getUserWodById() {
        $userWodId = $this->input->post('userWodId');
        // get wod data
        $data = $this->Xfit->getUserWodByIdDB($userWodId);
        
        // get the exercise data
        $exercises = $this->Xfit->getExsforUserWodDB($userWodId);
        
        //merge
        $data[0] -> exercises = $exercises;
        
        echo json_encode($data);    
    } 
    
    
    // gets all the wods a user has scheduled or completed
    public function getScheduledWods() {
        $userId = $this->input->post('userId');
        
        // get wod data
        $wods = $this->Xfit->getScheduledWodsDB($userId);
        
        // // loop through each wod and add the exercise data
        // for ($i=0; i<count($wods); $i++) {
        // //foreach ($wods as $wod) {
            // // get the exercise data
            // $exercises = $this->Xfit->getExsforUserWodDB($wod -> $id);
//             
            // //merge
            // $wod -> exercises = $exercises;
        // }
        
        // loop through each wod and add the exercise data
        for ($i=0; $i<count($wods); $i++) {
            
            // get the exercise data
            $exercises = $this->Xfit->getExsforUserWodDB($wods[$i] -> wodId);
            
            //merge
            $wods[$i] -> exercises = $exercises;
        }        
               
        echo json_encode($wods);    
    }           
    
    public function recordWod() {
        $userId = $this->input->post('userId');
        $data = $this->Xfit->recordWodDB($userId);
        echo json_encode($data);               
    }
    

    // returns a 1 if the email is available, otherwise returns 0
    public function checkEmailAvailability() {
        $email = $this->input->post('email');
        $data = $this->Xfit->checkEmailAvailabilityDB($email);
        echo json_encode($data);               
    }

    public function userRegister() {
        $email = $this->input->post('email');
        $password = $this->input->post('password');
        $nameFirst = $this->input->post('nameFirst');
        $nameLast = $this->input->post('nameLast');
        //$height = $this->input->post('height');
        //$weight = $this->input->post('weight');
        //$dob = $this->input->post('dob');
        //$freeText = $this->input->post('freeText');
        
        // TODO try catch here to return 1 or 0?    
        
        // taking out height/weight etc for the time being
        //$data = $this->Xfit->userRegisterDB($email, $password, $nameFirst, $nameLast, $height, $weight, $dob, $freeText);
        $data = $this->Xfit->userRegisterDB($email, $password, $nameFirst, $nameLast);
        
        echo json_encode($data);               
    }  
    
    public function userLogin() {
        $email = $this->input->post('email');
        $password = $this->input->post('password');        
          
        $data = $this->Xfit->userLoginDB($email, $password);
        echo json_encode($data);               
    }
    
    public function userLogout() {
        $email = $this->input->post('email');  
        $data = $this->Xfit->userLogoutDB($email);
        echo json_encode($data);               
    }               
    
    
    public function getWodsBySource() {
        $sourceId = $this->input->post('sourceId');  
        $data = $this->Xfit->getWodsBySourceDB($sourceId);
        echo json_encode($data);    
    }                      
        
        
    public function scheduleWod() {
        $wodId = $this->input->post('wodId');
        $userId = $this->input->post('userId');
        $dateScheduled = $this->input->post('dateScheduled');
        
        $data = $this->Xfit->scheduleWodDB($userId, $wodId, $dateScheduled);
        echo json_encode($data);        
    }


    // TODO should make more use of index, instead of always relying on main 
    public function index() {
        /*/$output = $this->Courses->FetchByKeyword(802);
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
        exit;*/
    }
}
?>
