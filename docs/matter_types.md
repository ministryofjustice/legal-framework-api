# Adding a new matter type
Steps required to add a new matter type:
* Add the proceeding type [seed data](/db/seed_data/proceeding_types.yml) - [example PR](https://github.com/ministryofjustice/legal-framework-api/pull/1451)
* Ensure all scope limitations listed in the master sheet are included in the [seed data](/db/seed_data/scope_limitations.yml)
* Check the default values for the new proceeding types and update the [seed data](/db/seed_data/default_cost_limitations.yml) if the new proceedings have non-standard defaults
* Add the default service levels for the new proceeding types to the [seed data](/db/seed_data/proceeding_type_service_levels.yml)
* Modify the [eligible scopes](config/eligible_scopes.yml) class.  Create new groups as needed and assign the new matter type proceedings to them

## Example PR
The linked PR added all of the above for Special Children Act - [Special Children Act PR](https://github.com/ministryofjustice/legal-framework-api/pull/1288)
