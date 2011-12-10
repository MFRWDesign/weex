%define version 2.6.1
%define release 1

Summary: a non-interactive FTP client for updating web pages
Name: weex
Version: %version
Release: %release
Source: http://www.enjoy.ne.jp/~gm/program/weex/arc/weex-%{version}.tar.gz
Copyright: GPL
Group: Applications/Networking
Packager: Yuuki NINOMIYA <gm@debian.or.jp>
URL: http://www.enjoy.ne.jp/~gm/
Buildroot: /tmp/rpm-weex
Summary(ja): web �ڡ��������������÷� FTP ���饤�����

%description
Weex is a utility designed to automate the task of remotely
maintaining a web page or other FTP archive. With weex, the
maintainer of a web site or archive that must be administered
through FTP interaction can largely ignore that process.
The archive administrator simply creates a local directory
that serves as an exact model for the offsite data.
All modifications and direct interaction is done locally to
this directory structure. When the administrator wishes to
coordinate the data on the remote site with that of the
local model directory, simply executing weex accomplishes
this in the most bandwidth-efficient fashion by only
transferring files that need updating. The program will
create or remove (!) files or directories as necessary to
accurately establish the local model on the remote server.

%description -l ja
weex �� web �ڡ������뤤�Ϥ���¾�Υ��������֤��֥��ƥʥ󥹤����Ȥ�
��ư�����뤿��˺������줿�����÷� FTP ���饤����ȤǤ���weex ��Ȥ���
web �ڡ����� FTP �ǥ����Ф�ž�������Ȥ������˴�ά�����뤳�Ȥ��Ǥ��ޤ���

�����֥ޥ�����ž���������ե�����ȥǥ��쥯�ȥ���������Ѱդ�
ñ�� weex ��¹Ԥ�������ǡ���������ɬ�פ�����ե�����Τߤ���⡼�Ȥ�
ž������ޤ���
��⡼�ȥ����Ф˥������Ʊ���������뤿��ˡ����Υץ�����
�ե�����/�ǥ��쥯�ȥ��ưŪ�˺���/������ޤ���

%changelog
* Tue Jun 13 2000 Yuuki NINOMIYA <gm@debian.or.jp>
- New version.

* Tue May 23 2000 Yuuki NINOMIYA <gm@debian.or.jp>
- New version.

* Wed May 03 2000 Yuuki NINOMIYA <gm@debian.or.jp>
- New version.

* Sun Apr 16 2000 Yuuki NINOMIYA <gm@debian.or.jp>
- New version.

* Fri Mar 24 2000 Yuuki NINOMIYA <gm@debian.or.jp>
- New version.

* Tue Feb 29 2000 Yuuki NINOMIYA <gm@debian.or.jp>
- New version.

* Fri Feb 25 2000 Yuuki NINOMIYA <gm@debian.or.jp>
- New version.

* Sun Jan 09 2000 Yuuki NINOMIYA <gm@debian.or.jp>
- New version.

* Mon Dec 20 1999 Yuuki NINOMIYA <gm@debian.or.jp>
- New version.

* Sat Dec 11 1999 Yuuki NINOMIYA <gm@debian.or.jp>
- New version.

* Fri Dec 10 1999 Yuuki NINOMIYA <gm@debian.or.jp>
- New version.

* Thu Dec 09 1999 Yuuki NINOMIYA <gm@debian.or.jp>
- New version.

* Mon Nov 29 1999 Yuuki NINOMIYA <gm@debian.or.jp>
- New version.

* Thu Nov 25 1999 Yuuki NINOMIYA <gm@debian.or.jp>
- New version.

* Sat Nov 13 1999 Yuuki NINOMIYA <gm@debian.or.jp>
- New version.

* Wed Nov 10 1999 Yuuki NINOMIYA <gm@debian.or.jp>
- New version.

* Mon Nov 08 1999 Yuuki NINOMIYA <gm@debian.or.jp>
- New version.

* Sun Nov 07 1999 Yuuki NINOMIYA <gm@debian.or.jp>
- New version.

* Sun Nov 07 1999 Yuuki NINOMIYA <gm@debian.or.jp>
- New version.

* Sat Nov 06 1999 Yuuki NINOMIYA <gm@debian.or.jp>
- New version.

* Sat Nov 06 1999 Yuuki NINOMIYA <gm@debian.or.jp>
- New version.

* Thu Nov 04 1999 Yuuki NINOMIYA <gm@debian.or.jp>
- Initial release.
%prep

%setup

%build
./configure --prefix=/usr
make

%install
make prefix=$RPM_BUILD_ROOT/usr install-strip

%clean
rm -rf $RPM_BUILD_ROOT

%files
%defattr(-,root,root)
%doc doc/README
%doc doc/ChangeLog
%doc doc/ChangeLog.ja
%doc doc/BUGS.ja
%doc doc/TODO.ja
%doc doc/BUGS
%doc doc/README.ja
%doc doc/FAQ.ja
%doc doc/sample.weexrc
%doc doc/THANKS
%doc doc/TODO
%doc doc/FAQ
%doc doc/AUTHORS
%doc doc/weex.cat
/usr/share/locale/ja/LC_MESSAGES/weex.mo
/usr/share/locale/de/LC_MESSAGES/weex.mo
/usr/share/locale/es/LC_MESSAGES/weex.mo
/usr/share/locale/nl/LC_MESSAGES/weex.mo
/usr/man/man1/weex.1
/usr/bin/weex
