module ApplicationHelper
	def active_module?(module_path)
		request.path.start_with?(module_path)
	end
end
