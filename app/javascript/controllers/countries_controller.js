import { Controller } from "stimulus"
import Rails from "@rails/ujs";

export default class extends Controller {
    static targets = [ "country", "cities" ]

    fetchCities() {
        Rails.ajax({
            type: "GET",
            url: "/countries/fetch_cities",
            data: "country_id=" + this.countryTarget.value,
            success: (data) => {
                this.citiesTarget.innerHTML = data.body.innerHTML;
            },
        });
    }

    connect() {
        console.log('connected')
    }
}
