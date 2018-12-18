class aioinstall {
  package { 'Imperva SecureSphere Remote Agent':
    ensure => installed,
    source => 'C:\Users\Public\Downloads\Imperva-ragent-Windows-b11.0.0.8026\Imperva-ragent-Windows-b11.0.0.8026.msi',
    install_options => [ { 'TARGETDIR' => 'C:\Program Files (x86)\Imperva'}, { 'NOSCRIPT' => 'true'} ],
  }

  exec { 'register-ragent':
    path => 'C:/Program Files (x86)/Imperva/RemoteAgent',
    command => 'RemoteAgentCli.exe registration advanced-register is-db-agent=true ragent-name=pupp-ragent gateway=10.4.253.103 password=secure'
    subscribe => Package['Imperva SecureSphere Remote Agent'],
    refreshonly => true,
	  before => Service['SecureSphereRemoteAgent'],
  }

  service { 'SecureSphereRemoteAgent':
    ensure => 'running',
	  enable => 'true',
	  require => Package['Imperva SecureSphere Remote Agent'],
  }
}
