class Admin::CarriagesController < Admin::BaseController
  before_action :set_carriage, only: %i(show edit update destroy)
  before_action :set_train, only: %i(new create index)

  def index
    redirect_to [:admin, @train]
  end

  def show
  end

  def new
    @carriage = Carriage.new
  end

  def edit
  end

  def create
    @carriage = @train.carriages.new(carriage_params)
    if @carriage.save
      redirect_to [:admin, @carriage.train], notice: t(".notice")
    else
      render :new
    end
  end

  def update
    if @carriage.update(carriage_params)
      redirect_to [:admin, @carriage.train], notice: t(".notice")
    else
      render :edit
    end
  end

  def destroy
    train = @carriage.train
    @carriage.destroy
    redirect_to admin_train_path(train), notice: t(".notice")
  end

  private

  def set_carriage
    @carriage = Carriage.find(params[:id])
  end

  def set_train
    @train = Train.find(params[:train_id])
  end

  def carriage_params
    params.require(:carriage).permit(:type, :top_place, :lower_place,
                                     :side_top_places, :side_lower_places, :seats)
  end
end
