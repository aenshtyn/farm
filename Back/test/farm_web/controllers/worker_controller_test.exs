defmodule FarmWeb.WorkerControllerTest do
  use FarmWeb.ConnCase

  import Farm.HRFixtures

  @create_attrs %{
    address: "some address",
    dob: ~N[2022-06-27 08:30:00],
    name: "some name",
    phone_number: 42,
    report_date: ~N[2022-06-27 08:30:00]
  }
  @update_attrs %{
    address: "some updated address",
    dob: ~N[2022-06-28 08:30:00],
    name: "some updated name",
    phone_number: 43,
    report_date: ~N[2022-06-28 08:30:00]
  }
  @invalid_attrs %{address: nil, dob: nil, name: nil, phone_number: nil, report_date: nil}

  describe "index" do
    test "lists all workers", %{conn: conn} do
      conn = get(conn, Routes.worker_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Workers"
    end
  end

  describe "new worker" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.worker_path(conn, :new))
      assert html_response(conn, 200) =~ "New Worker"
    end
  end

  describe "create worker" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.worker_path(conn, :create), worker: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.worker_path(conn, :show, id)

      conn = get(conn, Routes.worker_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Worker"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.worker_path(conn, :create), worker: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Worker"
    end
  end

  describe "edit worker" do
    setup [:create_worker]

    test "renders form for editing chosen worker", %{conn: conn, worker: worker} do
      conn = get(conn, Routes.worker_path(conn, :edit, worker))
      assert html_response(conn, 200) =~ "Edit Worker"
    end
  end

  describe "update worker" do
    setup [:create_worker]

    test "redirects when data is valid", %{conn: conn, worker: worker} do
      conn = put(conn, Routes.worker_path(conn, :update, worker), worker: @update_attrs)
      assert redirected_to(conn) == Routes.worker_path(conn, :show, worker)

      conn = get(conn, Routes.worker_path(conn, :show, worker))
      assert html_response(conn, 200) =~ "some updated address"
    end

    test "renders errors when data is invalid", %{conn: conn, worker: worker} do
      conn = put(conn, Routes.worker_path(conn, :update, worker), worker: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Worker"
    end
  end

  describe "delete worker" do
    setup [:create_worker]

    test "deletes chosen worker", %{conn: conn, worker: worker} do
      conn = delete(conn, Routes.worker_path(conn, :delete, worker))
      assert redirected_to(conn) == Routes.worker_path(conn, :index)

      assert_error_sent 404, fn ->
        get(conn, Routes.worker_path(conn, :show, worker))
      end
    end
  end

  defp create_worker(_) do
    worker = worker_fixture()
    %{worker: worker}
  end
end
