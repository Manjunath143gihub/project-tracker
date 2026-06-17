# Project Tracker — APEX 26.1

## App Info
- App ID: 100
- Workspace: DEVELOPMENT
- Schema: PDBADMIN
- APEX version: 26.1 (APEXlang mmdVersion: 26.1.0+3102)

## Database (local Docker)
- Container: oracle-free (Docker)
- Host: localhost:1521
- Service: FREEPDB1
- User: PDBADMIN / Welcome123

## Tables
| Table | Description |
|---|---|
| PT_PROJECTS | Project header (PROJECT_ID PK, PROJECT_CODE, PROJECT_NAME, STATUS, PRIORITY, OWNER_ID FK→PT_TEAM_MEMBERS, START_DATE, TARGET_END_DATE, PCT_COMPLETE, BUDGET, DESCRIPTION, TAGS, IS_ARCHIVED) |
| PT_TASKS | Tasks (TASK_ID PK, PROJECT_ID FK, MILESTONE_ID FK, TASK_NAME, STATUS, PRIORITY, TASK_TYPE, START_DATE, DUE_DATE, PCT_COMPLETE, ESTIMATED_HOURS, STORY_POINTS, DESCRIPTION) |
| PT_MILESTONES | Milestones (MILESTONE_ID PK, PROJECT_ID FK, MILESTONE_NAME, STATUS, DUE_DATE, DESCRIPTION) |
| PT_TEAM_MEMBERS | People (MEMBER_ID PK, FIRST_NAME, LAST_NAME, EMAIL, JOB_TITLE, DEPARTMENT, APEX_USERNAME, IS_ACTIVE) |
| PT_ASSIGNMENTS | Task assignees (ASSIGNMENT_ID PK, TASK_ID FK, MEMBER_ID FK, IS_ACTIVE) |
| PT_STATUS_HISTORY | Audit trail (HISTORY_ID PK, ENTITY_TYPE, ENTITY_ID, OLD_STATUS, NEW_STATUS, CHANGED_BY VARCHAR2, CHANGED_ON DATE) |
| PT_LOOKUP_CODES | Reference data (LOOKUP_TYPE, LOOKUP_CODE, DISPLAY_VALUE, SORT_ORDER, IS_ACTIVE) |
| PT_COMMENTS | Comments (COMMENT_ID PK, ENTITY_TYPE, ENTITY_ID, COMMENT_TEXT, CREATED_BY, CREATED_ON) |

## PT_LOOKUP_CODES Values
- LOOKUP_TYPE = 'PROJECT_STATUS': PLANNING, ACTIVE, ON_HOLD, COMPLETED, CANCELLED
- LOOKUP_TYPE = 'TASK_STATUS': TODO, IN_PROGRESS, BLOCKED, IN_REVIEW, COMPLETED, CANCELLED
- LOOKUP_TYPE = 'PRIORITY': LOW, MEDIUM, HIGH, CRITICAL
- LOOKUP_TYPE = 'TASK_TYPE': FEATURE, BUG, IMPROVEMENT, RESEARCH, DOCUMENTATION

## Page Map
| Page | Name | Type |
|---|---|---|
| 1 | Dashboard | IR — PT_PROJECTS with schedule health |
| 2 | Projects | IR — PT_PROJECTS (IS_ARCHIVED='N') |
| 3 | Tasks | IR — PT_TASKS with LISTAGG assignees |
| 4 | Milestones | IR — PT_MILESTONES with task counts |
| 5 | Team Workload | IR — PT_TEAM_MEMBERS with task counts |
| 6 | Activity Log | IR — PT_STATUS_HISTORY (read-only) |
| 10 | Project Form | Drawer modal for PT_PROJECTS |
| 11 | Task Form | Drawer modal for PT_TASKS |
| 12 | Milestone Form | Drawer modal for PT_MILESTONES |
| 13 | Team Member Form | Drawer modal for PT_TEAM_MEMBERS |

## Shared Components
- `shared-components/lovs.apx` — 8 LOVs (project-status-lov, task-status-lov, priority-lov, task-type-lov, team-members-lov, projects-lov, milestones-lov, milestone-status-lov)
- `shared-components/breadcrumbs.apx` — Breadcrumb with entries for pages 1–6

## Standards
- Interactive Reports (not Interactive Grid) for all list pages
- Drawer end/right for all create/edit forms (pages 10+): `dialogTemplate: @/drawer; templateOptions: [#DEFAULT# js-dialog-class-t-Drawer--pullOutEnd]`
- Shared LOVs from PT_LOOKUP_CODES (never static values for status/priority)
- Breadcrumb region on every non-modal page (slot: REGION_POSITION_01, template: @/title-bar)
- Dynamic action `apexafterclosedialog` on each IR page to refresh report after drawer closes
- Form processes: set-success-message (seq 5), formInitialization at beforeHeader (seq 10), formAutoRowProcessing (seq 10), closeDialog (seq 50)
- Page item naming: P<page#>_<COLUMN_NAME>
- All IR links to edit form pass PK via: `f?p=&APP_ID.:<page>:&APP_SESSION.::&DEBUG.::<PK_item>:#PK_COLUMN#`

## Infrastructure
- Start DB: `docker start oracle-free`
- Start ORDS: `cd C:\apex-local\ords && java -jar ords.war serve --port 8081`
- APEX Builder: http://localhost:8080/ords
- SQLcl: C:\oandev\sqlcl-latest\sqlcl\bin\sql
- Import: `sql PDBADMIN/Welcome123@//localhost:1521/FREEPDB1 @import.sql` then `apex import -input . -workspaceName DEVELOPMENT`
