<?php

	require_once(TOOLKIT . '/class.event.php');

	Class eventsave_object extends Event{

		const ROOTELEMENT = 'save-object';

		public $eParamFILTERS = array(

		);

		public static function about(){
			return array(
					 'name' => 'Save Object',
					 'author' => array(
							'name' => 'Marco Sampellegrini',
							'email' => 'm@rcosa.mp'),
					 'version' => '1.0',
					 'release-date' => '2010-04-24T19:57:04+00:00',
					 'trigger-condition' => 'action[save-object]');
		}

		public static function getSource(){
			return '3';
		}

		public static function allowEditorToParse(){
			return true;
		}

		public static function documentation(){
			return '
        <h3>Success and Failure XML Examples</h3>
        <p>When saved successfully, the following XML will be returned:</p>
        <pre class="XML"><code>&lt;save-object result="success" type="create | edit">
  &lt;message>Entry [created | edited] successfully.&lt;/message>
&lt;/save-object></code></pre>
        <p>When an error occurs during saving, due to either missing or invalid fields, the following XML will be returned:</p>
        <pre class="XML"><code>&lt;save-object result="error">
  &lt;message>Entry encountered errors when saving.&lt;/message>
  &lt;field-name type="invalid | missing" />
  ...
&lt;/save-object></code></pre>
        <h3>Example Front-end Form Markup</h3>
        <p>This is an example of the form markup you can use on your frontend:</p>
        <pre class="XML"><code>&lt;form method="post" action="" enctype="multipart/form-data">
  &lt;input name="MAX_FILE_SIZE" type="hidden" value="5242880" />
  &lt;label>Web Id
    &lt;input name="fields[web-id]" type="text" />
  &lt;/label>
  &lt;label>Name
    &lt;input name="fields[name]" type="text" />
  &lt;/label>
  &lt;label>Author
    &lt;input name="fields[author]" type="text" />
  &lt;/label>
  &lt;label>Description
    &lt;textarea name="fields[description]" rows="1" cols="50">&lt;/textarea>
  &lt;/label>
  &lt;label>Type
    &lt;select name="fields[type]">
      &lt;option value="Extension">Extension&lt;/option>
      &lt;option value="Utility">Utility&lt;/option>
    &lt;/select>
  &lt;/label>
  &lt;label>Favourited
    &lt;input name="fields[favourited]" type="checkbox" />
  &lt;/label>
  &lt;input name="action[save-object]" type="submit" value="Submit" />
&lt;/form></code></pre>
        <p>To edit an existing entry, include the entry ID value of the entry in the form. This is best as a hidden field like so:</p>
        <pre class="XML"><code>&lt;input name="id" type="hidden" value="23" /></code></pre>
        <p>To redirect to a different location upon a successful save, include the redirect location in the form. This is best as a hidden field like so, where the value is the URL to redirect to:</p>
        <pre class="XML"><code>&lt;input name="redirect" type="hidden" value="http://192.168.1.57/builder/success/" /></code></pre>';
		}

		public function load(){
			if(isset($_POST['action']['save-object'])) return $this->__trigger();
		}

		protected function __trigger(){
			include(TOOLKIT . '/events/event.section.php');
			return $result;
		}

	}

