document.addEventListener('DOMContentLoaded', () => { 
  $("#company_address_attributes_postal_code").jpostal({
    postcode : [ "#company_address_attributes_postal_code" ],
    address  : {"#company_address_attributes_prefecture_code": "%3",
                "#company_address_attributes_city": "%4",
                "#company_address_attributes_town": "%5%6%7"
                    }
  })
})