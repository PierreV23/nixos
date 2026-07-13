{ secrets }:
{
  personal = ''
    eth:
      Hostname: ${secrets.eth.ip}
      User: root
    wg-mediaserver:
      Hostname: ${secrets.mediaserver.wg.local_ip}
      User: root
      Gateways: [ direct, eth ]
    nova:
      Hostname: ${secrets.nova.ip}
      User: root
    hostbrr:
      Hostname: ${secrets.hostbrr.hostname}
      User: ${secrets.hostbrr.user}
      Port: ${secrets.hostbrr.port}
    mediaserver:
      Hostname: ${secrets.mediaserver.ip_local}
      User: root
      Gateways: [ direct, wg-mediaserver ]
    r5homeserver:
      Hostname: ${secrets.r5homeserver.ip_local}
      User: pierre
      Gateways: [ direct, wg-mediaserver ]
    github.com:
      Hostname: github.com
      User: git
  '';
}