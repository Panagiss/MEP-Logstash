require 'csv'

def filter(event)

    table = CSV.parse(File.read("/usr/share/logstash/config/misp.csv"), headers: ["key","value"] )

    new_key = event.get("[@metadata][misp_key]")

    #puts ("My_Key:" +  new_key.to_s )
    #puts "Already written keys:"
    
    for _key in table.by_col[0] do
        #puts _key
        if _key.to_s == new_key.to_s
            return []
        end
    end
    return [event]

end