import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="region"
const regionSelect = document.getElementById("region-select");
const citySelect = document.getElementById("city-select");
const suburbSelect = document.getElementById("suburb-select");
let regionId =0;
let cityId = 0;
export default class extends Controller {
  // let regionId =0;
  change(event) {
    regionId = event.target.selectedOptions[0].index;
    fetch(`/regions/${regionId}/city_query.json`)
    .then(response => response.json())
    .then(region_cities => {  
        citySelect.innerHTML = "<option value=''>Select a city</option>"; 
        region_cities.forEach(city => { 
            const option = document.createElement("option");
            option.text = city.name;
            option.value = city.id;
            citySelect.appendChild(option);
         });
        });
    };
    change1(event){
      citySelect.addEventListener("change", () => { 
        cityId = event.target.selectedOptions[0].value; 
        // const regionId = params[:region]
        fetch(`/regions/${regionId}/cities/${cityId}/suburb_query.json`)
          .then(response => response.json())
          .then(city_suburbs => {
            suburbSelect.innerHTML = "<option value=''>Select a Suburb</option>";
            city_suburbs.forEach(city_suburb => {
              //create selection option for each json onject        
              const option = document.createElement("option");
              option.text = city_suburb.name; 
              option.value = city_suburb.id;
              suburbSelect.appendChild(option);
              });
            });
        });
      }
  }
