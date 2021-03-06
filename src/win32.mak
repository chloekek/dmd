#_ win32.mak
#
# Copyright (C) 1999-2019 by The D Language Foundation, All Rights Reserved
# written by Walter Bright
# http://www.digitalmars.com
# Distributed under the Boost Software License, Version 1.0.
# http://www.boost.org/LICENSE_1_0.txt
# https://github.com/dlang/dmd/blob/master/src/win32.mak
#
# Dependencies:
#
# Digital Mars C++ toolset
#   http://www.digitalmars.com/download/freecompiler.html
#
# win32.mak (this file) - requires Digital Mars Make ($DM_HOME\dm\bin\make.exe)
#   http://www.digitalmars.com/ctg/make.html
#
# Configuration:
#
# The easiest and recommended way to configure this makefile is to add
# $DM_HOME\dm\bin to your PATH environment to automatically find make.
# Set HOST_DC to point to your installed D compiler.
#
# Targets:
#
# defaulttarget - debug dmd
# release       - release dmd (with clean)
# trace         - release dmd with tracing options enabled
# clean         - delete all generated files except target binary
# install       - copy build targets to install directory
# install-clean - delete all files in the install directory
# zip           - create ZIP archive of source code
#
# dmd           - release dmd (legacy target)
# debdmd        - debug dmd
# reldmd        - release dmd

############################### Configuration ################################

# fixed model for win32.mak, overridden by win64.mak
MODEL=32
BUILD=release
OS=windows

##### Directories

# DMD source directories
D=dmd
C=$D\backend
ROOT=$D\root

# Include directories
INCLUDE=$(ROOT)
# Install directory
INSTALL=..\install

# Generated files directory
GEN = ..\generated
G = $(GEN)\$(OS)\$(BUILD)\$(MODEL)

##### Tools

# D compiler (set with env variable)
#HOST_DC=dmd
# Make program
MAKE=make
# Delete file(s)
DEL=del
# Make directory
MD=mkdir
# Remove directory
RD=rmdir
# File copy
CP=cp

##### User configuration switches

# Target name
TARGET=$G\dmd
TARGETEXE=$(TARGET).exe
# Debug flags
DEBUG=-gl -D -DUNITTEST
# D Optimizer flags
DOPT=
# D Model flags
DMODEL=-m$(MODEL)
# D Debug flags
DDEBUG=-debug -g -unittest

##### Implementation variables (do not modify)

# D compile flags
DFLAGS=$(DOPT) $(DMODEL) $(DDEBUG) -wi -version=MARS -dip25

# Recursive make
DMDMAKE=$(MAKE) -fwin32.mak C=$C ROOT=$(ROOT) MAKE="$(MAKE)" HOST_DC="$(HOST_DC)" MODEL=$(MODEL) CC="$(CC)"

############################### Rule Variables ###############################

# D front end
FRONT_SRCS=$D/access.d $D/aggregate.d $D/aliasthis.d $D/apply.d $D/argtypes.d $D/argtypes_sysv_x64.d $D/arrayop.d	\
	$D/arraytypes.d $D/astcodegen.d $D/ast_node.d $D/attrib.d $D/builtin.d $D/canthrow.d $D/cli.d $D/clone.d $D/compiler.d $D/complex.d	\
	$D/cond.d $D/constfold.d $D/cppmangle.d $D/cppmanglewin.d $D/ctfeexpr.d $D/ctorflow.d $D/dcast.d $D/dclass.d		\
	$D/declaration.d $D/delegatize.d $D/denum.d $D/dimport.d $D/dinifile.d $D/dinterpret.d	\
	$D/dmacro.d $D/dmangle.d $D/dmodule.d $D/doc.d $D/dscope.d $D/dstruct.d $D/dsymbol.d $D/dsymbolsem.d		\
	$D/lambdacomp.d $D/dtemplate.d $D/dversion.d $D/env.d $D/escape.d			\
	$D/expression.d $D/expressionsem.d $D/func.d $D/hdrgen.d $D/id.d $D/imphint.d	\
	$D/impcnvtab.d $D/init.d $D/initsem.d $D/inline.d $D/inlinecost.d $D/intrange.d $D/json.d $D/lib.d $D/link.d	\
	$D/mars.d $D/mtype.d $D/nogc.d $D/nspace.d $D/objc.d $D/opover.d $D/optimize.d $D/parse.d	\
	$D/sapply.d $D/sideeffect.d $D/statement.d $D/staticassert.d $D/target.d	\
	$D/safe.d $D/blockexit.d $D/permissivevisitor.d $D/transitivevisitor.d $D/parsetimevisitor.d $D/printast.d $D/typesem.d \
	$D/traits.d $D/utils.d $D/visitor.d $D/libomf.d $D/scanomf.d $D/templateparamsem.d $D/typinf.d \
	$D/libmscoff.d $D/scanmscoff.d $D/statement_rewrite_walker.d $D/statementsem.d $D/staticcond.d \
	$D/semantic2.d $D/semantic3.d $D/foreachvar.d

