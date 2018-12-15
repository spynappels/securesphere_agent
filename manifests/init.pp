class aioinstall {
  package { 'Imperva SecureSphere Remote Agent':
    ensure => installed,
    source => 'C:\Users\Public\Downloads\Imperva-ragent-Windows-b11.0.0.8026\Imperva-ragent-Windows-b11.0.0.8026.msi',
    install_options => [ { 'TARGETDIR' => 'C:\Program Files (x86)\Imperva'}, { 'NOSCRIPT' => 'true'} ],
  }

  exec { 'register-ragent':
    #path => 'C:/Program Files (x86)/Imperva/RemoteAgent',
    #command => "RemoteAgentCli.exe\ is-db-agent=true\ registration\ advanced-register\ ragent-name=pupp-ragent\ gw-ip=10.4.253.103",
	  command => 'C:\Windows\System32\cmd.exe /c "C:\Program Files (x86)\Imperva\RemoteAgent\RemoteAgentCli.exe"\ is-db-agent=true\ registration\ advanced-register\ ragent-name=pupp-ragent\ gw-ip=10.4.253.103',
    subscribe => Package['Imperva SecureSphere Remote Agent'],
    refreshonly => true,
  }
}
