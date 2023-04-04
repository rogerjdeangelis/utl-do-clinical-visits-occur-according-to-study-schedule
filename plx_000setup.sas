/*
Set up a SAS enviroment to run all your project code

A macro is given that along with the zip archive that provides a
SAS environment for running all your projects programs.

github
https://tinyurl.com/24phumhe
https://github.com/rogerjdeangelis/utl-set-up-a-SAS-enviroment-to-run-all-your-project-code
*/

%macro plx_000setup/des="Set up a SAS enviroment to run all your project code";

/**************************************************************************************************************************/
/*                                                                                                                        */
/*  x "cd d:/pharma/plx"; %let pgm=plx_000setup;                                                                          */
/*                                                                                                                        */
/*  STUDY TOKEN            : plx (all files emails .. will have prefix plx. plx will not be reused)                       */
/*                                                                                                                        */
/*  STUDY                  : Pilot_R_Pharma Study                                                                         */
/*                                                                                                                        */
/*  OPSYS                  : Win 10 64bit workstation                                                                     */
/*                                                                                                                        */
/*  PURPOSE                : Set up a SAS enviroment to run all your project code                                         */
/*                                                                                                                        */
/*  LANGUAGE               : SAS 9.4M7 64bit and R 4.12 64bit                                                             */
/*                                                                                                                        */
/*  OPSYS;                 : Win 10 64bit workstation                                                                     */
/*                                                                                                                        */
/*  Programming Path       : d:/phrama/plx/sas                                                                            */
/*                                                                                                                        */
/*  Data Path              : d:/phrama/plx/sdm                                                                            */
/*                                                                                                                        */
/*  AUTOCALL LIBRARY       : d:/pharma/plx/oto                                                                            */
/*                                                                                                                        */
/*  PROGRAM LOG            : d:/pharma/plx/log/plx_010trg.log                                                             */
/*                                                                                                                        */
/*  PROGRAM LIST           : d:/pharma/plx/lst/plx_010trg.lst                                                             */
/*                                                                                                                        */
/*  REQUESTOR              : data management                                                                              */
/*                                                                                                                        */
/*  PRODUCTION PROGRAMMER  : rdeangelis@gmail.com                                                                         */
/*                                                                                                                        */
/*  VERSIONING             : .d:/pharma/plx/ver/plx_010mpr[datetime].sas                                                  */
/*                                                                                                                        */
/*  VALIDATED              : No                                                                                           */
/*                                                                                                                        */
/*  RISK LEVEL             : High                                                                                         */
/*                                                                                                                        */
/*  VALIDATION PROGRAM     : No                                                                                           */
/*                                                                                                                        */
/*  ISSUE LOG              : d:/pharma/plx/oto \xls\\plx_isu.xlsx                                                         */
/*                                                                                                                        */
/*  DEPENDENCIES           : R/Python (sas tools package)                                                                 */
/*                                                                                                                        */
/*  VALIDATION PROGRAMMER  : N/A                                                                                          */
/*                                                                                                                        */
/*  DOCUMENTATION          : Within this program                                                                          */
/*                                                                                                                        */
/*  R/PYTHON DEPENDENCIES : R readxl                                                                                      */
/*                                                                                                                        */
/*  EXTERNAL MACROS       : d:/pharma/plx/oto                                                                             */
/*                                                                                                                        */
/*  INTERNAL MACROS       : None                                                                                          */
/*                                                                                                                        */
/*                                                                                                                        */
/**************************************************************************************************************************/
/*                                                                                                                        */
/*   _   _ ___  __ _  __ _  ___                                                                                           */
/*  | | | / __|/ _` |/ _` |/ _ \                                                                                          */
/*  | |_| \__ \ (_| | (_| |  __/                                                                                          */
/*   \__,_|___/\__,_|\__, |\___|                                                                                          */
/*                   |___/                                                                                                */
/*                                                                                                                        */
/*   What you have to do before you submit code                                                                           */
/*                                                                                                                        */
/*   1. Download and unzip pharma.7z from github should yeild d:/pharma/plx                                               */
/*   2. Next change directory to use Drive, d:/pharma/plx                                                                 */
/*   3. Copy d:/plx/sas/plx_000setup.sas to classic editor (predates the Enhanced Editor)                                 */
/*   4. Run d:/phrama/sas/plx_000setup.sas                                                                                */
/*                                                                                                                        */
/*   _ __  _ __ ___   ___ ___  ___ ___                                                                                    */
/*  | `_ \| `__/ _ \ / __/ _ \/ __/ __|                                                                                   */
/*  | |_) | | | (_) | (_|  __/\__ \__ \                                                                                   */
/*  | .__/|_|  \___/ \___\___||___/___/                                                                                   */
/*  |_|                                                                                                                   */
/*                                                                                                                        */
/*   1. Include d:/phrama/plx/sas/plx_000setup.sas  macro in classic editor (predats enhanced editor)                     */
/*   1. Set inline ods symbols and characters as global mcro variables.                                                   */
/*   2. Create macro variable with project token, "PLX" ,using the first three characters of the macro name               */
/*   3. Check that SAS is running in d:/phrama/plx                                                                        */
/*   4. Assign auotocall library with all the tools you downloaded from github in d:/phrama/plx/oto                       */
/*   3. Gently stop SAS execution if not in d:/pharma/plx                                                                 */
/*   6. Create folder structure. This will only create the folder structure if it does not exist.                         */
/*   9. Assign librefs and sas options                                                                                    */
/*  10. Echo back SAS options and librefs into SAS log                                                                    */
/*  _ _ _               __                                                                                                */
/* | (_) |__  _ __ ___ / _|___                                                                                            */
/* | | | `_ \| `__/ _ \ |_/ __|                                                                                           */
/* | | | |_) | | |  __/  _\__ \                                                                                           */
/* |_|_|_.__/|_|  \___|_| |___/                                                                                           */
/*                                                                                                                        */
/*                   Library                                                                                              */
/* assigned          Name      Pathname                          Read-only?                                               */
/* ------------------------------------------------------------------------                                               */
/* Libname Assigned  PLX       d:\pharma\plx                     no                                                       */
/* Libname Assigned  PLXFMT    d:\pharma\plx\fmt                 no                                                       */
/* Libname Assigned  PLXMTA    d:\pharma\plx\mta                 no                                                       */
/* Libname Assigned  PLXRAW    d:\pharma\plx\raw                 no                                                       */
/* Libname Assigned  PLXSDM    d:\pharma\plx\sdm                 no                                                       */
/*                                                                                                                        */
/*                                                                                                                        */
/* options fmtseardh=( PLXfmt.PLXfmt work.formats)                                                                        */
/* sasautos = d:\pharma\plx\oto                                                                                           */
/*                                                                                                                        */
/*   _                   _                                                                                                */
/*  (_)_ __  _ __  _   _| |_                                                                                              */
/*  | | `_ \| `_ \| | | | __|                                                                                             */
/*  | | | | | |_) | |_| | |_                                                                                              */
/*  |_|_| |_| .__/ \__,_|\__|                                                                                             */
/*          |_|                                                                                                           */
/*  All inputs, outputs, tools and programs are in github plx.7z                                                          */
/*  After unzipping plx.7z from github                                                                                    */
/*                                                                                                                        */
/*                                                                                                                        */
/*   D:\PHARMA\PLX                                                                                                        */
/*       +---b64                                                                                                          */
/*       +---csv                                                                                                          */
/*       +---doc                                                                                                          */
/*       +---fmt                                                                                                          */
/*       +---log                                                                                                          */
/*       +---lst                                                                                                          */
/*       +---msg                                                                                                          */
/*       +---mta                                                                                                          */
/*       +---oto                                                                                                          */
/*       |       array.sas                                                                                                */
/*       |       arraydelete.sas                                                                                          */
/*       |       debug.sas                                                                                                */
/*       |       ....                                                                                                     */
/*       |       utl_xlslan100.sas                                                                                        */
/*       +---pdf                                                                                                          */
/*       +---png                                                                                                          */
/*       +---ppt                                                                                                          */
/*       +---raw                                                                                                          */
/*       |       visitcrf.sas7bdat                                                                                        */
/*       +---rtf                                                                                                          */
/*       +---sas                                                                                                          */
/*       |       plx_000setup.sas  ==> This macro                                                                         */
/*       |       plx_020vis.sas    ==> Run this as an examle code                                                         */
/*       +---sd1                                                                                                          */
/*       +---sdm                                                                                                          */
/*       +---tmp                                                                                                          */
/*       +---txt                                                                                                          */
/*       +---vdo                                                                                                          */
/*       +---ver                                                                                                          */
/*       +---xls                                                                                                          */
/*       |       plx_020Schedule.xlsx                                                                                     */
/*       +---xml                                                                                                          */
/*       +---xpt                                                                                                          */
/*       \---zip                                                                                                          */
/*               _               _                                                                                        */
/*    ___  _   _| |_ _ __  _   _| |_                                                                                      */
/*   / _ \| | | | __| `_ \| | | | __|                                                                                     */
/*  | (_) | |_| | |_| |_) | |_| | |_                                                                                      */
/*   \___/ \__,_|\__| .__/ \__,_|\__|                                                                                     */
/*                  |_|                                                                                                   */
/*     _ _ _               __                                                                                             */
/*    | (_) |__  _ __ ___ / _|___                                                                                         */
/*    | | | `_ \| `__/ _ \ |_/ __|                                                                                        */
/*    | | | |_) | | |  __/  _\__ \                                                                                        */
/*    |_|_|_.__/|_|  \___|_| |___/                                                                                        */
/*                                                                                                                        */
/*                     Library                                                                                            */
/*    assigned          Name      Pathname                          Read-only?                                            */
/*    ------------------------------------------------------------------------                                            */
/*    Libname Assigned  PLX       d:\pharma\plx                     no                                                    */
/*    Libname Assigned  PLXFMT    d:\pharma\plx\fmt                 no                                                    */
/*    Libname Assigned  PLXMTA    d:\pharma\plx\mta                 no                                                    */
/*    Libname Assigned  PLXRAW    d:\pharma\plx\raw                 no                                                    */
/*    Libname Assigned  PLXSDM    d:\pharma\plx\sdm                 no                                                    */
/*                                                                                                                        */
/*                 _   _                                                                                                  */
/*      ___  _ __ | |_(_) ___  _ __  ___                                                                                  */
/*     / _ \| `_ \| __| |/ _ \| `_ \/ __|                                                                                 */
/*    | (_) | |_) | |_| | (_) | | | \__ \                                                                                 */
/*     \___/| .__/ \__|_|\___/|_| |_|___/                                                                                 */
/*          |_|                                                                                                           */
/*                                                                                                                        */
/*    options fmtseardh=( PLXfmt.PLXfmt work.formats)                                                                     */
/*    sasautos = (d:\pharma\plx\oto sasautos)                                                                             */
/*                                                                                                                        */
/**************************************************************************************************************************/
/*                                                                                                                        */
/*                                                                                                                        */
/*  Version History                                                                                                       */
/*                                                                                                                        */
/*  Version     Date             Programmer                     Description                                               */
/*  -------     ---------        ----------                     -----------                                               */
/*   1.0        04APR2023        rogerjdeangelis@gmail.com      creation                                                  */
/*                                                                                                                        */
/**************************************************************************************************************************/


