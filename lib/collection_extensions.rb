module TcmStudentWeb
  module AcuPointCollection
    def all_tags
      acu_point_infos.map{|api| api.therapeutic_functions.map_to(:tags)}.flatten.uniq
    end

  end
end

