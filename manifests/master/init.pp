class exemplo01 {
	file { '/tmp/testfile.txt':
		ensure	=> file,
		owner	=> root,
		group	=> root,
		mode	=> '0644',
		content	=> 'Conteúdo arquivo exemplo 01',
	}
}

class exemplo02 {
	user{ 'exemplo02':
		ensure		=> present,
		home		=> '/home/exemplo02',
		managehome	=> true,
	}
}

class exemplo03 {
	file { '/tmp/testfile2.txt':
		ensure		=> file,
		owner		=> root,
		group		=> root,
		content		=> 'Teste de exemplo 03',
	}
}

case $operatingsystem {
	'Debian': {
		include 'exemplo03'
	}
}
