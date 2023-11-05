LaunchX: This version implements the search functionality using the find 
variable in the query. However, due to an issue with the SpaceX API, the 
find variable is not working properly and all items are returned without 
applying the search filter. This version also implements offset pagination 
to improve performance.

LaunchX-ManualSearch: This version implements the search functionality by 
manually searching among all the data fetched from the API. Pagination is 
not implemented in this version, because the manual search must be done
locally among all the data.

Please note that the search functionality in LaunchX is currently not 
working properly due to an issue with the SpaceX API. The search bar sends 
a request to the API with the search query, but the API returns all items 
without applying the search filter. As a workaround, the application shows 
all the items without applying the search filter. This issue is not 
present in LaunchX-ManualSearch.

Pagination is implemented using offset pagination in LaunchX. However, 
pagination is not implemented in LaunchX-ManualSearch, as all the data is 
fetched in one query.
