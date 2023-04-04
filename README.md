# utl-do-clinical-visits-occur-according-to-study-schedule
Do clinical visits occur according to study schedule? 
   /*                                                                                                                                   
                                                                                                                                        
   %let pgm=utl-do-clinical-visits-occur-according-to-study-schedule;                                                                   
                                                                                                                                        
   Do clinical visits occur according to study schedule?                                                                                
                                                                                                                                        
   Two macros and sample clinical data is provided                                                                                      
                                                                                                                                        
      1. Sets up the environment for all clinical study programs                                                                        
      2. Reports on clinical vists that are not on schedule. Do not occur in visit window.                                              
      3. Zip archive with all inputs, outputs, programs and tools pharma.7z                                                             
                                                                                                                                        
   */                                                                                                                                   
   /**************************************************************************************************************************/         
   /*                                                                                                                        */         
   /*  x "cd d:/pharma/plx"; %let pgm=plx_020vis;                                                                            */         
   /*                                                                                                                        */         
   /*  STUDY TOKEN            : plx (all files emails .. will have prefix plx. plx will not be reused)                       */         
   /*                                                                                                                        */         
   /*  STUDY                  : Pilot_R_Pharma Study (R package)                                                             */         
   /*                                                                                                                        */         
   /*  OPSYS                  : Win 10 64bit workstation                                                                     */         
   /*                                                                                                                        */         
   /*  PURPOSE                : Check if visits occured according to study schedule from data management                     */         
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
   /*  PROGRAM LOG            : d:/pharma/plx/log/plx_010vis.log                                                             */         
   /*                                                                                                                        */         
   /*  PROGRAM LIST           : d:/pharma/plx/lst/plx_010vis.lst                                                             */         
   /*                                                                                                                        */         
   /*  REQUESTOR              : data management                                                                              */         
   /*                                                                                                                        */         
   /*  PRODUCTION PROGRAMMER  : rdeangelis@gmail.com                                                                         */         
   /*                                                                                                                        */         
   /*  VERSIONING             : .d:/pharma/plx/ver/plx_010mpr[datetime].sas                                                  */         
   /*                                                                                                                        */         
   /*  VALIDATED              : No (risk medium)                                                                             */         
   /*                                                                                                                        */         
   /*  RISK LEVEL             : Medium                                                                                       */         
   /*                                                                                                                        */         
   /*  VALIDATION PROGRAM     : No                                                                                           */         
   /*                                                                                                                        */         
   /*  ISSUE LOG              : d:/pharma/plx/oto \xls\\plx_isu.xlsx                                                         */         
   /*                                                                                                                        */         
   /*  DEPENDENCIES           : R                                                                                            */         
   /*                                                                                                                        */         
   /*  VALIDATION PROGRAMMER  : Not assigned                                                                                 */         
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
   /*   _ __  _ __ ___   ___ ___  ___ ___                                                                                    */         
   /*  | `_ \| `__/ _ \ / __/ _ \/ __/ __|                                                                                   */         
   /*  | |_) | | | (_) | (_|  __/\__ \__ \                                                                                   */         
   /*  | .__/|_|  \___/ \___\___||___/___/                                                                                   */         
   /*  |_|                                                                                                                   */         
   /*                                                                                                                        */         
   /*                                                                                                                        */         
   /*  Process flow for creating SAS formats and tables from raw CSV files                                                   */         
   /*                                                                                                                        */         
   /*   1. You must chane directory to d:/pharma/plx.                                                                        */         
   /*   2. Run setup macro d:/pharma/plx/sas/plx_000setup.sas.                                                               */         
   /*   3. Run interative command line performance tools.                                                                    */         
   /*   4. Convert data management excel visit schedule to sas dataset.                                                      */         
   /*   5. Join external input raw data management vistCrf Visit Date page with data management schedule                     */         
   /*   6. Place actual study day (visit date in raw data) before, after or within completion window                         */         
   /*  _ _                 __                                                                                                */         
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
   /* options fmtseardh=( plxfmt.plxfmt work.formats)                                                                        */         
   /* sasautos = d:\pharma\plx\oto                                                                                           */         
   /*   _                   _                                                                                                */         
   /*  (_)_ __  _ __  _   _| |_                                                                                              */         
   /*  | | `_ \| `_ \| | | | __|                                                                                             */         
   /*  | | | | | |_) | |_| | |_                                                                                              */         
   /*  |_|_| |_| .__/ \__,_|\__|                                                                                             */         
   /*          |_|                                                                                                           */         
   /*                                                                                                                        */         
   /*   D:\PHARMA\PLX                                                                                                        */         
   /*     |                                                                                                                  */         
   /*     |   plx_020schedule.sas7bdat   ==> Output Report on clinical vists that are not on schedule.                       */         
   /*     +---b64                                                                                                            */         
   /*     +---csv                                                                                                            */         
   /*     +---doc                                                                                                            */         
   /*     +---fmt                                                                                                            */         
   /*     +---log                                                                                                            */         
   /*     +---lst                                                                                                            */         
   /*     +---msg                                                                                                            */         
   /*     +---mta                                                                                                            */         
   /*     +---oto                                                                                                            */         
   /*     |       array.sas                                                                                                  */         
   /*     |       arraydelete.sas                                                                                            */         
   /*     |       debug.sas                                                                                                  */         
   /*     |       ...                                                                                                        */         
   /*     |       utl_varlist.sas                                                                                            */         
   /*     |       utl_xlslan100.sas                                                                                          */         
   /*     |                                                                                                                  */         
   /*     +---pdf                                                                                                            */         
   /*     +---png                                                                                                            */         
   /*     +---ppt                                                                                                            */         
   /*     +---raw                                                                                                            */         
   /*     |       visitcrf.sas7bdat       ==> Data management provided visitCRF sas dataset (RAVE, Medidata...)              */         
   /*     +---rtf                                                                                                            */         
   /*     +---sas                                                                                                            */         
   /*     |   |   plx_000setup.sas                                                                                           */         
   /*     |   |   plx_010mpr.sas                                                                                             */         
   /*     |   |   plx_020vis.sas                                                                                             */         
   /*     |   |                                                                                                              */         
   /*     |   \---deprecated                                                                                                 */         
   /*     +---sd1                                                                                                            */         
   /*     +---sdm                                                                                                            */         
   /*     +---tmp                                                                                                            */         
   /*     +---txt                                                                                                            */         
   /*     +---vdo                                                                                                            */         
   /*     +---ver                                                                                                            */         
   /*     +---xls                                                                                                            */         
   /*     |       plx_020Schedule.xlsx   ==> Input Visit Schedule from data management                                       */         
   /*     |                                                                                                                  */         
   /*     +---xml                                                                                                            */         
   /*     +---xpt                                                                                                            */         
   /*     |       plx_020schedule.xpt    ==> Visit Schedule from data management in V5 export                                */         
   /*     |                                                                                                                  */         
   /*     \---zip                                                                                                            */         
   /*               _               _                                                                                        */         
   /*    ___  _   _| |_ _ __  _   _| |_                                                                                      */         
   /*   / _ \| | | | __| `_ \| | | | __|                                                                                     */         
   /*  | (_) | |_| | |_| |_) | |_| | |_                                                                                      */         
   /*   \___/ \__,_|\__| .__/ \__,_|\__|                                                                                     */         
   /*                  |_|                                                                                                   */         
   /*                                                                                                                        */         
   /*   D:\PHARMA\PLX                                                                                                        */         
   /*     |                                                                                                                  */         
   /*     +   plx_020schedule.sas7bdat   ==> Output Report on clinical vists that are not on schedule.                       */         
   /*                                                                                                                        */         
   /*                                                                                                                        */         
   /*   plx_020onSchedule 04APR2023:10:21:42                                                                                 */         
   /*                                                                                                                        */         
   /*                                         ACTUAL                                                                         */         
   /*                            SCHEDULE      STUDY                                                                         */         
   /*   USUBJID      VISIT        WINDOW         DAY  STATUS                                                                 */         
   /*                                                                                                                        */         
   /*   01-701-1015  WEEK 2       14-19           14  Visit on Schedule Window                                               */         
   /*   01-701-1015  WEEK 4       28-33           28  Visit on Schedule Window                                               */         
   /*   01-701-1015  WEEK 6       42-47           42  Visit on Schedule Window                                               */         
   /*   01-701-1015  WEEK 8       56-61           55  Visit was too Early            ==> Before completion window 55 < 56    */         
   /*   01-701-1015  WEEK 12      84-89           84  Visit on Schedule Window                                               */         
   /*   01-701-1015  WEEK 14 (T)  98-103          98  Visit on Schedule Window                                               */         
   /*   01-701-1015  WEEK 16      112-117        112  Visit on Schedule Window                                               */         
   /*   01-701-1015  WEEK 20      140-145        140  Visit on Schedule Window                                               */         
   /*   01-701-1015  WEEK 22 (T)  154-159        154  Visit on Schedule Window                                               */         
   /*   01-701-1015  WEEK 24      168-173        168  Visit on Schedule Window                                               */         
   /*   01-701-1015  WEEK 26      182-187        182  Visit on Schedule Window                                               */         
   /*                                                                                                                        */         
   /*   01-701-1034  WEEK 2       14-19           20  Visit was too Late             ==> After completion window  20 > 19    */         
   /*   01-701-1034  WEEK 4       28-33           28  Visit on Schedule Window                                               */         
   /*                                                                                                                        */         
   /*   Frequency of status datasets plx_020onSchedule 04APR2023:10:21:42                                                    */         
   /*                                                                                                                        */         
   /*   Number of Variable Levels                                                                                            */         
   /*                                                                                                                        */         
   /*   Variable      Levels                                                                                                 */         
   /*   --------------------                                                                                                 */         
   /*   STATUS             5                                                                                                 */         
   /*                                                                                                                        */         
   /*   STATUS                                 Frequency                                                                     */         
   /*   ---------------------------------------------------                                                                  */         
   /*   Visit on Scheduled Day                     2025                                                                      */         
   /*   Visit was after Subject Termination           1                                                                      */         
   /*   Visit was too Early                          13                                                                      */         
   /*   Visit was too Late                           19                                                                      */         
   /*   Visit within Schedule Window                 34                                                                      */         
   /*                                                                                                                        */         
   /**************************************************************************************************************************/         
   /*                                                                                                                        */         
   /* VERSION HISTORY                                                                                                        */         
   /*                                                                                                                        */         
   /*   Programmer                            Date              Description of Changes                                       */         
   /*                                                                                                                        */         
   /*   rdeangelis@natera.com                2022/11/09         Creation                                                     */         
   /*                                                                                                                        */         
   /**************************************************************************************************************************/         
                                                                                                                                        
   /*        _                                                                                                                          
    ___  ___| |_ _   _ _ __                                                                                                             
   / __|/ _ \ __| | | | `_ \                                                                                                            
   \__ \  __/ |_| |_| | |_) |                                                                                                           
   |___/\___|\__|\__,_| .__/                                                                                                            
                      |_|                                                                                                               
   */                                                                                                                                   
                                                                                                                                        
   /*-- set up programming environment for proactive study                  ----*/                                                      
                                                                                                                                        
   /*---- ypu can uncomment to preent accidental excecution of all code     ----*/                                                      
   %*stop_submission;                                                                                                                   
                                                                                                                                        
   proc datasets lib=work mt=data  kill nolist nodetails;                                                                               
   run;quit;                                                                                                                            
                                                                                                                                        
   x "cd d:/pharma/plx";                                                                                                                
   %inc "d:/pharma/plx/sas/plx_000setup.sas";                                                                                           
                                                                                                                                        
   *For testing remove for plxd;                                                                                                        
   %inc "d:/pharma/plx/oto/sas_saspac.sas";                                                                                             
                                                                                                                                        
   /*                            _              _              _       _                                                                
   (_)_ __ ___  _ __   ___  _ __| |_   ___  ___| |__   ___  __| |_   _| | ___                                                           
   | | `_ ` _ \| `_ \ / _ \| `__| __| / __|/ __| `_ \ / _ \/ _` | | | | |/ _ \                                                          
   | | | | | | | |_) | (_) | |  | |_  \__ \ (__| | | |  __/ (_| | |_| | |  __/                                                          
   |_|_| |_| |_| .__/ \___/|_|   \__| |___/\___|_| |_|\___|\__,_|\__,_|_|\___|                                                          
               |_|                                                                                                                      
   */                                                                                                                                   
                                                                                                                                        
   /*---- if you do not have R you can use the sas datsets at d:/pharma/plx/plx.plx_020Schedule.sas7bdat ----*/                         
                                                                                                                                        
   %let inp = d:/pharma/plx/xls/plx_020schedule.xlsx ;                                                                                  
   %let out = d:/pharma/plx/xpt/plx_020schedule.xpt  ;                                                                                  
                                                                                                                                        
   %utlfkil(d:/pharma/plx/xpt/plx_020schedule.xpt)   ;                                                                                  
                                                                                                                                        
   %utl_submit_r64("                                                                                                                    
   library('readxl');                                                                                                                   
   library(SASxport);                                                                                                                   
   library(Hmisc);                                                                                                                      
   library(data.table);                                                                                                                 
   schedule <- as.data.table(read_excel('&inp'));                                                                                       
   schedule;                                                                                                                            
   for (i in seq_along(schedule)) {label(schedule[[i]])<-colnames(schedule)[i]};                                                        
   str(schedule);                                                                                                                       
   write.xport(schedule,file='&out');                                                                                                   
   ");                                                                                                                                  
                                                                                                                                        
   options label;                                                                                                                       
                                                                                                                                        
   libname xpt xport "d:/pharma/plx/xpt/plx_020schedule.xpt";                                                                           
                                                                                                                                        
   proc contents data=xpt._all_;                                                                                                        
   run;quit;                                                                                                                            
                                                                                                                                        
   data plx.plx_020Schedule ;                                                                                                           
                                                                                                                                        
      %utl_rens(xpt.schedule);                                                                                                          
      set schedule;                                                                                                                     
                                                                                                                                        
   run;quit;                                                                                                                            
                                                                                                                                        
   /**************************************************************************************************************************/         
   /*                                                                                                                        */         
   /* Up to 40 obs from D:/PHARMA/PLX/PLX_020SCHEDULE.SAS7BDAT total obs=13 03APR2023:14:29:19                               */         
   /*                                                                                   TARGET_    GRACE_                    */         
   /* Obs    VISITNUM    VISIT           PAGENAME     PAGEID           WINDOW             DAY      PERIOD                    */         
   /*                                                                                                                        */         
   /*   1       4.0      WEEK 2         Visit Date      30      WEEK 2 + 5 Days            14         5                      */         
   /*   2       5.0      WEEK 4         Visit Date      30      WEEK 4 + 5 Days            28         5                      */         
   /*   3       7.0      WEEK 6         Visit Date      30      WEEK 6 + 5 Days            42         5                      */         
   /*   4       8.0      WEEK 8         Visit Date      30      WEEK 8 + 5 Days            56         5                      */         
   /*   5       8.1      WEEK 10 (T)    Visit Date      30      WEEK 10 (T) + 5 Days       70         5                      */         
   /*   6       9.0      WEEK 12        Visit Date      30      WEEK 12 + 5 Days           84         5                      */         
   /*   7       9.1      WEEK 14 (T)    Visit Date      30      WEEK 14 (T) + 5 Days       98         5                      */         
   /*   8      10.0      WEEK 16        Visit Date      30      WEEK 16 + 5 Days          112         5                      */         
   /*   9      10.1      WEEK 18 (T)    Visit Date      30      WEEK 18 (T) + 5 Days      126         5                      */         
   /*  10      11.0      WEEK 20        Visit Date      30      WEEK 20 + 5 Days          140         5                      */         
   /*  11      11.1      WEEK 22 (T)    Visit Date      30      WEEK 22 (T) + 5 Days      154         5                      */         
   /*  12      12.0      WEEK 24        Visit Date      30      WEEK 24 + 5 Days          168         5                      */         
   /*  13      13.0      WEEK 26        Visit Date      30      WEEK 26 + 5 Days          182         5                      */         
   /*                                                                                                                        */         
   /**************************************************************************************************************************/         
                                                                                                                                        
   /*                          _     _ _         _       _                                                                              
    _ __ __ ___      __ __   _(_)___(_) |_    __| | __ _| |_ __ _                                                                       
   | `__/ _` \ \ /\ / / \ \ / / / __| | __|  / _` |/ _` | __/ _` |                                                                      
   | | | (_| |\ V  V /   \ V /| \__ \ | |_  | (_| | (_| | || (_| |                                                                      
   |_|  \__,_| \_/\_/     \_/ |_|___/_|\__|  \__,_|\__,_|\__\__,_|                                                                      
                                                                                                                                        
   */                                                                                                                                   
                                                                                                                                        
   /*--- just for documentation to show input                                                                   ----*/                  
                                                                                                                                        
   data plx_020rawVis;                                                                                                                  
     set plxraw.visitCrf;                                                                                                               
   run;quit;                                                                                                                            
                                                                                                                                        
   /*----- Number of unique levels=253 for usubjid from plx_020rawVis (obs=2,092) 03APR2023:11:57:05            -----*/                 
   /*----- Number of unique levels=2,092 for usubjid,visitnum from plx_020rawVis (obs=2,092) 03APR2023:11:58:18 -----*/                 
                                                                                                                                        
   /**************************************************************************************************************************/         
   /*                                                                                                                        */         
   /* Up to 40 obs from PLXSDM.SMPSDM_DM total obs=306 03APR2023:14:00:43                                                    */         
   /*                                                                                                       END_             */         
   /*                                                                                                      STUDY_            */         
   /*  Obs      STUDYID         USUBJID       PAGENAME     PAGEID    VISITNUM    VISIT          VISITDY      DAY             */         
   /*                                                                                                                        */         
   /*    1    CDISCPILOT01    01-701-1015    Visit Date      30         4.0      WEEK 2            14        189             */         
   /*    2    CDISCPILOT01    01-701-1015    Visit Date      30         5.0      WEEK 4            28        189             */         
   /*    3    CDISCPILOT01    01-701-1015    Visit Date      30         7.0      WEEK 6            42        189             */         
   /*    4    CDISCPILOT01    01-701-1015    Visit Date      30         8.0      WEEK 8            56        189             */         
   /*    5    CDISCPILOT01    01-701-1015    Visit Date      30         9.0      WEEK 12           84        189             */         
   /*    6    CDISCPILOT01    01-701-1015    Visit Date      30         9.1      WEEK 14 (T)       98        189             */         
   /*    7    CDISCPILOT01    01-701-1015    Visit Date      30        10.0      WEEK 16          112        189             */         
   /*    8    CDISCPILOT01    01-701-1015    Visit Date      30        11.0      WEEK 20          140        189             */         
   /*    9    CDISCPILOT01    01-701-1015    Visit Date      30        11.1      WEEK 22 (T)      154        189             */         
   /*   10    CDISCPILOT01    01-701-1015    Visit Date      30        12.0      WEEK 24          168        189             */         
   /*   11    CDISCPILOT01    01-701-1015    Visit Date      30        13.0      WEEK 26          182        189             */         
   /*                                                                                                                        */         
   /*                       Variables in Creation Order                                                                      */         
   /*                                                                                                                        */         
   /*#    Variable         Type    Len    Format    Label                                                                    */         
   /*                                                                                                                        */         
   /*1    STUDYID          Char     12                                                                                       */         
   /*2    USUBJID          Char     11    $11.      Unique Subject Identifier                                                */         
   /*3    PAGENAME         Char     39    $39.      Visit Date CRF Pagename                                                  */         
   /*4    PAGEID           Num       8              Visit Date CRF Page Number                                               */         
   /*5    VISITDY          Num       8              Visit Study Day                                                          */         
   /*6    END_STUDY_DAY    Num       8              End of Study Day                                                         */         
   /*7    VISITNUM         Num       8              Visit Number                                                             */         
   /*7    VISIT            Num       8              Visit Name                                                               */         
   /*                                                                                                                        */         
   /**************************************************************************************************************************/         
                                                                                                                                        
   /* _       _                  _              _       _                                                                               
     (_) ___ (_)_ __    ___  ___| |__   ___  __| |_   _| | ___                                                                          
     | |/ _ \| | `_ \  / __|/ __| `_ \ / _ \/ _` | | | | |/ _ \                                                                         
     | | (_) | | | | | \__ \ (__| | | |  __/ (_| | |_| | |  __/                                                                         
    _/ |\___/|_|_| |_| |___/\___|_| |_|\___|\__,_|\__,_|_|\___|                                                                         
   |__/                                                                                                                                 
   */                                                                                                                                   
                                                                                                                                        
   /*---- jpin the schedule from data manageents to the raw study visitCrf data                                 ----*/                  
   proc sql;                                                                                                                            
     create                                                                                                                             
       table plx_020visevt as                                                                                                           
     select                                                                                                                             
        raw.studyid                                                                                                                     
       ,raw.usubjid                                                                                                                     
       ,evt.visit                                                                                                                       
       ,evt.visitnum                                                                                                                    
       ,evt.pageid                                                                                                                      
       ,evt.pagename                                                                                                                    
       ,evt.window                        as visit_window                                                                               
       ,catx('-',target_day,target_day+5) as schedule_window                                                                            
       ,raw.end_study_day                                                                                                               
       ,evt.target_day     as  schedule_day                                                                                             
       ,raw.visitdy        as  actual_study_day                                                                                         
                                                                                                                                        
     from                                                                                                                               
       plx.plx_020schedule as evt full outer join plx_020rawvis as raw                                                                  
     on                                                                                                                                 
       evt.visitnum = raw.visitnum                                                                                                      
     order                                                                                                                              
       by usubjid, visitnum                                                                                                             
   ;quit;                                                                                                                               
                                                                                                                                        
   /*----- Number of unique levels=2,092 for usubjid,visitnum from plx_020visEvt (obs=2,092) 03APR2023:11:58:57 -----*/                 
   /*----- Number of unique levels=253 for usubjid from plx_020visevt (obs=2,092) 03APR2023:14:35:08            -----*/                 
                                                                                                                                        
   /**************************************************************************************************************************/         
   /*                                                                                                                        */         
   /* Up to 40 obs from PLX_020VISEVT total obs=2,092 04APR2023:09:57:32                                                     */         
   /*                                                                                    END_                  ACTUAL_       */         
   /*                                                                      SCHEDULE_    STUDY_    SCHEDULE_     STUDY_       */         
   /*    USUBJID      VISIT           PAGENAME         VISIT_WINDOW         WINDOW        DAY        DAY         DAY         */         
   /*                                                                                                                        */         
   /*  01-701-1015    WEEK 2         Visit Date    WEEK 2 + 5 Days          14-19         185         14          14         */         
   /*  01-701-1015    WEEK 4         Visit Date    WEEK 4 + 5 Days          28-33         185         28          28         */         
   /*  01-701-1015    WEEK 6         Visit Date    WEEK 6 + 5 Days          42-47         185         42          42         */         
   /*  01-701-1015    WEEK 8         Visit Date    WEEK 8 + 5 Days          56-61         185         56          55         */         
   /*  01-701-1015    WEEK 12        Visit Date    WEEK 12 + 5 Days         84-89         185         84          84         */         
   /*  01-701-1015    WEEK 14 (T)    Visit Date    WEEK 14 (T) + 5 Days     98-103        185         98          98         */         
   /*  01-701-1015    WEEK 16        Visit Date    WEEK 16 + 5 Days         112-117       185        112         112         */         
   /*  01-701-1015    WEEK 20        Visit Date    WEEK 20 + 5 Days         140-145       185        140         140         */         
   /*  01-701-1015    WEEK 22 (T)    Visit Date    WEEK 22 (T) + 5 Days     154-159       185        154         154         */         
   /*  01-701-1015    WEEK 24        Visit Date    WEEK 24 + 5 Days         168-173       185        168         168         */         
   /*  01-701-1015    WEEK 26        Visit Date    WEEK 26 + 5 Days         182-187       185        182         182         */         
   /*  01-701-1023    WEEK 2         Visit Date    WEEK 2 + 5 Days          14-19          36         14          14         */         
   /*  01-701-1023    WEEK 4         Visit Date    WEEK 4 + 5 Days          28-33          36         28          28         */         
   /*                                                                                                                        */         
   /*                                                                                                                        */         
   /*  Middle Observation(1046 ) of table = plx_020visevt - Total Obs 2092 04APR2023:10:02:10                                */         
   /*                                                                                                                        */         
   /*                                                                                                                        */         
   /*   -- CHARACTER --                                                                                                      */         
   /*  Variable                        Typ    Value                      Label                                               */         
   /*                                                                                                                        */         
   /*  STUDYID                          C12   CDISCPILOT01               Studyid                                             */         
   /*  USUBJID                          C11   01-709-1020                Unique subject identifier                           */         
   /*  VISIT                            C11   WEEK 20                    Visit                                               */         
   /*  PAGENAME                         C10   Visit Date                 Pagename                                            */         
   /*  VISIT_WINDOW                     C20   WEEK 20 + 5 Days           Window                                              */         
   /*  SCHEDULE_WINDOW                  C200  140-145                    Schedule_window                                     */         
   /*  TOTOBS                           C16   2,092                      Totobs                                              */         
   /*                                                                                                                        */         
   /*   -- NUMERIC --                                                                                                        */         
   /*  VISITNUM                         N     11                         Visitnum                                            */         
   /*  PAGEID                           N     30                         Pageid                                              */         
   /*  END_STUDY_DAY                    N     190                        End of study day                                    */         
   /*  SCHEDULE_DAY                     N     140                        Target_day                                          */         
   /*  ACTUAL_STUDY_DAY                 N     140                        Visit study day                                     */         
   /*                                                                                                                        */         
   /**************************************************************************************************************************/         
                                                                                                                                        
   data plx_020onSchedule;                                                                                                              
                                                                                                                                        
     set plx_020visEvt;                                                                                                                 
                                                                                                                                        
     select;                                                                                                                            
        when (actual_study_day > end_study_day                     ) status = "Visit was after Subject Termination" ;                   
        when (actual_study_day = schedule_day                      ) status = "Visit on Scheduled Day             " ;                   
        when (actual_study_day < schedule_day                      ) status = "Visit was too Early                " ;                   
        when (actual_study_day > schedule_day + 5                  ) status = "Visit was too Late                 " ;                   
        when (schedule_day <= actual_study_day <= schedule_day + 5 ) status = "Visit within Schedule Window       " ;                   
     end;                                                                                                                               
                                                                                                                                        
   run;quit;                                                                                                                            
                                                                                                                                        
   /*----- Number of unique levels= for usubjid from plx_020onSchedule (obs=) 04APR2023:10:03:56             -----*/                    
   /*----- Number of unique levels=2,092 for usubjid,visit from plx_020visEvt (obs=2,092) 04APR2023:10:07:04 -----*/                    
                                                                                                                                        
   %utl_optlenpos(plx_020onSchedule,plx_020onSchedule);                                                                                 
                                                                                                                                        
   options nolabel;                                                                                                                     
   proc report data=plx_020onSchedule(obs=40) missing split='_';                                                                        
   cols usubjid visit schedule_window actual_study_day status;                                                                          
   run;quit;                                                                                                                            
                                                                                                                                        
   /**************************************************************************************************************************/         
   /*                                                                                                                        */         
   /*   plx_020onSchedule 04APR2023:10:21:42                                                                                 */         
   /*                                                                                                                        */         
   /*                                         ACTUAL                                                                         */         
   /*                            SCHEDULE      STUDY                                                                         */         
   /*   USUBJID      VISIT        WINDOW         DAY  STATUS                                                                 */         
   /*   01-701-1015  WEEK 2       14-19           14  Visit on Schedule Window                                               */         
   /*   01-701-1015  WEEK 4       28-33           28  Visit on Schedule Window                                               */         
   /*   01-701-1015  WEEK 6       42-47           42  Visit on Schedule Window                                               */         
   /*   01-701-1015  WEEK 8       56-61           55  Visit was too Early            ==> Before completion window            */         
   /*   01-701-1015  WEEK 12      84-89           84  Visit on Schedule Window                                               */         
   /*   01-701-1015  WEEK 14 (T)  98-103          98  Visit on Schedule Window                                               */         
   /*   01-701-1015  WEEK 16      112-117        112  Visit on Schedule Window                                               */         
   /*   01-701-1015  WEEK 20      140-145        140  Visit on Schedule Window                                               */         
   /*   01-701-1015  WEEK 22 (T)  154-159        154  Visit on Schedule Window                                               */         
   /*   01-701-1015  WEEK 24      168-173        168  Visit on Schedule Window                                               */         
   /*   01-701-1015  WEEK 26      182-187        182  Visit on Schedule Window                                               */         
   /*                                                                                                                        */         
   /*   01-701-1034  WEEK 2       14-19           20  Visit was too Late             ==> After completion window             */         
   /*   01-701-1034  WEEK 4       28-33           28  Visit on Schedule Window                                               */         
   /*                                                                                                                        */         
   /*                                                                                                                        */         
   /*   Frequency of status datasets plx_020onSchedule 04APR2023:10:21:42                                                    */         
   /*                                                                                                                        */         
   /*   Number of Variable Levels                                                                                            */         
   /*                                                                                                                        */         
   /*   Variable      Levels                                                                                                 */         
   /*   --------------------                                                                                                 */         
   /*   STATUS             5                                                                                                 */         
   /*                                                                                                                        */         
   /*   STATUS                                 Frequency                                                                     */         
   /*   ---------------------------------------------------                                                                  */         
   /*   Visit on Scheduled Day                     2025                                                                      */         
   /*   Visit was after Subject Termination           1                                                                      */         
   /*   Visit was too Early                          13                                                                      */         
   /*   Visit was too Late                           19                                                                      */         
   /*   Visit within Schedule Window                 34                                                                      */         
   /*                                                                                                                        */         
   /**************************************************************************************************************************/         
                                                                                                                                        
   /*              _                                                                                                                    
     ___ _ __   __| |                                                                                                                   
    / _ \ `_ \ / _` |                                                                                                                   
   |  __/ | | | (_| |                                                                                                                   
    \___|_| |_|\__,_|                                                                                                                   
                                                                                                                                        
   */                                                                                                                                   
                                                                                                                                        
                                                                                        
