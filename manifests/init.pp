class sox {
	$tmpdir='/tmp/sox_inst'
	include lame
	file {$tmpdir:
		ensure=>directory
	} ->
	file {"$tmpdir/sox.tar.gz":
		ensure	=> file,
		source	=> 'puppet:///modules/sox/sox-14.4.1.tar.gz',
	} ->
	exec {'install_sox':
		command	=> 'tar -zxvf ./sox.tar.gz && cd sox-14.4.1 && ./configure && make && make install',
		cwd		=> $tmpdir,
		unless	=> 'which sox && sox --help-format mp3|grep "Format: mp3"',
		path	=> '/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin',
		require => [
			#Package['kernel-devel'],
			Exec['install_lame']
		]
	}
}

