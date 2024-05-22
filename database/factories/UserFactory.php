<?php

namespace Database\Factories;

use Illuminate\Database\Eloquent\Factories\Factory;
use Illuminate\Support\Str;

/**
 * @extends \Illuminate\Database\Eloquent\Factories\Factory<\App\Models\User>
 */
class UserFactory extends Factory
{
    /**
     * Define the model's default state.
     *
     * @return array
     */
    public function definition()
    {
        return [
            'id_bbf_estad_acc' => 1,
            'nombres' => $this->faker->name(),/* $this->faker->unique()->safeEmail(),*/
            'apell_pat' => $this->faker->lastName(),/* $this->faker->unique()->safeEmail(),*/
            'apell_mat' => $this->faker->lastName(),/* $this->faker->unique()->safeEmail(),*/
            'dni' => $this->faker->randomNumber(8, true),
            'id_user_asign' => $this->faker->randomNumberBetween(1, 5),
            'id_user_call' => 0,
        ];
    }

    /**
     * Indicate that the model's email address should be unverified.
     *
     * @return \Illuminate\Database\Eloquent\Factories\Factory
     */
    public function unverified()
    {
        return $this->state(function (array $attributes) {
            return [
                'email_verified_at' => null,
            ];
        });
    }
}
