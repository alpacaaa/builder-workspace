<?php

	require_once(TOOLKIT . '/class.datasource.php');

	Class datasourceobjects_utilities_favourited extends Datasource{

		public $dsParamROOTELEMENT = 'objects-utilities-favourited';
		public $dsParamORDER = 'desc';
		public $dsParamLIMIT = '9999';
		public $dsParamREDIRECTONEMPTY = 'no';
		public $dsParamSORT = 'system:id';
		public $dsParamSTARTPAGE = '1';
		public $dsParamASSOCIATEDENTRYCOUNTS = 'no';

		public $dsParamFILTERS = array(
				'11' => 'Utility',
				'9' => 'yes',
		);

		public $dsParamINCLUDEDELEMENTS = array(
				'web-id',
				'name',
				'author',
				'description'
		);

		public function __construct(&$parent, $env=NULL, $process_params=true){
			parent::__construct($parent, $env, $process_params);
			$this->_dependencies = array();
		}

		public function about(){
			return array(
					 'name' => 'Objects - Utilities - Favourited',
					 'author' => array(
							'name' => 'Marco Sampellegrini',
							'email' => 'm@rcosa.mp'),
					 'version' => '1.0',
					 'release-date' => '2010-05-09T08:52:59+00:00');
		}

		public function getSource(){
			return '3';
		}

		public function allowEditorToParse(){
			return true;
		}

		public function grab(&$param_pool=NULL){
			$result = new XMLElement($this->dsParamROOTELEMENT);

			try{
				include(TOOLKIT . '/data-sources/datasource.section.php');
			}
			catch(FrontendPageNotFoundException $e){
				// Work around. This ensures the 404 page is displayed and
				// is not picked up by the default catch() statement below
				FrontendPageNotFoundExceptionHandler::render($e);
			}
			catch(Exception $e){
				$result->appendChild(new XMLElement('error', $e->getMessage()));
				return $result;
			}

			if($this->_force_empty_result) $result = $this->emptyXMLSet();
			return $result;
		}
	}

