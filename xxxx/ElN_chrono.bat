@echo off
:: HEI EDA Launch Script (HELS)
:: Copyright (C) 2015,2016 HES-SO Valais Wallis / HEI

:: This program is free software: you can redistribute it and/or modify
:: it under the terms of the GNU General Public License as published by
:: the Free Software Foundation, either version 3 of the License, or
:: (at your option) any later version.
:: This program is distributed in the hope that it will be useful,
:: but WITHOUT ANY WARRANTY; without even the implied warranty of
:: MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
:: GNU General Public License for more details.
:: You should have received a copy of the GNU General Public License
:: along with this program.  If not, see <http://www.gnu.org/licenses/>.

::  Authors:
::    cof: [François Corthay](francois.corthay@hevs.ch)
::    guo: [Oliver A. Gubler](oliver.gubler@hevs.ch)
:: Changelog:
::   17.1115 : guo :
::     * NEW : create backup in scratch folder before backup
::     * NEW: automatically update lab files
::     * UPDATE: replace some ELN_chrono with %DESIGN_NAME%
::   17.0918 : guo :
::     * fix typos with modeslim
::   17.0914 : guo :
::     * update libraries path to new server folder structure
::   17.0217 : guo :
::     * update ModelSim path to new version
::     * BASE_DIR and DESIGN_NAME can now be passed as parameters
::   16.0920 : guo :
::     * correct detection of Windows version for scratch dir
::     * fix deleting *.wlf files in nonexisting path
::   16.0531 : guo :
::     * add path for new HDL-Designer/Modelsim location
::     * add further Libero support
::   16.0323 : guo
::     * add repalcement of \ to / for ModelSim to HEI_LIBS_DIR
::     * prepare for Vivado support

:: ----------------------------------------------------------------------------
::
SETLOCAL EnableExtensions EnableDelayedExpansion
set VERSION=17.1115_ElN_chrono
set NAME=HEI EDA Launch Script (HELS) v.%VERSION%
echo %NAME%
echo.

:: ----------------------------------------------------------------------------
:: Get parameters
set BASE_DIR=%~1
set DESIGN_NAME=%~2
:: in not passed as parameter, base dir is parent dir of script
if "%BASE_DIR%"=="" (
  set BASE_DIR=%CD%
)
:: if not passed as parameter, design name is name of script (without extension)
if "%DESIGN_NAME%"=="" (
  set DESIGN_NAME=%~n0
)

:: ----------------------------------------------------------------------------
:: Prepare scratch directory at C:\temp\eda\<username>\<designname>
for /f "tokens=4" %%x in ('ver') do set cmdver=%%x
set cmdver=%cmdver:Version =%
for /f "tokens=1,2,3* delims=." %%g in ("%cmdver%") do (
  set VERSION=%%g
)
IF %VERSION% LEQ 5 (
  echo Windows XP and older
  set SCRATCH_DIR=%USERPROFILE:C:\Documents and Settings=C:\temp\EDA%
) else (
  echo Windows Vista and newer
  set SCRATCH_DIR=%USERPROFILE:C:\Users=C:\temp\EDA%
)

:: ----------------------------------------------------------------------------
:: UPDATE
:: ----------------------------------------------------------------------------
:: first create a security copy
set BACKUP_DIR=%SCRATCH_DIR%\backup
set DESIGN_BACKUP_DIR=%BACKUP_DIR%\%DESIGN_NAME%
rmdir /S /Q %DESIGN_BACKUP_DIR%
mkdir %DESIGN_BACKUP_DIR%
xcopy /S /I /Y "%BASE_DIR%" "%DESIGN_BACKUP_DIR%"

