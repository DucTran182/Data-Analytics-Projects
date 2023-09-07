/*

Cleaning Data in SQL Queries

*/

-- Standardize Date Format
Select *
From ['BRC-Trac9-v1$']
Order by UUID


Select DateAdmitted1
From ['BRC-Trac9-v1$']

Alter table ['BRC-Trac9-v1$']
ADD DateAdmitted1 Date;

Update ['BRC-Trac9-v1$']
Set DateAdmitted1 = CONVERT(Date,[Date Admitted])

Alter table ['BRC-Trac9-v1$']
Drop column [Date Admitted]


-- Update rows where the Premature Discharge Reason matches the criteria
UPDATE ['BRC-Trac9-v1$']
SET [Premature Discharge Reason] = 'outernal_medical'
WHERE [Premature Discharge Reason] IS NULL
  OR [Premature Discharge Reason] = 'outernal_medical';


-- Drop off all Unused Columns
Alter table ['BRC-Trac9-v1$']
Drop column [Highest Step Completed], [Program Client Plans To Attend], [Planned 12-step Meeting Attendance], [Deleted at], [Deleted], [DEM_NICOTINE_PRODUCTS]
, [DEM_ACTIVE_DUTY], [DISCRIM_LESS_RESPECT], [INTPARTVIOL_PHYSICAL_ABUSE], [DISCRIM_POOR_SERVICE],	[DEM_STIGMA_DATE_SOMEONE],	[DEM_STIGMA_SUBSTANCE_TEACHER]
, [DISCRIM_THREATENED],	[DISCRIM_MAIN_REASON],	[DEM_STIGMA_PASS_OVER],	[DEM_STIGMA_WILLINGLY_ACCEPT],	[INTPARTVIOL_AFRAID],	[INTPARTVIOL_RELASTIONSHIP_PAST_YEAR]
,[DEM_STIGMA_HIRE],	[INTPARTVIOL_FORCED_SEX],	[DEM_STIGMA_CHILDREN],	[INTPARTVIOL_PUT_DOWN_REJECTED],	[DISCRIM_NOT_SMART], [INTPARTVIOL_THREATENED]
,[DISCRIM_ACT_AFRAID],	[DISCRIM_LESS_COURTESY],	[DISCRIM_ACT_BETTER_THAN_YOU],	[DEM_STIGMA_TRUSTWORTHY],	[DISCRIM_CALLED_NAMES],	[DISRCRIM_ACT_DISHONEST]
,[DEM_STIGMA_THINK_LESS], [NARCAN_HIGHER_DOSE_OVERDOSE],	[NARCAN_USE_FENTANYL],	[NARCAN_HEARD_OF],	[NARCAN_HAVE_ANY],	[NARCAN_OPIOID_OVERDOSE],	[NARCAN_HIGHER_DOSE_RESPONDERS]
,[NARCAN_ADMINISTERED],	[NARCAN_WITNESSED_OVERDOSE],	[NARCAN_UNITS_FOR_OVERDOSE],	[NARCAN_HIGHER_DOSE_ADMINISTERED],	[NARCAN_ADMINISTERED_FOR_OVERDOSE],	[FNTYL_TEST_POS], [FNTYL_USE]
,[FNTYL_BRPEN_KNOW],	[FNTYL_BPREN],	[FNTYL_METH],	[FNTYL_METH_WD_D],	[FNTYL_BPREN_WD],	[FNTYL_METH_WD],	[FNTYL_BPREN_WD_D],	[FNTYL_BPREN_WD_TX]


-- Check for Duplicates

Select *,
	ROW_NUMBER() OVER (
	PARTITION BY UUID,
				 Location,
				 Clinician,
				 DateAdmitted,
				 Gender,
				 Race,
				 [DOC/Condition],
				 [Cycle Start Date]
				 ORDER BY
					UUID
					) row_num

From ['BRC-Trac9-v1$']
order by UUID