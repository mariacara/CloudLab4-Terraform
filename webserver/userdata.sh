#!/bin/bash
sudo yum install httpd -y
cd /var/www/html
echo "<html><head>
<style>
h1 {
  color: #B389FC;
  font-family: georgia;
  font-size: 300%;
}
</style>
</head>
<body>
<h1> Hello $(hostname -f) </h1>
</body></html>" > index.html
sudo systemctl restart httpd
sudo systemctl enable httpd