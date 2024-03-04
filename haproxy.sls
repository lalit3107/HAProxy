# location of file /srv/salt/haproxy/
install_haproxy:
  pkg.installed:
    - name: haproxy

haproxy_config:
  file.managed:
    - name: /etc/haproxy/haproxy.cfg
    - source: salt://haproxy/templates/haproxy.cfg.jinja
    - template: jinja
    - user: root
    - group: root
    - mode: 644
    - context:
        web1_ip: '192.168.1.101'
        web2_ip: '192.168.1.102'
    - require:
      - pkg: install_haproxy
    - watch_in:
      - service: haproxy_service

haproxy_service:
  service.running:
    - name: haproxy
    - enable: True
    - reload: True
    - require:
      - file: haproxy_config
