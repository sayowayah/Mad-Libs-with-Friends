<?php	 	

class Courses extends CI_Model {
	public function FetchClass($id) {
		/**
		 * Takes a course number (int or string) as an input and returns an array of course objects. 
		 * Each faculty/time/location permutation is a separate object
		 *
		 * $id is the course catalogue number
		 */
		$this->db->select('Courses.ID, 
			Courses.Name AS Course_Name, 
			Departments.Name AS Department_Name, 
			Faculty.FirstName, 
			Faculty.LastName, 
			Credit_Codes.Type AS Course_Length, 
			Courses.GenEd, 
			TimeSlots_Courses.Term, 
			TimeSlots_Courses.Day, 
			Locations.Building, 
			Locations.Room, 
			TimeSlots_Courses.Start_time, 
			TimeSlots_Courses.End_time, 
			Courses.Description, 
			Courses.Type AS Course_Type, 
			Courses.Prereq, 
			Courses.Notes');
		$this->db->from('Courses');
		// join all the tables together
		$this->db->join('Faculty_Courses', 'Courses.ID = Faculty_Courses.Course_ID');
		$this->db->join('Faculty', 'Faculty.ID = Faculty_Courses.Faculty_ID');	
		// left join needed because not every course has a schedule yet
		$this->db->join('TimeSlots_Courses', 'TimeSlots_Courses.Courses_ID = Courses.ID', 'left'); 
		// left join needed because not every timeslot has a location yet	
		$this->db->join('TimeSlots_Locations', 'TimeSlots_Locations.TimeSlot_ID = TimeSlots_Courses.ID', 'left');
		// left join needed because not every timeslot has a location yet
		$this->db->join('Locations', 'Locations.ID = TimeSlots_Locations.Location_ID', 'left'); 
		$this->db->join('Departments', 'Departments.ID = Courses.Dept_ID');
		$this->db->join('Credit_Codes', 'Credit_Codes.Code = Courses.Credits');
		$this->db->where('Courses.ID', $id);

		return $this->db->get()->result();
	}
	
	public function FetchClassExclFaculty($id) {
		/**
		 * Takes a course number (int or string) as an input and a single object with 
		 * all times and locations in concatenated strings, but not including faculty 
		 * because faculty are not 1:1 correlated to time/location.
		 *
		 * $id is the course catalogue number
		 */
		$this->db->select('Courses.ID, 
			Courses.Name AS Course_Name, 
			Departments.Name AS Department_Name, 
			Credit_Codes.Type AS Course_Length, 
			Courses.GenEd, 
			GROUP_CONCAT(TimeSlots_Courses.Term) AS Term, 
			GROUP_CONCAT(TimeSlots_Courses.Day) AS Day, 
			GROUP_CONCAT(Locations.Building) AS Building, 
			GROUP_CONCAT(Locations.Room) AS Room, 
			GROUP_CONCAT(TimeSlots_Courses.Start_time) AS Start, 
			GROUP_CONCAT(TimeSlots_Courses.End_time) AS End, 
			Courses.Description, 
			Courses.Type AS Course_Type, 
			Courses.Prereq, 
			Courses.Notes');
		$this->db->from('Courses');
		// join all the tables together

		// left join needed because not every course has a schedule yet
		$this->db->join('TimeSlots_Courses', 'TimeSlots_Courses.Courses_ID = Courses.ID', 'left'); 
		// left join needed because not every timeslot has a location yet	
		$this->db->join('TimeSlots_Locations', 'TimeSlots_Locations.TimeSlot_ID = TimeSlots_Courses.ID', 'left');
		// left join needed because not every timeslot has a location yet
		$this->db->join('Locations', 'Locations.ID = TimeSlots_Locations.Location_ID', 'left');
		$this->db->join('Departments', 'Departments.ID = Courses.Dept_ID');
		$this->db->join('Credit_Codes', 'Credit_Codes.Code = Courses.Credits');
		$this->db->where('Courses.ID', $id);

		return $this->db->get()->result();
	}	
	
	public function FetchClassFaculty($id) {
		/**
		 * Takes a course number as an input and returns array of faculty objects.
		 *
		 * $id is the course catalogue number		 
		 */
		$this->db->select('Faculty.FirstName, Faculty.LastName');
		$this->db->from('Courses');
		// join tables
		$this->db->join('Faculty_Courses', 'Courses.ID = Faculty_Courses.Course_ID');
		$this->db->join('Faculty', 'Faculty.ID = Faculty_Courses.Faculty_ID');	
		$this->db->where('Courses.ID', $id);
		
		return $this->db->get()->result();
	}
		
	
	public function FetchByKeywordOld($keyword) {
		/**
		 * NOT USED. REPLACED BY FetchByKeyword
		 *
		 * Takes any string keyword or integer and returns list of matches from 
		 * Catalogue Number, Department Name, Course Name, and Faculty Name.
		 * 
		 */
		$this->db->select('Courses.ID, 
			Courses.Name AS Course_Name, 
			Departments.Name AS Department_Name, 
			Faculty.FirstName, 
			Faculty.LastName, 
			Credit_Codes.Type, 
			TimeSlots_Courses.Day, 
			TimeSlots_Courses.Start_time, 
			TimeSlots_Courses.End_time');
		$this->db->from('Courses');
		// join all the tables together
		$this->db->join('Faculty_Courses', 'Courses.ID = Faculty_Courses.Course_ID');
		$this->db->join('Faculty', 'Faculty.ID = Faculty_Courses.Faculty_ID');
		// left join needed because not every course has a schedule yet
		$this->db->join('TimeSlots_Courses', 'TimeSlots_Courses.Courses_ID = Courses.ID', 'left');
		$this->db->join('Departments', 'Departments.ID = Courses.Dept_ID');
		$this->db->join('Credit_Codes', 'Credit_Codes.Code = Courses.Credits');
		if (is_int($keyword)) {
			$this->db->where('Courses.ID', $keyword); //searches directly for cat_num if input is an integer
		}
		// if input is not an integer, search 5 fields
		else {
			$this->db->like('Courses.ID', $keyword); //allows for users that put quotes on their numbers
			$this->db->or_like('Departments.Name', $keyword);
			$this->db->or_like('Courses.Name', $keyword);
			$this->db->or_like('Faculty.FirstName', $keyword);
			$this->db->or_like('Faculty.LastName', $keyword);
		}
		return $this->db->get()->result();
	
	}
	
	public function FetchByKeyword($keyword) {
		/**
		 * Takes any string keyword or integer and returns list of matches from 
		 * Catalogue Number, Department Name, Course Name, and Faculty Name.
		 */
		$this->db->select('Courses.ID, 
			Courses.Name AS Course_Name, 
			Departments.Name AS Department_Name, 
			Faculty.FirstName, 
			Faculty.LastName, 
			Credit_Codes.Type, 
			TimeSlots_Courses.Day, 
			TimeSlots_Courses.Start_time, 
			TimeSlots_Courses.End_time');
		$this->db->from('Courses');
		// join all the tables together
		$this->db->join('Faculty_Courses', 'Courses.ID = Faculty_Courses.Course_ID');
		$this->db->join('Faculty', 'Faculty.ID = Faculty_Courses.Faculty_ID');
		// left join needed because not every course has a schedule yet
		$this->db->join('TimeSlots_Courses', 'TimeSlots_Courses.Courses_ID = Courses.ID', 'left');
		$this->db->join('Departments', 'Departments.ID = Courses.Dept_ID');
		$this->db->join('Credit_Codes', 'Credit_Codes.Code = Courses.Credits');
		if (is_int($keyword)) {
			$this->db->where('Courses.ID', $keyword); //searches directly for cat_num if input is an integer
		}
		// if input is not an integer, search 5 fields
		else {
			// append + char to each word in string to force inclusion in MySQL fulltext search
			$symbol = '+';
			$keyword = $symbol . str_replace(' ', " $symbol", $keyword);
			
			// fulltext searches can only be done on single tables at a time. Database must have FULLTEXT indices matching the MATCH clause
			$this->db->where("MATCH(Courses.Name) AGAINST('$keyword' IN BOOLEAN MODE)");
			$this->db->or_where("MATCH(Courses.Description) AGAINST('$keyword' IN BOOLEAN MODE)");
			$this->db->or_where("MATCH(Departments.Name) AGAINST('$keyword' IN BOOLEAN MODE)");
			$this->db->or_where("MATCH(Faculty.FirstName, Faculty.LastName) AGAINST('$keyword' IN BOOLEAN MODE)");
			$this->db->or_where('Courses.ID', $keyword);
		}
		return $this->db->get()->result();
	
	}		
	
	public function FetchFacultyID($lastname) {
		/**
		 * Take in Faculty last name and return array of Faculty with their IDs
		 */
		$this->db->select('Faculty.ID, Faculty.FirstName, Faculty.LastName');
		$this->db->from('Faculty');
		$this->db->where("MATCH(Faculty.LastName) AGAINST('$lastname' IN BOOLEAN MODE)");
		return $this->db->get()->result();
	}
	
	
	public function FetchByCategory($category) {
		/**
		 *
		 * Takes category name (needs to match database table name) and returns an array of all the objects
		 */
		if ($category == 'Faculty'){
			/**
			 * Returns list of Faculty sorted alphabetically by Last Name
			 */
			$this->db->order_by('Faculty.LastName', 'asc');
			return $this->db->get('Faculty')->result();
		}
		else if ($category == 'Departments'){
			/**
			 * Returns list of departments sorted alphabetically by name
			 */
			$this->db->order_by('Departments.Name', 'asc');
			return $this->db->get('Departments')->result();		
		}
		else if ($category == 'GenEd'){
			/**
			 * Returns list of all departments that offer Gen Ed courses
			 */
			$this->db->select('Departments.Name, Departments.ID');
			$this->db->distinct();
			$this->db->from('Departments');
			$this->db->join('Courses', 'Courses.Dept_ID = Departments.ID');
			$this->db->where('Courses.GenEd', '1');
			$this->db->order_by('Departments.Name', 'asc');
			return $this->db->get()->result();					
		}
	}
/*
	public function FetchGenEd() {
		// Returns list of all departments that offer Gen Ed courses
		
		$this->db->select('Departments.Name, Departments.ID');
		$this->db->distinct();
		$this->db->from('Departments');
		$this->db->join('Courses', 'Courses.Dept_ID = Departments.ID');
		$this->db->where('Courses.GenEd', '1');
		return $this->db->get()->result();					
	}
*/
	public function FetchClassListNew($param = array()) {
		/**
		 * Takes search criteria and returns a list of courses that meet the criteria.
		 *
		 * Input is an associative array with 7 key values: fac, term, day, begin, end, credits, gened.
		 * Values of input array can also be arrays themselves
		 */
		$tables = array('dpt'=>'Departments.ID', 
			'fac'=>'Faculty.ID', 
			'term'=>'TimeSlots_Courses.Term', 
			'day'=>'TimeSlots_Courses.Day', 
			'begin'=>'TimeSlots_Courses.Start_time',
			'end'=>'TimeSlots_Courses.End_Time',
			'credits'=>'Courses.Credits',
			'gened'=>'Courses.GenEd'
		);
		$this->db->select('Courses.GenEd, 
			Courses.ID, 
			Courses.Name AS Course_Name, 
			Departments.Name AS Department_Name, 
			Faculty.FirstName, 
			Faculty.LastName, 
			Credit_Codes.Type, 
			TimeSlots_Courses.Day, 
			TimeSlots_Courses.Start_time, 
			TimeSlots_Courses.End_time');
		if (isset($param['gened']) && $param['gened'] == 2) {
			$param['gened'] = array(0,1);
		}
		$this->db->from('Courses');
		// join all the tables together
		$this->db->join('Faculty_Courses', 'Courses.ID = Faculty_Courses.Course_ID');
		$this->db->join('Faculty', 'Faculty.ID = Faculty_Courses.Faculty_ID');
		// left join needed because not every course has a schedule yet
		$this->db->join('TimeSlots_Courses', 'TimeSlots_Courses.Courses_ID = Courses.ID', 'left');
		$this->db->join('Departments', 'Departments.ID = Courses.Dept_ID');
		$this->db->join('Credit_Codes', 'Credit_Codes.Code = Courses.Credits');
		foreach ($param as $key => $value){
			$this->db->where_in($tables[$key],$value);
		}
		return $this->db->get()->result();
			
	}

	public function FetchStartingTimes() {
		$this->db->select('TimeSlots_Courses.Start_time');
		$this->db->order_by('TimeSlots_Courses.Start_time','asc');
		$this->db->from('TimeSlots_Courses');
		$this->db->distinct();
		return $this->db->get()->result();
	}

	public function FetchClassList($dpt = NULL, $fac = NULL, $term = NULL, $day = NULL, $begin = NULL, $end = NULL, $credits = NULL, $gened = NULL) {
		/**
		 * NOT USED. REPLACED WITH FetchClassListNew
		 *
		 * Takes search criteria and returns a list of courses that meet the criteria
		 * 
		 * $dpt is an array of Department.ID strings
		 * $fac is an array Faculty.ID strings
		 * $term, $day, $begin, $end are arrays of ints
		 * $credis is an int. Front end should translate user selection of "half course" into "1", "full course" into "2", and "quarter course" into "3"
		 * $gened is a boolean. 
		 * Note: Arguments at the end of the list are optional, but missing arguments in the middle of a list should be set to NULL
		 */
		$this->db->select('Courses.GenEd, Courses.ID, Courses.Name AS Course_Name, Departments.Name AS Department_Name, Faculty.FirstName, Faculty.LastName, Credit_Codes.Type, TimeSlots_Courses.Day, TimeSlots_Courses.Start_time, TimeSlots_Courses.End_time');
		$this->db->from('Courses');
		// join all the tables together
		$this->db->join('Faculty_Courses', 'Courses.ID = Faculty_Courses.Course_ID');
		$this->db->join('Faculty', 'Faculty.ID = Faculty_Courses.Faculty_ID');	
		$this->db->join('TimeSlots_Courses', 'TimeSlots_Courses.Courses_ID = Courses.ID', 'left'); // left join needed because not every course has a schedule yet
		$this->db->join('Departments', 'Departments.ID = Courses.Dept_ID');
		$this->db->join('Credit_Codes', 'Credit_Codes.Code = Courses.Credits');
		
		//add in WHERE clauses if parameters are passed in to function
		if ($dpt != 'NULL') {
			$this->db->where_in('Departments.ID', $dpt); // for array version, create an associative array of (variable, table name)
		}
		if ($fac != 'NULL') {
			$this->db->where_in('Faculty.ID', $fac);
		}
		if ($term != NULL) { 
			$this->db->where_in('TimeSlots_Courses.Term', $term);
		}
		if ($day != NULL) {
			$this->db->where_in('TimeSlots_Courses.Day', $day);
		}
		if ($begin != NULL) {
			$this->db->where_in('TimeSlots_Courses.Start_time', $begin);
		}
		if ($end != NULL) {
			$this->db->where_in('TimeSlots_Courses.End_time', $end);
		}
		if ($credits != NULL) {
			$this->db->where_in('Courses.Credits', $credits);
		}
		if ($gened != NULL) {
			$this->db->where('Courses.GenEd', $gened);
		}
		return $this->db->get()->result();
	}	

/*	public function testing3($id, $time) {
		$this->db->select('Courses.ID, TimeSlots_Courses.Term, TimeSlots_Courses.Day');
		$this->db->from('Courses');
		$this->db->join('TimeSlots_Courses', 'TimeSlots_Courses.Courses_ID = Courses.ID', 'left');
		$this->db->where_in('TimeSlots_Courses.Term',$time);
		$this->db->where_in('Courses.ID', $id);
		return $this->db->get()->result();
	
	}

	public function FetchFacultyList() {

		$this->db->order_by('Faculty.LastName', 'asc');
		return $this->db->get('Faculty')->result();
	}

	public function FetchDepartmentsList() {

		$this->db->order_by('Departments.Name', 'asc');
		return $this->db->get('Departments')->result();
	}
*/
}

?>
