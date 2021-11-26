include:
  - haproxy.rsyslog

haproxy-depend-package:
  pkg.installed:
    - pkgs:
      - make
      - gcc
      - gcc-c++
      - pcre-devel
      - bzip2-devel
      - openssl-devel
      - systemd-devel

haproxy:
  user.present:
    - system: true
    - shell: /sbin/nologin
    - createhome: flase

unzip-haproxy:
  archive.extracted:
    - name: /usr/src
    - source: salt://modules/cluster/haproxy/files/haproxy-{{ pillar['haproxy_version'] }}.tar.gz

salt://modules/cluster/haproxy/files/install.sh.j2:
  cmd.script:
    - require:
      - archive: unzip-haproxy
    - template: jinja
    - unless:  test -d {{ pillar['haproxy_install_dir'] }}

/usr/sbin/haproxy:
  file.symlink:
    - target: {{ pillar['haproxy_install_dir'] }}/sbin/haproxy

/etc/sysctl.conf:
  file.append:
    - text:
      - net.ipv4.ip_nonlocal_bind = 1
      - net.ipv4.ip_forward = 1
  cmd.run:
    - name: sysctl -p

{{ pillar['haproxy_install_dir'] }}/conf:
  file.directory:
    - user: root
    - group: root
    - mode: '0755'
    - makedirs: true
    - require:
      - cmd: salt://modules/cluster/haproxy/files/install.sh.j2

{{ pillar['haproxy_install_dir'] }}/conf/haproxy.cfg:
  file.managed:
    - source: salt://modules/cluster/haproxy/files/haproxy.cfg.j2
    - user: root
    - group: root
    - mode: '0644'
    - template: jinja

/usr/lib/systemd/system/haproxy.service:
  file.managed:
    - source: salt://modules/cluster/haproxy/files/haproxy.service.j2
    - user: root
    - group: root
    - mode: '0644'
    - template: jinja

haproxy.service:
  service.running:
    - enable: true
    - reload: true
    - watch:
      - file: {{ pillar['haproxy_install_dir'] }}/conf/haproxy.cfg
