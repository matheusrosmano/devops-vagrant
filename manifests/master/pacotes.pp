node 'pupagent.asf.com' {
	package { 'vim':
		provider	=> apt,
		ensure		=> installed,
	}
	package { 'net-tools':
		provider	=> apt,
		ensure		=> purged,
	}
}
	
