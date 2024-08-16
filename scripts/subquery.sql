USE RealEstateDB;
-- 1. **Find the average listing price of all properties.**Calculate the average listing price using a subquery.
Select(Select avg(ListingPrice) from properties) as average_listing_price;

-- 2. **Retrieve the address of the property with the lowest listing price.**
 --  - Use a subquery to determine the lowest listing price and get the property address.
Select address from properties where ListingPrice =(Select min(ListingPrice) from properties);
-- 3. **List the addresses of all properties where the listing price is above the average listing price.**
  --  - Use a subquery to find the average listing price and filter properties.
  
 Select Address from properties where ListingPrice >(Select avg(ListingPrice) from properties);
 
 -- 4. **Find the names of agents who have listed at least one property with a listing price above $500,000.**
  --  - Use a subquery to filter agents based on listing prices.
  Select CONCAT(FirstName, ' ', LastName)  as names FROM agents WHERE AgentID IN (SELECT DISTINCT AgentID FROM properties where ListingPrice >500000);
 -- 5. **Retrieve the address and number of bedrooms for the properties with the highest number of bedrooms.**
  --  - Use a subquery to find the property with the most bedrooms.
  Select  p.Address , pd.Bedrooms from properties p  JOIN propertydetails pd using(PropertyID) where  pd.Bedrooms =(Select max(Bedrooms) from propertydetails);
  
-- 6. **Find the average number of bedrooms across all properties.**
 --   - Use a subquery to calculate the average number of bedrooms.
  Select p.Address, pd.Bedrooms from properties p  JOIN propertydetails pd using(PropertyID) where  pd.Bedrooms =(Select round(avg(Bedrooms),0) from propertydetails);
-- 7. **Retrieve the details of the property with the oldest construction date.**
--   - Use a subquery to find the property with the earliest `YearBuilt`.
Select * from propertydetails;
select * from propertydetails where YearBuilt = (select min(YearBuilt) from propertydetails);
-- 8. **List all properties where the number of bathrooms is greater than the average number of bathrooms.**
 --  - Use a subquery to compare the number of bathrooms with the average.
 
 Select p.Address, pd.Bedrooms from properties p  JOIN propertydetails pd using(PropertyID) where  pd.Bedrooms >(Select round(avg(Bedrooms),0) from propertydetails );

-- 9. **Find the total number of properties that have a 'Pool' as an amenity.**
   --  - Use a subquery to count the number of properties with the 'Pool' amenity.

Select * from propertyamenities;
Select * from propertyamenityassignments;
Select * from properties;
Select count(p.PropertyID) as TotalPropertiesWithPool from properties p join propertyamenityassignments paa using(PropertyID)
join propertyamenities pa using(AmenityID) where AmenityID = (Select AmenityID from propertyamenities where AmenityName ='Pool');

-- 10. **List the names of all amenities that are assigned to more than 3 properties.**
--     - Use a subquery to filter amenities based on the number of properties they are assigned to.

Select pa.AmenityName from propertyamenities pa  join propertyamenityassignments paa using(AmenityID)
group by  pa.AmenityName
having count(paa.PropertyID)>3;
--  11. **Retrieve all properties that have more bedrooms than the average number of bedrooms and a listing price above the average listing price.**
 --   - Use a subquery to filter properties based on bedrooms and listing price.
 
Select p.Address, p.ListingPrice , pd.Bedrooms from properties p  JOIN propertydetails pd using(PropertyID) where  pd.Bedrooms >(Select avg(Bedrooms) from propertydetails)
And p.ListingPrice >(Select avg(ListingPrice) from properties);

-- 12. **Find the names of clients who have purchased properties with more than 3 bedrooms and a sale price above $500,000.**
  --  - Use a subquery to filter clients based on the number of bedrooms and sale price.
  Select * from transactions;
  Select * from propertydetails;
  select * from clients;
  Select c.FirstName,pd.Bedrooms,t.SalePrice FROM clients c join transactions t using(ClientID)
  join propertydetails pd using(PropertyID) 
 where pd.Bedrooms>3 and t.SalePrice >500000 ;
  
  