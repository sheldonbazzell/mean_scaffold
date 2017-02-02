<h1>Mean Scaffold</h1>
<h4>Get a full MEAN prototype up and running quickly from the command line</h4>
<p>Highly customizable before and after your code is compiled. Currently compatible with the stock MEAN stack</p>
<h2>Setup</h2>
<p>Find a directory where you want to start your app. We'll call this your 'super root', as Mean Scaffold will create a root directory within this directory for your app.<p>
<hr>
<h2>Install</h2>
<h3>npm install mean-scaffold</h3>
<hr>
<h2>Model Setup</h2>
<p>Your command line will prompt you for the following:</p>
<ol>
  <li>Project Name</li>
  <li>Model Name</li>
  <li>Attribute Name</li>
  <li>Attribute Type</li>
  <li>Another Attribute in this Model? If yes, repeat step 3</li>
  <li>Another Model? If yes, repeat step 2</li>
</ol>
<hr>
<h2>Associations</h2>
<p>Currently supports a one-to-many relationship. The parent class must be declared first with a attribute name of the related class (singular), and attribute type of ObjectsArray. The child class must be declared directly after the parent, with an attribute name of the related class (singular), and attribute type of ObjectId.</p>
<p>Example:</p>
<p>Model: User</p>
<p>Attribute Name: post</p>
<p>Attribute Type: ObjectsArray</p>
<p>Model: Post</p>
<p>Attribute Name: user</p>
<p>Attribute Type: ObjectId</p>
<h2>Done</h2>
 