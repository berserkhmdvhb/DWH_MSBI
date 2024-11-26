
CREATE TABLE [dwh].[Td_Period] (
    -- Key and Date
    [date_key] [int] NOT NULL PRIMARY KEY, 
    [date] [date] NOT NULL,                
    
    -- Day Level Attributes
    [weekday] [varchar](9) NOT NULL,      
    [weekday_num] [int] NOT NULL,         
    [day_month] [int] NOT NULL,           
    [day_of_year] [int] NOT NULL,         
    [weekend_indr] [varchar](10) NOT NULL,    
    
    -- Week Level Attributes
    [week_of_year] [int] NOT NULL,        
    [iso_week] [varchar](10) NOT NULL,        
    [week_id] [int] NOT NULL,             
    [week_desc] [varchar](10) NOT NULL,   
    
    -- Month Level Attributes
    [month_num] [int] NOT NULL,           
    [month_name] [varchar](20) NOT NULL,  
    [month_name_short] [char](3) NOT NULL,
    [month_id] [int] NOT NULL,            
    [month_desc] [varchar](20) NOT NULL,  
    [first_day_of_month] [date] NOT NULL, 
    [last_day_of_month] [date] NOT NULL,  
    [yyyymm] [char](7) NOT NULL,          
    
    -- Quarter Level Attributes
    [quarter] [int] NOT NULL,             
    [quarter_id] [int] NOT NULL,          
    [quarter_desc] [varchar](10) NOT NULL,
    [quarter_cd] [varchar](10) NOT NULL,  
    
    -- Semester Level Attributes
    [semester_id] [int] NOT NULL,         
    [semester_desc] [varchar](10) NOT NULL,
    [semester_cd] [varchar](10) NOT NULL, 
    
    -- Year Level Attributes
    [year] [int] NOT NULL,                
    [year_id] [int] NOT NULL,             
    [year_desc] [varchar](10) NOT NULL,   
    [year_cd] [varchar](10) NOT NULL      
);