echo Set objArgs = WScript.Arguments > _zipIt.vbs
echo InputFolder = objArgs(0) >> _zipIt.vbs
echo ZipFile = objArgs(1) >> _zipIt.vbs
echo 'Create empty ZIP file. >> _zipIt.vbs
echo CreateObject("Scripting.FileSystemObject").CreateTextFile(ZipFile, True).Write "PK" ^& Chr(5) ^& Chr(6) ^& String(18, vbNullChar) >> _zipIt.vbs
echo Set objShell = CreateObject("Shell.Application") >> _zipIt.vbs
echo Set source = objShell.NameSpace(InputFolder).Items >> _zipIt.vbs
echo objShell.NameSpace(ZipFile).CopyHere(source) >> _zipIt.vbs
echo 'Required! >> _zipIt.vbs
echo wScript.Sleep 3000 >> _zipIt.vbs

for /f "skip=1" %%x in ('wmic os get localdatetime') do if not defined TIMESTRING set TIMESTRING=%%x
set FRACTIONS=%TIMESTRING:*.=%
call set ISODATE=%%TIMESTRING:.%FRACTIONS%=%%
CScript _zipIt.vbs "%DESIGN_BACKUP_DIR%" "%BACKUP_DIR%\%DESIGN_NAME%_%ISODATE%.zip"

del _zipIt.vbs

:: ----------------------------------------------------------------------------
:: then update the design files

:: if it exist locally, delet it
del /s HEUS_%DESIGN_NAME%.bat

:: check at folder beside project folder, as used for local libraries
set HEUS_SCRIPT=HEUS_%DESIGN_NAME%.bat
if not exist !HEUS_SCRIPT! (
  :: check on server, as used for SI labs
  set HEUS_SCRIPT=R:\SYND\Ele_2131\ELN\Labs\ELN_chrono\%HEUS_SCRIPT%
  if not exist !HEUS_SCRIPT!\ (
    echo ERROR: No valid update script found: please verify your project setup.
    pause
    exit
  )
)
echo Update %DESIGN_NAME% files to "%BASE_DIR%" with !HEUS_SCRIPT!
echo.
::call "!HEUS_SCRIPT!" "%BASE_DIR%"

:: ----------------------------------------------------------------------------
:: SYSTEM SETUP
:: ----------------------------------------------------------------------------
:: Define environment variables, manual section

:: Set the FPGA manufacturer toolchain
:: Available options are:
::   Xilinx-ISE
::   Xilinx-Vivado
::   Microsemi
set MANUFACTURER=Xilinx-ISE

:: Select if Synplify will be used
::   uncomment following line when Synplify is used
::set SYNPLIFY=

echo Setting up project %DESIGN_NAME% at %BASE_DIR% for %Manufacturer%
echo.
:: ----------------------------------------------------------------------------
:: Define environment variables, automatic section

:: set HDL-Designer internal variables
set HDS_PROJECT_DIR=%BASE_DIR%\Prefs
set HDS_LIBS=%HDS_PROJECT_DIR%\%DESIGN_NAME%.hdp
if not exist !HDS_LIBS! (
  echo ERROR: '!HDS_LIBS!' not found.
  pause
  exit
)
:: HDS_PREFS is only for pre-2003.1 user preference files
::set HDS_PREFS=%BASE_DIR%\Prefs\hds.hdp
:: location of hds_user directory, might be moved to a common place for students
set HDS_USER_HOME=%HDS_PROJECT_DIR%\hds_user
::set HDS_TEAM_HOME=%BASE_DIR%\Prefs &:: might be moved elsewhere
:: Specifies alternative location for the .cache file directory.
:: if pointed to an unexisting folder, no cache files will be generated
set HDS_CACHE_DIR=%BASE_DIR%\cache
:: Disable usage of .cache.dat
set HDS_TRUST_CACHE=0
:: license location
::LM_LICENSE_FILE=27001@mentorlm.hevs.ch

echo Setting up HDL-Designer with the preferences from
echo   '!HDS_LIBS!'
echo and user settings from
echo   '!HDS_USER_HOME!'
echo.

:: set existing tool installation paths
echo.

:: set and verify tool installation paths
set HDS_HOME=C:\eda\MentorGraphics\HDS
if not exist !HDS_HOME!\ (
  set HDS_HOME=C:\eda\HDS
  if not exist !HDS_HOME!\ (
    echo ERROR: No valid installation of HDL-Designer found: please verify your HDS_HOME settings.
    pause
    exit
  )
)
echo Found HDL-Designer      at !HDS_HOME!

