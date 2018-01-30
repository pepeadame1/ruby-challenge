
require 'open-uri'
require 'nokogiri'

doc = Nokogiri::XML(open("http://www.ibiblio.org/xml/examples/shakespeare/macbeth.xml")) { |c| c.noblanks }#el programa descarga el xml

people = doc.xpath("//SPEAKER")#encuentra todos los personajes
array = people.to_a #lo convierte en array
array2 = Array.new() #crea un nuevo array
h = Hash.new()
for i in 0..array.size-1
	array2[i] = array[i].text
end
array2.uniq! #quita duplicados
array2.delete("ALL") #quita ALL
lines = doc.xpath("//SPEECH")

for k in 0..array2.size-1
	h[array2[k]] = 0#inicializa el hash
end
lines.xpath("//STAGEDIR").remove #borra los tags de stagedir
for i in 0..lines.size-1
	for j in 0..array2.size-1 
		if lines[i].children.first.text == array2[j]#si se encuentra el nombre de x persona
				h[array2[j]] = h.fetch(array2[j]) + lines[i].children.size-1 #agrega el numero de lineas de el personaje
			
		end
	end
end

h.each do |key, value|
    puts "#{key}: #{value}"
end
	