/**************************************************************************************************************************/
/*                                                                                                                        */
/*  You do not need to do this if you download pharma.7z and unzip it.                                                    */
/*                   _           _           _                                                                            */
/*   _ __  _ __ ___ (_) ___  ___| |_   _ __ | |_  __                                                                      */
/*  | `_ \| `__/ _ \| |/ _ \/ __| __| | `_ \| \ \/ /                                                                      */
/*  | |_) | | | (_) | |  __/ (__| |_  | |_) | |>  <                                                                       */
/*  | .__/|_|  \___// |\___|\___|\__| | .__/|_/_/\_\                                                                      */
/*  |_|           |__/                |_|                                                                                 */
/*                                                                                                                        */
/*  What you have to do before you submit code  x "cd d:/pharma/plx"                                                      */
/*                                                                                                                        */
/*  1. You need to pick a three letter acronym for the project. I will use plx for documentation reasons                  */
/*  2. Make sure you are in the path that you want for the project. For simplicity I wii use Drive, d:\pharma             */
/*  3. Create d:/pharma/plx                                                                                               */
/*  4. Create d:/pharma/plx/oto                                                                                           */
/*  6. Copy plx_000setup.sas from github to d:/pharma/plx/oto/plx_000setup.sas into d:/pharma/plx/sas/rlx_000setup.sas.   */
/*  7. Make d:/pharma/plx the present working directory(PWD), Command x "cd d:/pharma/plx"                                */
/*  8. Download and unzip oto.7z from github and copy macros to d:/pharma/plx/oto                                         */
/*  9. The first three characters of setup macro must match the last folder in the path ie plx                            */
/*                                                                                                                        */
/**************************************************************************************************************************/