set MODELSIM_HOME=C:\eda\MentorGraphics\modelsim\win64
if not exist !MODELSIM_HOME!\ (
  set MODELSIM_HOME=C:\eda\Modelsim\win32
  if not exist !MODELSIM_HOME!\ (
    echo ERROR: No valid installation of ModelSim found.
    pause
    exit
  )
)
echo Found ModelSim          at !MODELSIM_HOME!

if !MANUFACTURER!==Microsemi (
  set LIBERO_HOME=C:\eda\Microsemi\Libero_v11.0
  if not exist !LIBERO_HOME!\ (
    set LIBERO_HOME=C:\eda\Microsemi\Libero_v11.0
    if not exist !LIBERO_HOME!\ (
      echo ERROR: No valid installation of Libero found.
      pause
      exit
    )
  )
  echo Found Libero            at !LIBERO_HOME!
)

if !MANUFACTURER!==Xilinx-ISE (
  set ISE_HOME=C:\eda\Xilinx\ISE_DS\ISE\bin\nt
  if not exist !ISE_HOME!\ (
    set ISE_HOME=C:\eda\Xilinx\14.5\ISE_DS\ISE\bin\nt64
    if not exist !ISE_HOME!\ (
      set ISE_HOME=C:\eda\Xilinx\12.1\ISE_DS\ISE\bin\nt64
      if not exist !ISE_HOME!\ (
        echo ERROR: No valid installation of ISE found.
        pause
        exit
      )
    )
  )
  echo Found Xilinx ISE        at !ISE_HOME!
)

if !MANUFACTURER!==Xilinx-Vivado (
  set XILINX_VIVADO=C:\eda\Xilinx\Vivado\2014.4
  if not exist !XILINX_VIVADO!\ (
    echo ERROR: No valid installation of Vivado found.
    pause
    exit
  )
  echo Found Xilinx Vivado     at !XILINX_VIVADO!
)

if defined !SYNPLIFY! (
  set SYNPLIFY_HOME=C:\eda\Synopsys\fpga_J-2014.09-SP1\bin
  if not exist !SYNPLIFY_HOME!\ (
    echo ERROR: No valid installation of Synplify found.
    pause
    exit
  )
  echo Found Synplify          at !SYNPLIFY_HOME!
)

:: set existing library installation paths
:: check at folder beside project folder, as used for local libraries
set HEI_LIBS_DIR=%BASE_DIR%\..\libs
if not exist !HEI_LIBS_DIR!\ (
  :: check at folder one level above project folder, as used on svn for boards libraries
  set HEI_LIBS_DIR=%BASE_DIR%\..\..\libs
  if not exist !HEI_LIBS_DIR!\ (
    :: check on server, as used for ET labs
    set HEI_LIBS_DIR=R:\ETE\ElN_8215\Labs\Libraries\
    if not exist !HEI_LIBS_DIR!\ (
      :: check on server, as used for SI labs
      set HEI_LIBS_DIR=R:\SYND\Ele_2131\ELN\Labs\Libraries\
      if not exist !HEI_LIBS_DIR!\ (
        echo ERROR: No valid libraries found: please verify your project setup.
        pause
        exit
      )
    )
  )
)
:: replace all \ by / for ModelSim
set HEI_LIBS_DIR=!HEI_LIBS_DIR:\=/!
echo Found HEI Libs          at !HEI_LIBS_DIR!

set SIMULATION_DIR=%BASE_DIR:\=/%/Simulation
if not exist !SIMULATION_DIR!\ (
  echo ERROR: No valid Simulation directory found: please verify your project setup.
  pause
  exit
)
echo Found Simulation        at %SIMULATION_DIR%

set DESIGN_SCRATCH_DIR=%SCRATCH_DIR%\%DESIGN_NAME%

set HDS_LIB_BOARD=%BASE_DIR%\Board
set HDS_CONCAT_DIR=%HDS_LIB_BOARD%\concat

