Name:           gcab
Version:        0.3
Release:        3%{?dist}
Summary:        Cabinet file library and tool

Group:          Development/Tools
License:        LGPLv2+
#VCS:           git:git://git.gnome.org/gcab
URL:            http://ftp.gnome.org/pub/GNOME/sources/gcab
Source0:        http://ftp.gnome.org/pub/GNOME/sources/gcab/%{version}/%{name}-%{version}.tar.xz
BuildRoot:      %{_tmppath}/%{name}-%{version}-%{release}-root-%(%{__id_u} -n)

BuildRequires:  intltool
BuildRequires:  vala-tools
BuildRequires:  glib2-devel
BuildRequires:  gobject-introspection-devel
BuildRequires:  zlib-devel
Requires:       libgcab1%{?_isa} = %{version}-%{release}

%description
gcab is a tool to manipulate Cabinet archive.

%package -n libgcab1
Summary:        Library to create Cabinet archives
Group:          Development/Libraries

%description -n libgcab1
libgcab is a library to manipulate Cabinet archive using GIO/GObject.

%package -n libgcab1-devel
Summary:        Development files to create Cabinet archives
Group:          Development/Libraries
Requires:       libgcab1%{?_isa} = %{version}-%{release}
Requires:       pkgconfig
Requires:       glib2-devel

%description -n libgcab1-devel
libgcab is a library to manipulate Cabinet archive.

Libraries, includes, etc. to compile with the gcab library.

%prep
%setup -q

%build
# --enable-fast-install is needed to fix libtool "cannot relink `gcab'"
%configure --disable-silent-rules --disable-static --enable-fast-install
make %{?_smp_mflags}

%install
rm -rf %{buildroot}
make DESTDIR=%{buildroot} install
# fixed in upstream master
mkdir -p %{buildroot}%{_mandir}/man1/
cp -p gcab.1 %{buildroot}%{_mandir}/man1/

rm -f %{buildroot}%{_libdir}/*.a
rm -f %{buildroot}%{_libdir}/*.la

%find_lang %{name}

%clean
rm -rf %{buildroot}

%post -n libgcab1 -p /sbin/ldconfig
%postun -n libgcab1 -p /sbin/ldconfig

%files
%doc COPYING NEWS
%{_bindir}/gcab
%{_mandir}/man1/gcab.1*

%files -n libgcab1 -f %{name}.lang
%doc COPYING NEWS
%{_libdir}/girepository-1.0/GCab-1.0.typelib
%{_libdir}/libgcab-1.0.so.*

%files -n libgcab1-devel
%{_datadir}/gir-1.0/GCab-1.0.gir
%{_datadir}/gtk-doc/html/gcab/*
%{_datadir}/vala/vapi/libgcab-1.0.vapi
%{_includedir}/libgcab-1.0/*
%{_libdir}/libgcab-1.0.so
%{_libdir}/pkgconfig/libgcab-1.0.pc

%changelog
* Fri Feb  8 2013 Marc-André Lureau <marcandre.lureau@redhat.com> - 0.3-3
- Align more fields.
- Use double percentage in comment.
- Include COPYING file in gcab package too.

* Fri Feb  8 2013 Marc-André Lureau <marcandre.lureau@redhat.com> - 0.3-2
- Untabify.
- Use %%{buildroot} consitantly.
- Do not use -1.0 in package names.
- Add more tags based on the el5 spec template.
- Re-add --enable-fast-install trick, to make gcab relink.

* Tue Jan 26 2013 Marc-André Lureau <marcandre.lureau@redhat.com> - 0.3-1
- Initial package (rhbz#895757)