/*--- usefull ods special characters                                             ----*/
  %global
       ods_mu
       ods_ge
       ods_dg
       ods_ul
       ods_space
       ods_le
       ods_ne
 ;
/*               _           _     _        _
 _ __  _ __ ___ (_) ___  ___| |_  | |_ ___ | | _____ _ __
| `_ \| `__/ _ \| |/ _ \/ __| __| | __/ _ \| |/ / _ \ `_ \
| |_) | | | (_) | |  __/ (__| |_  | || (_) |   <  __/ | | |
| .__/|_|  \___// |\___|\___|\__|  \__\___/|_|\_\___|_| |_|
|_|           |__/
*/

%let tok = %upcase(%substr(%sysmexecname(1),1,3));

%put The project token is %qlowcase(%substr(%sysmexecname(1),1,3)) ;

/*        _                                       _
__      _| |__   ___ _ __ ___    __ _ _ __ ___   (_)
\ \ /\ / / `_ \ / _ \ `__/ _ \  / _` | `_ ` _ \  | |
 \ V  V /| | | |  __/ | |  __/ | (_| | | | | | | | |
  \_/\_/ |_| |_|\___|_|  \___|  \__,_|_| |_| |_| |_|

*/

data _null_;

  length curDir $255;

      rc=filename("dummy",".");
      curDir=pathname("dummy");
      putlog "Current directory " curDir;
      call symputx("curDir",curDir);

      chkTok = substr(curDir,length(curDir)-2,3);
      call symputx('chkTok',upcase(chkTok));