set MODELSIM_WORK_DIR=%DESIGN_NAME%_test\sim
set MODELSIM_PROJECT_WORK_DIR=%BASE_DIR%\%MODELSIM_WORK_DIR%
set MODELSIM_SCRATCH_WORK_DIR=%DESIGN_SCRATCH_DIR%\%MODELSIM_WORK_DIR%

set ISE_WORK_DIR=Board\ise
set ISE_PROJECT_WORK_DIR=%BASE_DIR%\%ISE_WORK_DIR%
set ISE_SCRATCH_WORK_DIR=%DESIGN_SCRATCH_DIR%\%ISE_WORK_DIR%

set VIVADO_WORK_DIR=Board\vivado
set VIVADO_PROJECT_WORK_DIR=%BASE_DIR%\%ISE_WORK_DIR%
set VIVADO_SCRATCH_WORK_DIR=%DESIGN_SCRATCH_DIR%\%VIVADO_WORK_DIR%

set SYNPLIFY_WORK_DIR=Board\synplify
set SYNPLIFY_PROJECT_WORK_DIR=%BASE_DIR%\%SYNPLIFY_WORK_DIR%
set SYNPLIFY_SCRATCH_WORK_DIR=%DESIGN_SCRATCH_DIR%\%SYNPLIFY_WORK_DIR%

set LIBERO_WORK_DIR=Board\libero
set LIBERO_IMPL_DIR=designer\impl1
set LIBERO_SYNT_DIR=synthesis
set LIBERO_PRJX_FILE=%DESIGN_NAME%.prjx
set LIBERO_IDEDES_FILE=FPGA_%DESIGN_NAME%.ide_des
set LIBERO_PROJECT_WORK_DIR=%BASE_DIR%\%LIBERO_WORK_DIR%
set LIBERO_PROJECT_PRJX=%LIBERO_PROJECT_WORK_DIR%\%LIBERO_PRJX_FILE%
set LIBERO_PROJECT_IMPL=%LIBERO_PROJECT_WORK_DIR%\%LIBERO_IMPL_DIR%
set LIBERO_PROJECT_SYNT=%LIBERO_PROJECT_WORK_DIR%\%LIBERO_SYNT_DIR%
set LIBERO_PROJECT_IDEDES_FILE=%LIBERO_PROJECT_IMPL%\%LIBERO_IDEDES_FILE%
set LIBERO_SCRATCH_WORK_DIR=%DESIGN_SCRATCH_DIR%\%LIBERO_WORK_DIR%
set LIBERO_SCRATCH_PRJX=%LIBERO_SCRATCH_WORK_DIR%\%LIBERO_PRJX_FILE%
set LIBERO_SCRATCH_IMPL=%LIBERO_SCRATCH_WORK_DIR%\%LIBERO_IMPL_DIR%
set LIBERO_SCRATCH_SYNT=%LIBERO_SCRATCH_WORK_DIR%\%LIBERO_SYNT_DIR%
set LIBERO_SCRATCH_IDEDES_FILE=%LIBERO_SCRATCH_IMPL%\%LIBERO_IDEDES_FILE%

:: ----------------------------------------------------------------------------
:: PRE-PROCESSING
:: ----------------------------------------------------------------------------
:: Copy files to scratch directory
echo.
echo Copying place and route files to scratch directory: %DESIGN_SCRATCH_DIR%
rmdir /S /Q "%DESIGN_SCRATCH_DIR%"
mkdir "%DESIGN_SCRATCH_DIR%"
if !MANUFACTURER!==Xilinx-ISE (
  xcopy /S /I /Y /Q "%ISE_PROJECT_WORK_DIR%" "%ISE_SCRATCH_WORK_DIR%"
)
if !MANUFACTURER!==Xilinx-Vivado (
::TBV
::  xcopy /S /I /Y /Q "%VIVADO_PROJECT_WORK_DIR%" "%VIVADO_SCRATCH_WORK_DIR%"
)
if !MANUFACTURER!==Microsemi (
  xcopy /S /I /Y /Q "%LIBERO_PROJECT_WORK_DIR%" "%LIBERO_SCRATCH_WORK_DIR%"
)
:: ModelSim: copy whole work folder to scratch dir
xcopy /S /I /Y /Q "%MODELSIM_PROJECT_WORK_DIR%" "%MODELSIM_SCRATCH_WORK_DIR%"

