module AcuPointInfosHelper
  def resources
    [resource.acu_point, resource]
  end

  def new_api_path(*args)
    new_acu_point_acu_point_info_path(args)
  end

  def edit_api_path(*args)
    edit_acu_point_acu_point_info_path(args)
  end

  def apis_path(*args)
    acu_point_acu_point_infos_path(args)
  end

  def api_path(*args)
    acu_point_acu_point_info_path(args)
  end
end