run;quit;

/*---- Do the first 3 characters of macro name equal the last 3 of path           ----*/

%put Macro nname prefix= &tok  must match Last three letters  of path = &chkTok ;

/**************************************************************************************************************************/
/*                                                                                                                        */
/* Before you can use the autocall library you need to create d:/pharma/plx/oto download oto.7z from github               */
/* and copy the autocall macroms to ibrary you need to create d:/pharma/plx/oto vy downloading oto.7z from fit hub        */
/*                                                                                                                        */
/* The present working directory must agree with the first three characters of the macro name (plx here )                 */
/* The first three letters of this macro is plx so the working directory must be .root/plx                                */
/*                                                                                                                        */
/**************************************************************************************************************************/

   Options SASAUTOS=(
     "&curDir\oto"
     "c:\Program Files\SASHome\SASFoundation\9.4\core\sasmacro"
     "c:\Program Files\SASHome\SASFoundation\9.4\stat\sasmacro"
     "c:\Program Files\SASHome\SASFoundation\9.4\aacomp\sasmacro"
     "c:\Program Files\SASHome\SASFoundation\9.4\accelmva\sasmacro"
     "c:\Program Files\SASHome\SASFoundation\9.4\access\sasmacro"
     "c:\Program Files\SASHome\SASFoundation\9.4\assist\sasmacro"
     "c:\Program Files\SASHome\SASFoundation\9.4\dmscore\sasmacro"
     "c:\Program Files\SASHome\SASFoundation\9.4\eis\sasmacro"
     "c:\Program Files\SASHome\SASFoundation\9.4\ets\sasmacro"
     "c:\Program Files\SASHome\SASFoundation\9.4\gis\sasmacro"
     "c:\Program Files\SASHome\SASFoundation\9.4\graph\sasmacro"
     "c:\Program Files\SASHome\SASFoundation\9.4\hps\sasmacro"
     "c:\Program Files\SASHome\SASFoundation\9.4\iml\sasmacro"
     "c:\Program Files\SASHome\SASFoundation\9.4\inttech\sasmacro"
     "c:\Program Files\SASHome\SASFoundation\9.4\or\sasmacro"
      );

   run;quit;