:: ----------------------------------------------------------------------------
:: Delete intermediate files
echo.
echo Deleting automatically generated files in: %BASE_DIR%
:: following line obsolete when cache usage disabled
del /s %BASE_DIR%\.cache.dat
del /s %BASE_DIR%\*.bak %BASE_DIR%\*.lck
del /s %BASE_DIR%\*_entity.vhd %BASE_DIR%\*_struct.vhd %BASE_DIR%\*_fsm.vhd
del /s %BASE_DIR%\*.vhg

:: ----------------------------------------------------------------------------
:: PROCESS
:: ----------------------------------------------------------------------------
:: Launch Application
echo.
echo Launching programs
echo Waiting until programs finished...
echo WARNING: DO NOT CLOSE THIS WINDOW!
%windir%\system32\cmd.exe /c start /wait !HDS_HOME!\bin\hdldesigner.exe
echo Programs finished

:: ----------------------------------------------------------------------------
:: POST-PROCESSING
:: ----------------------------------------------------------------------------
:: Copy files back from the scratch directory
echo.
echo Copying and overwrite place and route files to user directory
if !MANUFACTURER!==Xilinx-ISE (
  xcopy /Y /Q %ISE_SCRATCH_WORK_DIR%\%DESIGN_NAME%.xise %ISE_PROJECT_WORK_DIR%\
  xcopy /Y /Q %ISE_SCRATCH_WORK_DIR%\*.bit %ISE_PROJECT_WORK_DIR%\
  xcopy /Y /Q %ISE_SCRATCH_WORK_DIR%\*.mcs %ISE_PROJECT_WORK_DIR%\
)
if !MANUFACTURER!==Xilinx-Vivado (
::TBV
::  xcopy /Y /Q %ISE_SCRATCH_WORK_DIR%\%DESIGN_NAME%.xpr %ISE_PROJECT_WORK_DIR%\
)
if !MANUFACTURER!==Microsemi (
  :: libero project file
  xcopy /Y /Q %LIBERO_SCRATCH_PRJX% %LIBERO_WORK_DIR%\
  :: project database
  xcopy /Y /Q %LIBERO_SCRATCH_IMPL%\FPGA_%DESIGN_NAME%.adb %LIBERO_PROJECT_IMPL%\
  :: programming file
  xcopy /Y /Q %LIBERO_SCRATCH_IMPL%\FPGA_%DESIGN_NAME%.pdb %LIBERO_PROJECT_IMPL%\
  :: designer file
  xcopy /Y /Q %LIBERO_SCRATCH_IDEDES_FILE% %LIBERO_PROJECT_IMPL%\
  :: synplify project file
  xcopy /Y /Q %LIBERO_SCRATCH_SYNT%\FPGA_%DESIGN_NAME%_syn.prj %LIBERO_PROJECT_SYNT%\
  :: IDE_DES
  xcopy /Y /Q %LIBERO_SCRATCH_IMPL%\FPGA_%DESIGN_NAME%.ide_des %LIBERO_USER_IMPL%\
  :: netlist
:: xcopy /Y /Q %LIBERO_SCRATCH_SYNT%\FPGA_%DESIGN_NAME%.edn %LIBERO_PROJECT_SYNT%\
)
:: ModelSim: copy whole directory back, delete unwanted files
xcopy /Y /Q "%MODELSIM_SCRATCH_WORK_DIR%\" "%MODLESIM_PROJECT_WORK_DIR%"
del /s %MODELSIM_PROJECT_WORK_DIR%\*.wlf

:: ----------------------------------------------------------------------------
:: QUIT
echo Finished... YOU CAN CLOSE THIS WINDOW NOW!
::pause

ENDLOCAL
