# Ansible Java Role

[![Circle CI](https://circleci.com/gh/playlist-ansible/java.svg?style=shield)](https://circleci.com/gh/playlist-ansible/java)
[![Galaxy](https://img.shields.io/badge/galaxy-playlist.java-blue.svg)](https://galaxy.ansible.com/list#/roles/3241)

Manages installations of Java JREs and JDKs, supporting both OpenJDK and Oracle JRE and JDK 6, 7, and 8.

## Requirements and Dependencies

None.

## Installation

Using `ansible-galaxy`:

```
$ ansible-galaxy install playlist.java
```

## Role Variables

```yaml
java_packages:
  - openjdk-7-jre
```

Valid packages include:

* openjdk-6-jre
* openjdk-6-jre-headless
* openjdk-6-jdk
* openjdk-7-jre
* openjdk-7-jre-headless
* openjdk-7-jdk
* oracle-java6-installer
* oracle-java7-installer
* oracle-java8-installer

For 32-bit versions, append `:i386` to the package names.  If you're installing Oracle JDK and want it to be the default, add `oracle-java6-set-default`, `oracle-java7-set-default` or `oracle-java6-set-default` to the `java_packages` list.

## Example Playbook

```yaml
- hosts: servers
  roles:
    - playlist.java
```

## Testing

```
$ git clone https://github.com/playlist-ansible/java.git
$ cd java
$ make
```
