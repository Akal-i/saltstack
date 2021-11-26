keepalived:
  pkg.installed

/scripts:
  file.directory:
    - user: root
    - group: root
    - mode: '0755'
    - makedirs: true