/*---- Check that autocall library is assigned                                    ----*/

%put %sysfunc(getoption(sasautos));


/*****************************************************************************************************************************/
/*                                                                                                                           */
/* Autocall libraru                                                                                                          */
/*                                                                                                                           */
/* x "cd d:/pharma/plx"                                                                                                      */
/* c:\Program Files\SASHome\SASFoundation\9.4\core\sasmacro  c:\Program Files\SASHome\SASFoundation\9.4\stat\sasmacro        */
/* c:\Program Files\SASHome\SASFoundation\9.4\aacomp\sasmacro  c:\Program Files\SASHome\SASFoundation\9.4\accelmva\sasmacro  */
/* c:\Program Files\SASHome\SASFoundation\9.4\access\sasmacro  c:\Program Files\SASHome\SASFoundation\9.4\assist\sasmacro    */
/* c:\Program Files\SASHome\SASFoundation\9.4\dmscore\sasmacro c:\Program Files\SASHome\SASFoundation\9.4\eis\sasmacro       */
/* c:\Program Files\SASHome\SASFoundation\9.4\ets\sasmacro     c:\Program Files\SASHome\SASFoundation\9.4\gis\sasmacro       */
/* c:\Program Files\SASHome\SASFoundation\9.4\graph\sasmacro   c:\Program Files\SASHome\SASFoundation\9.4\hps\sasmacro       */
/* c:\Program F iles\SASHome\SASFoundation\9.4\iml\sasmacro    c:\Program Files\SASHome\SASFoundation\9.4\inttech\sasmacro   */
/* c:\Program Files\SASHome\SASFoundation\9.4\or\sasmacro      x "cd d:/pharma/plx" )                                        */
/*                                                                                                                           */
/*****************************************************************************************************************************/

/*---- Stop program it not in the current path                                    ----*/
%if "&tok" ^= "&chkTok" %then %do;
   %stop_submission;
%end;

/*                   _          __       _     _
  ___ _ __ ___  __ _| |_ ___   / _| ___ | | __| | ___ _ __ ___
 / __| `__/ _ \/ _` | __/ _ \ | |_ / _ \| |/ _` |/ _ \ `__/ __|
| (__| | |  __/ (_| | ||  __/ |  _| (_) | | (_| |  __/ |  \__ \
 \___|_|  \___|\__,_|\__\___| |_|  \___/|_|\__,_|\___|_|  |___/

*/

options fmtsearch=( &tok.fmt.formats.&tok.fmt work.formats);

%utlopts;

%array(_dirs,values=b64 csv doc fmt log lst msg mta oto pdf png ppt raw rtf sd1 sas tmp txt vdo ver xls xml xpt zip);

data _null_;
   %do_over(_dirs,phrase=%str(
      length root $200 dir $300;
      root="&curDir";
      dir="?";
      rc=dcreate(dir,root);
      putlog  "Folder &curDir/? is now available";
      ));
