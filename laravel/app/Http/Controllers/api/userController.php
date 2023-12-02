<?php

namespace App\Http\Controllers\api;

use App\Http\Controllers\Controller;
use App\Http\Resources\Resources;
use Illuminate\Http\Request;
use App\Models\User;

class userController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        //
        $users = User::get();
        $data = $users->map(function ($user) {
            return [
                'id' => $user->id,
                'name' => $user->name,
                'email' => $user->email,
                'password' => $user->password,
                'phone_number' => $user->phone_number,
            ];
        });
        return response()->json($data);
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        //
        $users = User::create([
            'name' => $request->name,
            'email' => $request->email,
            'password' => $request->password,
            'phone_number' => $request->phone_number,
        ]);
        return new Resources(true, 'Data mahasiswa berhasil ditambahkan!', $users);
    }

    /**
     * Display the specified resource.
     */
    public function show(string $id)
    {
        //
          // find mahasiswa by nim
          $user = User::find($id);

          // check if mahasiswa exists
          if (!$user) {
              return new Resources(false, 'Data mahasiswa tidak ditemukan', null);
          }
  
          // return single mahasiswa as a resource
          return new Resources(true, 'Detail data mahasiswa!', $user);
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, string $id)
    {
        //
        // find mahasiswa by nim
        $user = User::find($id);
        if (!$user) {
            return response()->json(['message' => 'Data tidak ditemukan'], 404);
        } else {
            // update mahasiswa
            $user->update(
                [
                    'name' => $request->name,
                    'email' => $request->email,
                    'password' => $request->password,
                    'phone_number' => $request->phone_number,
                ]
            );
        }
        return new Resources(true, 'Data mahasiswa berhasil ditambahkan!', $user);
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(string $id)
    {
        //
         // find mahasiswa by nim
         $user = User::find($id);

         // Check if mahasiswa exists
         if (!$user) {
             return response()->json(['message' => 'Data tidak ditemukan'], 404);
         }
         //delete post
         $user->delete();
 
         //return response
         return new Resources(true, 'Data berhasil dihapus!', null);
    }
}
