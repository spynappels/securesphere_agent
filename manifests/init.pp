class aioinstall (
  String $installer_loc = 'C:\Users\Public\Downloads\Imperva-ragent-Windows-b11.0.0.8026',
  String $installer_file = 'Imperva-ragent-Windows-b11.0.0.8026.msi',
  String $install_dir = 'C:\Program Files (x86)\Imperva',
  String $agent_name = 'puppet_ssagent',
  String $gw_ip = '10.4.253.103'
  ){
  package { 'Imperva SecureSphere Remote Agent':
    ensure => installed,
    source => $installerloc$installer_file,
    install_options => [ { 'TARGETDIR' => $install_dir}, { 'NOSCRIPT' => 'true'} ],
  }

  exec { 'register-ragent':
    path => 'C:/Program Files (x86)/Imperva/RemoteAgent',
    command => "RemoteAgentCli.exe registration advanced-register is-db-agent=true ragent-name=$agent_name gateway=$gwip password=secure"
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
