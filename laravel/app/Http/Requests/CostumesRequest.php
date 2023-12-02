//laravelproject\app\Http\Requests\PostStoreRequest.php
<?php
 
use App\Http\Requests;
 
use Illuminate\Foundation\Http\FormRequest;
 
class CostumesRequest extends FormRequest
{
    /**
     * Determine if the user is authorized to make this request.
     *
     * @return bool
     */
    public function authorize()
    {
        //return false;
        return true;
    }
 
    /**
     * Get the validation rules that apply to the request.
     *
     * @return array<string, mixed>
     */
    public function rules()
    {
        if(request()->isMethod('post')) {
            return [
                'image' => 'required|image|mimes:jpeg,png,jpg,gif,svg|max:2048',
            ];
        } else {
            return [
                'image' => 'nullable|image|mimes:jpeg,png,jpg,gif,svg|max:2048',
            ];
        }
    }
 
    /**
     * Custom message for validation
     *
     * @return array
     */
    public function messages()
    {
        if(request()->isMethod('post')) {
            return [
                'image.required' => 'Image is required!',
            ];
        } else {
            return [
                'name.required' => 'Name is required!',
                'description.required' => 'Descritpion is required!'
            ];   
        }
    }
}