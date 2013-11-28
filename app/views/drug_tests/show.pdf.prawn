prawn_document(:filename=>"Laudo "+@drug_test.donor.name, :force_download=>true, :page_size => "A4",:font => 'Arial') do |pdf|
	#@avatar_file_jpg = "#{Rails.root}/public/uploads/images/companies/#{@drug_test.donor.company.id}.jpg"
	#@avatar_file_png = "#{Rails.root}/public/uploads/images/companies/#{@drug_test.donor.company.id}.png"
	#if File.exist?(@avatar_file_jpg)
	#	pdf.image @avatar_file_jpg, height: 40, at: [50, 50]
	#elsif File.exist?(@avatar_file_png)
	#	pdf.image @avatar_file_png, height: 40, at: [50, 50]
	#end

	pdf.text @drug_test.donor.company.trade_name.upcase,  :style => :bold, :align => :right, :size => 16
	pdf.stroke_horizontal_rule
	pdf.pad_top(10) {
		pdf.text(@drug_test.donor.company.legal_name, align: :right, style: :bold)
		pdf.text(@drug_test.donor.company.address + ' - ' + @drug_test.donor.company.address_neighbourhood , align: :right)
		pdf.text(@drug_test.donor.company.city.name + '/' + @drug_test.donor.company.city.state.symbol, align: :right)
	}

	pdf.pad_top(30) {
		pdf.text("Natureza da análise : <b>PESQUISA DE FÁRMACOS / DROGAS</b>", inline_format: true, leading: 10, size: 10)
		pdf.text("Interessado : <b>#{@drug_test.donor.company.legal_name} (CNPJ: #{@drug_test.donor.company.legal_identifier})</b>", inline_format: true, leading: 10, size: 10)
		pdf.text("Nome do(a) funcionário(a): <b>#{@drug_test.donor.name}</b>", inline_format: true, leading: 10, size: 10)
		amostras = Set.new
		@drug_test.selected_test.each do |selected_test|
			amostras.add(selected_test.test_type.collected_material)
		end
		amostras_text = ""
		amostras.each do |amostra|
			amostras_text << "#{amostra}; "
		end
		pdf.text("Material(ais) coletado(s): <b>#{amostras_text}</b>", inline_format: true, leading: 10, size: 10)

		pdf.text("Resultado(s) :", leading: 5, style: :bold, size: 10)

		@drug_test.selected_test.all.each do |selected_type|
			if selected_type.result != nil
				test_result = selected_type.result == 'positive' ? "POSITIVO" : "NEGATIVO"
				pdf.text("#{selected_type.test_type.name} (#{selected_type.test_type.short_name}) : <b>#{test_result}</b>", inline_format: true, leading: 4, indent_paragraphs: 100, size: 10)
			end
		end

		pdf.pad_top(5) {
			pdf.text("Técnica de identificação : ", leading: 5, style: :bold, size: 10)
			pdf.text("Triagem : <b>Ensaio Imunológico</b>", leading: 5, indent_paragraphs: 100, inline_format: true, size: 10)
		}

		pdf.text("Valores de referência : ", leading: 5, style: :bold, size: 10)
		ref_table_data = [	["<b>Droga</b>", "<b>Triagem</b>", "<b>Droga</b>", "<b>Triagem</b>", "<b>Droga</b>", "<b>Triagem</b>"],
							["Álcool", "0,05 mg/l", "Anfetamina (AMP)", "1000 ng/ml", "Anfetamina (AMP 500)", "500 ng/ml"],
							["Anfetamina (AMP 300)", "300 ng/ml", "Barbitúricos (BAR)", "300 ng/ml", "Benzodiazepínicos (BZO)", "300 ng/ml"],
							["Benzodiazepínicos (BZO 200)", "200 ng/ml", "Buprenorfina (BUP)", "10 ng/ml", "Cocaína (COC)", "300 ng/ml"],
							["Cocaína (COC 150)", "150 ng/ml", "Maconha (THC)", "50 ng/ml", "Metadona (MTD)", "300 ng/ml"],
							["Metanfetamina (MET)", "1000 ng/ml", "Metanfetamina (MET 500)", "500 ng/ml", "Metanfetamina (MET 300)", "300 ng/ml"],
							["Metilenodioximetanfetamina (MDMA)", "500 ng/ml", "Morfina (MOP 300)", "300 ng/ml", "Opiáceos (OPI 2000)", "2000 ng/ml"],
							["Oxicodona (OXY)", "100 ng/ml", "Fenciclidina (PCP)", "25 ng/ml", "Propoxifeno (PPX)", "300 ng/ml"],
							["Antidepressivos tricíclicos (TCA)", "1000 ng/ml", "-", "-", "-", "-"]]
		pdf.table(ref_table_data, cell_style: {size: 6, inline_format: true, height: 13, padding: 2})

		pdf.pad_top(40) {
			pdf.text("_____________________________________", :align => :right, size: 12)
			pdf.text("Responsável / Médico", :align => :right, size: 10)
			#pdf.text("#{@drug_test.selection.selection_responsible}", style: :bold)
			pdf.pad_top(5) {
				pdf.text(Time.now.day.to_s+" de " + I18n.localize(Time.now, format: "%B de ").downcase + Time.now.year.to_s, :align => :right, size: 10)
			}
		}
	}

end