LEXER_SRCS=$D/console.d $D/entity.d $D/errors.d $D/filecache.d $D/globals.d $D/id.d $D/identifier.d \
	$D/lexer.d $D/tokens.d $D/utf.d

LEXER_ROOT=$(ROOT)/array.d $(ROOT)/bitarray.d $(ROOT)/ctfloat.d $(ROOT)/file.d $(ROOT)/filename.d \
	$(ROOT)/outbuffer.d $(ROOT)/port.d $(ROOT)/rmem.d $(ROOT)/rootobject.d \
	$(ROOT)/stringtable.d $(ROOT)/hash.d

PARSER_SRCS=$D/astbase.d $D/parsetimevisitor.d $D/parse.d $D/transitivevisitor.d $D/permissivevisitor.d $D/strictvisitor.d $D/utils.d

GLUE_SRCS=$D/irstate.d $D/toctype.d $D/glue.d $D/gluelayer.d $D/todt.d $D/tocsym.d $D/toir.d $D/dmsc.d \
	$D/tocvdebug.d $D/s2ir.d $D/toobj.d $D/e2ir.d $D/objc_glue.d $D/eh.d $D/iasm.d $D/iasmdmd.d $D/iasmgcc.d

BACK_HDRS=$C/cc.d $C/cdef.d $C/cgcv.d $C/code.d $C/cv4.d $C/dt.d $C/el.d $C/global.d \
	$C/obj.d $C/oper.d $C/outbuf.d $C/rtlsym.d $C/code_x86.d $C/iasm.d $C/codebuilder.d \
	$C/ty.d $C/type.d $C/exh.d $C/mach.d $C/mscoff.d $C/dwarf.d $C/dwarf2.d $C/xmm.d \
	$C/dlist.d $C/melf.d $C/varstats.di $C/barray.d

DMD_SRCS=$(FRONT_SRCS) $(GLUE_SRCS) $(BACK_HDRS)

# Root package
ROOT_SRCS=$(ROOT)/aav.d $(ROOT)/array.d $(ROOT)/bitarray.d $(ROOT)/ctfloat.d $(ROOT)/file.d \
	$(ROOT)/filename.d $(ROOT)/longdouble.d $(ROOT)/man.d $(ROOT)/outbuffer.d $(ROOT)/port.d \
	$(ROOT)/response.d $(ROOT)/rmem.d $(ROOT)/rootobject.d $(ROOT)/region.d \
	$(ROOT)/speller.d $(ROOT)/stringtable.d $(ROOT)/strtold.d $(ROOT)/hash.d $(ROOT)/string.d

# D front end
SRCS = $D/aggregate.h $D/aliasthis.h $D/arraytypes.h	\
	$D/attrib.h $D/compiler.h $D/complex_t.h $D/cond.h $D/ctfe.h $D/ctfe.h $D/declaration.h $D/dsymbol.h	\
	$D/enum.h $D/errors.h $D/expression.h $D/globals.h $D/hdrgen.h $D/identifier.h	\
	$D/id.h $D/import.h $D/init.h $D/json.h	\
	$D/module.h $D/mtype.h $D/nspace.h $D/objc.h                         \
	$D/scope.h $D/statement.h $D/staticassert.h $D/target.h $D/template.h $D/tokens.h	\
	$D/version.h $D/visitor.h $D/objc.d $(DMD_SRCS)