run;quit;

/*             _               _ _ _
  __ _ ___ ___(_) __ _ _ __   | (_) |__  _ __   __ _ _ __ ___   ___  ___
 / _` / __/ __| |/ _` | `_ \  | | | `_ \| `_ \ / _` | `_ ` _ \ / _ \/ __|
| (_| \__ \__ \ | (_| | | | | | | | |_) | | | | (_| | | | | | |  __/\__ \
 \__,_|___/___/_|\__, |_| |_| |_|_|_.__/|_| |_|\__,_|_| |_| |_|\___||___/
                 |___/
*/

libname &tok.raw   "&curDir./raw"  ;
libname &tok.sdm   "&curDir./sdm"  ;
libname &tok.fmt   "&curDir./fmt"  ;
libname &tok.mta   "&curDir./mta"  ;
libname &tok       "&curDir."  ;

/*         _       _       _ _              _
  ___   __| |___  (_)_ __ | (_)_ __   ___  | |_ __ _  __ _ ___
 / _ \ / _` / __| | | `_ \| | | `_ \ / _ \ | __/ _` |/ _` / __|
| (_) | (_| \__ \ | | | | | | | | | |  __/ | || (_| | (_| \__ \
 \___/ \__,_|___/ |_|_| |_|_|_|_| |_|\___|  \__\__,_|\__, |___/
                                                     |___/
*/

%let ods_le = %str(^R/RTF'{\uc1\u8804\~}');          /* RTF character for less than or equal to     */
%let ods_ne = %str(^R/RTF'{\uc1\u8800\~}');          /* RTF character for not equal to              */
%let ods_ge = %str(^R/RTF'{\uc1\u8805\~}');          /* RTF character for greater than or equal to  */
%let ods_mu = %str(^R/RTF'{\uc1\u956\~}') ;          /* RTF character for Greek mu                  */
%let ods_dg = %str(^R/RTF'{\uc1\u176\~}');           /* RTF character for degree C                  */
%let ods_ul = %str(^R/RTF'{\brdrb\brdrs\brdrw19}');  /* RTF sequence for cell underline             */
%let ods_sp = %str(^R/RTF'\~');                      /* RTF non breaking space                      */

/*                         _     _ _ _
 _ __ ___ _ __   ___  _ __| |_  | (_) |__  _ __   __ _ _ __ ___   ___  ___
| `__/ _ \ `_ \ / _ \| `__| __| | | | `_ \| `_ \ / _` | `_ ` _ \ / _ \/ __|
| | |  __/ |_) | (_) | |  | |_  | | | |_) | | | | (_| | | | | | |  __/\__ \
|_|  \___| .__/ \___/|_|   \__| |_|_|_.__/|_| |_|\__,_|_| |_| |_|\___||___/
         |_|
*/

%utlfkil(%sysfunc(pathname(work))/tmp.txt);

proc printto print="%sysfunc(pathname(work))/tmp.txt";;run;quit;

proc sql;
  select
    distinct
     'Libname Assigned' as assigned
    ,libname    length=8
    ,path       length=32
    ,readonly   length=4
  from
    sashelp.vlibnam
  where
    upcase(libname) in ("&tok.RAW","&tok.MTA","&tok.FMT", "NAT", "&tok", "&tok.SDM", "&tok.RAW")
;quit;

proc printto;run;quit;

data _null_;
  infile "%sysfunc(pathname(work))/tmp.txt" end=eof;
  input;
  putlog _infile_;
  if eof then do;
    putlog // "options fmtseardh=( &tok.fmt.&tok.fmt work.formats)";
    putlog "sasautos = &curDir.\oto" ;
  end;
run;quit;

%utlopts;

%mend plx_000setup ;

%plx_000setup ;

/*              _
  ___ _ __   __| |
 / _ \ `_ \ / _` |
|  __/ | | | (_| |
 \___|_| |_|\__,_|

*/
