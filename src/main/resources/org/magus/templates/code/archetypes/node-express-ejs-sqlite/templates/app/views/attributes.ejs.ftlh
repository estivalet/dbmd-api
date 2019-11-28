                            <div id="div-${attribute.name}" class="form-group">
                                <label for="name"><i id="i-${attribute.name}${append_id}"></i> ${attribute.label}</label>
                                <#if (attribute.type=="text")>
								<input type="text" class="form-control" id="${attribute.name}${append_id}" name="${attribute.name}${append_id}" placeholder="Enter ${attribute.name}" ${(index == 0)?then('autofocus','')} autocomplete="off">
								<#elseif (attribute.type=="listbox")>
							    <select class="form-control" id="${attribute.name}${append_id}">
								<#list attribute.options as option>
								<option value="${option.value}"> ${option.label}</option>
								</#list>	
							    </select>
								<#elseif (attribute.type=="date")>
								<div class="input-group">
                    				<div class="input-group-prepend">
                      					<span class="input-group-text"><i class="far fa-calendar-alt"></i></span>
                    				</div>
                    				<input type="text" id="${attribute.name}${append_id}" name="${attribute.name}${append_id}" class="form-control" data-inputmask-alias="datetime" data-inputmask-inputformat="${attribute.mask}" data-mask>
                  				</div>
								<#elseif (attribute.type=="radio")>
								<#list attribute.options as option>
								<div class="radio">
								<label><input type="radio" name="${attribute.name}${append_id}[]" value="${option.value}"> ${option.label}</label>
								</div>
								</#list>	
								<#elseif (attribute.type=="checkbox")>
								<#list attribute.options as option>
								<div class="form-check">
								<input type="checkbox" class="form-check-input" name="${attribute.name}${append_id}[]" value="${option.value}"> 
								<label class="form-check-label">${option.label}</label>
								</div>
								</#list>	
								<#elseif (attribute.type=="textarea")>
								<textarea class="form-control" id="${attribute.name}${append_id}" name="${attribute.name}${append_id}" rows="3" placeholder="Enter ${attribute.name}" ${(index == 0)?then('autofocus','')}></textarea>								
								<#elseif (attribute.type=="email")>
								<input type="text" class="form-control" id="${attribute.name}${append_id}" name="${attribute.name}${append_id}" placeholder="Enter ${attribute.name}" ${(index == 0)?then('autofocus','')} autocomplete="off">
								</#if>
								<#if (attribute.description?has_content)>
								<p id="p-${attribute.name}${append_id}" class="help-block">${attribute.description}.</p>
								</#if>
                            </div>