# Glue layer
GLUESRC= \
	$D/libelf.d $D/scanelf.d $D/libmach.d $D/scanmach.d \
	$(GLUE_SRCS)

# D back end
BACKSRC= \
	$C/code_stub.h $C/platform_stub.c \
	$C\backend.d $C\bcomplex.d $C\blockopt.d $C\cg.d $C\cg87.d $C\cgxmm.d \
	$C\cgcod.d $C\cgcs.d $C\dcgcv.d $C\cgelem.d $C\cgen.d $C\cgobj.d \
	$C\compress.d $C\cgreg.d $C\var.d $C\cgcse.d \
	$C\cgsched.d $C\cod1.d $C\cod2.d $C\cod3.d $C\cod4.d $C\cod5.d \
	$C\dcode.d $C\symbol.d $C\debugprint.d $C\ee.d $C\elem.d $C\elpicpie.d \
	$C\evalu8.d $C\fp.d $C\go.d $C\gflow.d $C\gdag.d \
	$C\gother.d $C\glocal.d $C\gloop.d $C\gsroa.d $C\newman.d \
	$C\nteh.d $C\os.d $C\out.d $C\ptrntab.d $C\drtlsym.d \
	$C\dtype.d \
	$C\elfobj.d \
	$C\dwarfdbginf.d $C\machobj.d $C\aarray.d $C\barray.d \
	$C\md5.d $C\ph2.d $C\util2.d \
	$C\mscoffobj.d $C\pdata.d $C\cv8.d $C\backconfig.d \
	$C\divcoeff.d $C\dwarfeh.d $C\dvarstats.d \
	$C\dvec.d $C\filespec.d $C\mem.d $C\backend.txt

# Root package
ROOTSRCD=$(ROOT)\rmem.d $(ROOT)\stringtable.d $(ROOT)\hash.d $(ROOT)\man.d $(ROOT)\port.d \
	$(ROOT)\response.d $(ROOT)\rootobject.d $(ROOT)\speller.d $(ROOT)\aav.d \
	$(ROOT)\ctfloat.d $(ROOT)\longdouble.d $(ROOT)\outbuffer.d $(ROOT)\filename.d \
	$(ROOT)\file.d $(ROOT)\array.d $(ROOT)\bitarray.d $(ROOT)\strtold.d $(ROOT)\region.d
ROOTSRC= $(ROOT)\root.h \
	$(ROOT)\longdouble.h $(ROOT)\outbuffer.h $(ROOT)\object.h $(ROOT)\ctfloat.h \
	$(ROOT)\filename.h $(ROOT)\file.h $(ROOT)\array.h $(ROOT)\bitarray.h $(ROOT)\rmem.h \
	$(ROOTSRCD)
# Removed garbage collector bits (look in history)
#	$(ROOT)\gc\bits.c $(ROOT)\gc\gc.c $(ROOT)\gc\gc.h $(ROOT)\gc\mscbitops.h \
#	$(ROOT)\gc\bits.h $(ROOT)\gc\gccbitops.h $(ROOT)\gc\linux.c $(ROOT)\gc\os.h \
#	$(ROOT)\gc\win32.c

# Makefiles
MAKEFILES=win32.mak posix.mak osmodel.mak

RUN_BUILD=$(GEN)\build.exe --called-from-make "OS=$(OS)" "BUILD=$(BUILD)" "MODEL=$(MODEL)" "HOST_DMD=$(HOST_DMD)" "HOST_DC=$(HOST_DC)" "DDEBUG=$(DDEBUG)" "MAKE=$(MAKE)"

############################## Release Targets ###############################

defaulttarget: $G debdmd

# FIXME: Windows test suite uses src/dmd.exe instead of $(GENERATED)/dmd.exe
# FIXME: DDEBUG needs to be overidden to exclude unittests from dmd.exe
#        (They are compiled in a seperate executable for build.d's unittest target)
auto-tester-build: $(GEN)\build.exe
	$(RUN_BUILD) "DDEBUG=" "ENABLE_RELEASE=1" $@
	copy $(TARGETEXE) .

