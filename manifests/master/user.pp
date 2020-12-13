user { 'rogerio':
	ensure		=> 'present',
	groups		=> ['g_ti', 'vagrant'],
	gid		=> '100',
	home		=> '/home/rogerio',
	shell		=> '/bin/bash',
	uid		=> '5000',
	managehome	=> true,
}