dmd: $G reldmd

$(GEN)\build.exe: build.d $(HOST_DMD_PATH)
	$(HOST_DC) -m$(MODEL) -of$@ build.d

release:
	$(DMDMAKE) clean
	$(DEL) $(TARGETEXE)
	$(DMDMAKE) reldmd
	$(DMDMAKE) clean

$G :
	if not exist "$G" mkdir $G

check-host-dc:
	@cmd /c if "$(HOST_DC)" == "" (echo Error: Environment variable HOST_DC is not set & exit 1)

debdmd: check-host-dc debdmd-make

debdmd-make:
	$(DMDMAKE) "OPT=" "DEBUG=-D -g -DUNITTEST" "DDEBUG=-debug -g -unittest" "DOPT=" $(TARGETEXE)

reldmd: check-host-dc reldmd-make

reldmd-make:
	$(DMDMAKE) "OPT=-o" "DEBUG=" "DDEBUG=" "DOPT=-O -release -inline" $(TARGETEXE)

profile:
	$(DMDMAKE) "OPT=-o" "DEBUG=" "DDEBUG=" "DOPT=-O -release -profile" $(TARGETEXE)

trace:
	$(DMDMAKE) "OPT=-o" "DEBUG=-gt -Nc" "DDEBUG=-debug -g -unittest" "DOPT=" $(TARGETEXE)

unittest:
	$(DMDMAKE) "OPT=-o" "DEBUG=" "DDEBUG=-debug -g -unittest -cov" "DOPT=" $(TARGETEXE)

################################ Libraries ##################################

$G\backend.lib:  $(GEN)\build.exe
	$(RUN_BUILD) $@

$G\lexer.lib: $(GEN)\build.exe
	$(RUN_BUILD) $@

$G\parser.lib: $(PARSER_SRCS) $G\lexer.lib $G
	$(HOST_DC) -of$@ -vtls -lib $(DFLAGS) $(PARSER_SRCS) $G\lexer.lib

$(TARGETEXE): $(GEN)\build.exe
	$(RUN_BUILD) $@
	copy $(TARGETEXE) .

############################ Maintenance Targets #############################

clean:
	$(RD) /s /q $(GEN)
	$(DEL) $D\msgs.h $D\msgs.c
	$(DEL) $(TARGETEXE) *.map *.obj *.exe

install: detab install-copy

install-copy:
	$(MD) $(INSTALL)\windows\bin
	$(MD) $(INSTALL)\windows\lib
	$(MD) $(INSTALL)\src\dmd\root
	$(MD) $(INSTALL)\src\dmd\backend
	$(CP) $(TARGETEXE)          $(INSTALL)\windows\bin\$(TARGETEXE)
	$(CP) $(SRCS)               $(INSTALL)\src\dmd
	$(CP) $(GLUESRC)            $(INSTALL)\src\dmd
	$(CP) $(ROOTSRC)            $(INSTALL)\src\dmd\root
	$(CP) $(BACKSRC)            $(INSTALL)\src\dmd\backend
	$(CP) $(MAKEFILES)          $(INSTALL)\src\dmd
	$(CP) $D\readme.txt            $(INSTALL)\src\dmd\readme.txt
	$(CP) $D\boostlicense.txt      $(INSTALL)\src\dmd\boostlicense.txt

install-clean:
	$(DEL) /s/q $(INSTALL)\*
	$(RD) /s/q $(INSTALL)

detab: $(GEN)\build.exe
	$(RUN_BUILD) $@

tolf: $(GEN)\build.exe
	$(RUN_BUILD) $@

zip: detab tolf $(GEN)\build.exe
	$(RUN_BUILD) $@

checkwhitespace: $(GEN)\build.exe
	$(RUN_BUILD) $@

######################################################

..\changelog.html: ..\changelog.dd
	$(HOST_DC) -Df$@ $<

############################## Generated Source ##############################

$G\VERSION : ..\VERSION $G
	copy ..\VERSION $@
